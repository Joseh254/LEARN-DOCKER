FROM node:22.23-alpine


# FROM specifies the starting image that Docker will use
# when building our own application image.
#
# Every Docker image must normally start from a base image.
# A base image provides an operating system environment and
# other software that our application needs.
# node       -> This image already contains Node.js.
# 22.23      -> We want Node.js version 22.23.
# alpine     -> The image uses Alpine Linux, which is a
#               lightweight Linux distribution.


WORKDIR /logitechapp

# WORKDIR changes the current working directory inside
# the Docker image/container.
# It is similar to running this command in a terminal:
# cd /logitechapp
# After this instruction, Docker considers:
# /logitechapp
# to be the current directory for subsequent instructions.
# This means that commands you run will execute on folder logitechapp

COPY package*.json ./

# COPY copies files from the computer where Docker is being
# built (the host machine) into the Docker image.
# package*.json contains two important parts:
# package.json
# package-lock.json
# The * is a wildcard character.
# It means:
# "Match package.json and any filename that starts with
# package and ends with .json."
# In a typical Node.js project, this matches:
# package.json
# package-lock.json
# The wildcard is useful because package-lock.json may exist
# while other package-related JSON files may also be present.
# The first argument:
# package*.json
# refers to files on the host computer, inside the Docker
# build context.
# The second argument:
# ./
# means "copy the files into the current directory inside
# the image."
# Because WORKDIR was set to /logitechapp above, ./ means:
# /logitechapp/
# Therefore, this instruction effectively copies:
# package.json
# package-lock.json
# from the host machine into:
# /logitechapp/
# inside the Docker image.
# Why do we copy these files separately before copying the
# rest of the application?
# Docker builds images in layers and caches those layers.
# Dependencies usually change less frequently than source code.
# If we copy package files and install dependencies in an
# earlier layer, Docker can reuse the cached dependency layer
# when only application source code changes.
# This makes future builds much faster.




RUN npm install


# RUN executes a command while Docker is BUILDING the image.
# This is different from CMD, which runs when a container
# is STARTED.
# npm install reads package.json and package-lock.json,
# downloads the required dependencies, and installs them
# inside the image.
# For example, our application may depend on:
# express
# dotenv
# @prisma/client
# prisma
# and other packages.
# These packages are installed inside:
# /logitechapp/node_modules
# inside the Docker image.
# The dependencies installed here belong to the image.
# Docker is not using the node_modules folder from the
# host computer.
# This is useful because the host machine might be running
# Windows, while the container is running Linux Alpine.
# Installing dependencies inside the container ensures that
# the dependencies are installed for the environment where
# the application will actually run.


COPY . .


# COPY . .
# The first dot means:
# "The current directory on the host machine."
# This is the directory from which the Docker build command
# was executed, assuming that directory is the build context.
# For example, if your project looks like this on your computer:
# project/
# ├── Dockerfile
# ├── package.json
# ├── package-lock.json
# ├── index.js
# ├── routes/
# ├── prisma/
# └── ...
# then the first dot represents the project directory.
# The second dot means:
# "The current working directory inside the image."
# Since WORKDIR was set to /logitechapp, the files are copied
# into:
# /logitechapp/
# Therefore:
# COPY . .
# means:
# Copy all files and folders from the host build context
# into /logitechapp inside the Docker image.
# After this instruction, the image may look like:
# /logitechapp/
# ├── node_modules/
# ├── package.json
# ├── package-lock.json
# ├── index.js
# ├── routes/
# ├── prisma/
# └── ...
# The node_modules folder already exists because npm install
# was executed in the previous step.
# A .dockerignore file should be used to prevent unnecessary
# files such as local node_modules, .git, logs, and .env files
# from being copied into the image.


RUN npx prisma generate

# RUN npx prisma generate executes Prisma's client-generation
# command during the image build process.
# Prisma uses the schema file, usually located at:
# prisma/schema.prisma
# to generate Prisma Client.
# Prisma Client is the code that our Node.js application uses
# to communicate with the PostgreSQL database.
# For example, when our application writes:
# prisma.product.findMany()
# that functionality is provided by the generated Prisma
# Client.
# Why generate Prisma Client inside the Docker image?
# Because the container may use a different operating system
# from the host machine.
# For example:
# Host machine:
# Windows
# Docker container:
# Linux Alpine
# Prisma may need platform-specific engine binaries.
# Generating Prisma Client inside the container helps ensure
# that the correct client and query engine are generated for
# the container's environment.
# Important distinction:
# prisma generate DOES NOT create database tables.
# It only generates the Prisma Client code.
# Database tables are created or updated using migrations,
# which are handled later by:
# npx prisma migrate deploy


EXPOSE 3000

# EXPOSE 3000 documents that the application inside the
# container is expected to listen on port 3000.
# In our index.js file, we have:
# const port = process.env.PORT || 5000;
# And in our environment configuration:
# PORT=3000
# Therefore, the Express application listens on port 3000
# inside the container.
# Important:
# EXPOSE does NOT actually publish the port to the host
# computer.
# It is mainly documentation and metadata telling Docker:
# "This application is expected to use port 3000."
# To make the application accessible from the host machine,
# we still need a port mapping in docker-compose.yml:
# ports:
#   - 3000:3000
# The mapping means:
# host port 3000 -> container port 3000
# So a request to:
# http://localhost:3000
# on the host computer is forwarded to port 3000 inside
# the container.




CMD npx prisma migrate deploy && node index.js


# CMD specifies the default command that should execute
# when a container is started from this image.
# Unlike RUN:
# RUN executes during image BUILD time.
# CMD executes during container RUNTIME.
# Our command is:
# npx prisma migrate deploy && node index.js
# It contains two commands connected using &&.
# First command:
# npx prisma migrate deploy
# This applies any pending Prisma migrations to the database.
# For example, if we added a new field to a Prisma model and
# created a migration, this command applies that migration
# when the container starts.
# Second command:
# node index.js
# This starts our Express application.
# The && operator means:
# "Run the second command only if the first command succeeds."
# Therefore:
# If database migrations succeed:
#     Start the Express server.
# If database migrations fail:
#     Do not start the Express server.
# This is useful because the application should not start
# if the database structure is not ready or migrations fail.

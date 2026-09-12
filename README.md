# Docker Comprehensive Notes for Beginners

## Practical Project: Express, Prisma, PostgreSQL and Docker Compose

---

# 1. Introduction to Docker

Docker is a platform used to package, distribute, and run applications in isolated environments called containers.

To understand why Docker exists, imagine developing an application on your computer.

Your application may require:

* Node.js version 22
* PostgreSQL
* Prisma
* Express
* Specific operating system libraries
* Environment variables
* Particular dependency versions
* Specific database configuration

Your application works perfectly on your computer.

You send it to another developer, but it fails.

The other developer may say:

> It works on your machine, but it does not work on mine.

This can happen because the two computers have different:

* Operating systems
* Node.js versions
* Database versions
* Environment variables
* Installed libraries
* Dependency versions
* File paths
* Network configurations

Docker attempts to solve this problem by packaging the application and its environment into a predictable unit.

Instead of saying:

> Install Node.js, install PostgreSQL, install these dependencies, configure this database, create this folder, and use this version.

You can package the application into a Docker image and run it as a container.

The goal becomes:

> Run this container.

---

# 2. What Problem Does Docker Solve?

Without Docker, deploying an application often looks like this:

```text
Server
 ├── Install Node.js
 ├── Install npm
 ├── Install PostgreSQL
 ├── Create database
 ├── Configure database user
 ├── Configure password
 ├── Install application dependencies
 ├── Configure environment variables
 ├── Start application
 └── Hope everything works
```

With Docker, the process becomes more consistent:

```text
Docker Engine
 ├── Application Container
 │    ├── Node.js
 │    ├── Express
 │    ├── Prisma
 │    └── Application code
 │
 └── PostgreSQL Container
      └── PostgreSQL database
```

The application and database can run as separate containers while communicating over a Docker network.

---

# 3. Understanding the Main Docker Concepts

Before using Docker, understand these important terms:

1. Docker Engine
2. Docker CLI
3. Docker Image
4. Docker Container
5. Dockerfile
6. Docker Compose
7. Docker Network
8. Docker Volume
9. Docker Registry
10. Docker Desktop

---

# 4. Docker Engine

The Docker Engine is the actual system responsible for running containers.

It performs tasks such as:

* Creating containers
* Starting containers
* Stopping containers
* Managing images
* Creating networks
* Managing volumes
* Connecting containers
* Reading Dockerfiles
* Executing container commands

You interact with Docker Engine through the Docker command-line interface.

For example:

```bash
docker ps
```

This command asks the Docker Engine:

> Show me the currently running containers.

Another example:

```bash
docker run nginx
```

This tells the Docker Engine:

> Create and start a container using the nginx image.

---

# 5. Docker CLI

CLI means Command Line Interface.

The Docker CLI is the command you type in your terminal.

Examples include:

```bash
docker images
docker ps
docker build
docker run
docker stop
docker rm
docker logs
```

The CLI does not itself run the container directly. It communicates with the Docker Engine.

The relationship is:

```text
Your Terminal
     |
     v
Docker CLI
     |
     v
Docker Engine
     |
     v
Containers
```

---

# 6. Docker Desktop

On Windows, most beginners use Docker Desktop.

Docker Desktop provides a graphical application and includes important Docker components such as:

* Docker Engine
* Docker CLI
* Docker Compose
* Docker networking
* Docker volume management
* Integration with WSL 2

Docker Desktop makes it easier to run Linux containers on Windows.

Docker containers commonly use Linux-based images, even when the developer is using Windows.

---

# 7. What Is a Docker Image?

A Docker image is a read-only template used to create containers.

An image contains the instructions and files required to run an application.

For example, an image may contain:

* A Linux filesystem
* Node.js
* npm
* Application dependencies
* Application source code
* Configuration files
* Startup instructions

Think of an image as a blueprint or packaged application template.

Example:

```text
Node.js Image
 ├── Linux base files
 ├── Node.js runtime
 ├── npm
 └── Supporting libraries
```

Your application image may look like:

```text
Application Image
 ├── Node.js
 ├── Express
 ├── Prisma
 ├── package.json
 ├── node_modules
 ├── index.js
 ├── routes
 └── Prisma files
```

An image does not run by itself.

A container is created from an image.

---

# 8. What Is a Container?

A container is a running instance of an image.

The difference can be understood using this example:

```text
Image = Class
Container = Object created from the class
```

Or:

```text
Image = Recipe
Container = Actual prepared meal
```

Or:

```text
Image = Application template
Container = Running application
```

For example:

```bash
docker run nginx
```

Docker uses the nginx image to create and start a container.

The image may exist once, but you can create multiple containers from it.

```text
nginx Image
 ├── Container 1
 ├── Container 2
 └── Container 3
```

Each container is an isolated running environment.

---

# 9. Containers Are Not Virtual Machines

A common beginner misunderstanding is thinking that every container is a complete virtual computer.

Containers are not the same as virtual machines.

A virtual machine usually includes:

* A complete guest operating system
* Its own kernel
* Virtual hardware
* Applications
* Libraries

Containers share the host operating system kernel, while isolating processes and filesystems.

Conceptually:

```text
Virtual Machines

Physical Computer
 ├── Host Operating System
 ├── Virtual Machine 1
 │    ├── Guest OS
 │    └── Application
 └── Virtual Machine 2
      ├── Guest OS
      └── Application
```

Containers:

```text
Physical Computer
 ├── Host Operating System
 └── Docker Engine
      ├── Container 1
      │    └── Application
      ├── Container 2
      │    └── Application
      └── Container 3
           └── Application
```

Containers are generally lighter and faster to start than virtual machines because they do not need to boot a complete operating system for every application.

---

# 10. Why Windows Uses WSL 2

Docker containers are commonly Linux-based.

Windows does not natively use the Linux kernel in the same way Linux does. Docker Desktop therefore commonly uses WSL 2 to provide a lightweight Linux environment.

WSL means:

> Windows Subsystem for Linux

WSL allows Linux distributions such as Ubuntu to run inside Windows.

WSL 2 uses a lightweight virtualized Linux kernel and provides better compatibility with Linux-based development tools.

The relationship is approximately:

```text
Windows
 └── Docker Desktop
      └── WSL 2
           └── Linux Kernel
                └── Docker Engine
                     └── Linux Containers
```

This is why Docker Desktop on Windows may require:

* CPU virtualization
* WSL 2
* Virtual Machine Platform
* Windows Subsystem for Linux

---

# 11. CPU Virtualization

CPU virtualization is a processor feature that allows your computer to run virtualized environments efficiently.

Docker Desktop and WSL 2 may require virtualization support to be enabled.

Depending on your processor, the feature may be called:

For Intel processors:

```text
Intel Virtualization Technology
Intel VT-x
```

For AMD processors:

```text
SVM Mode
AMD-V
```

If virtualization is disabled, Docker Desktop may fail to start or WSL 2 may not work correctly.

---

# 12. How to Enable Virtualization in BIOS or UEFI

The exact process differs depending on the computer manufacturer.

General steps:

1. Shut down or restart the computer.
2. Turn it on.
3. Immediately press the BIOS or UEFI key.
4. Common keys include:

```text
F2
Delete
F10
F12
Esc
```

5. Open an area such as:

```text
Advanced
Security
CPU Configuration
Processor Configuration
System Configuration
```

6. Find the virtualization option.

For Intel:

```text
Intel Virtualization Technology
```

For AMD:

```text
SVM Mode
```

7. Change it to:

```text
Enabled
```

8. Save changes.
9. Exit BIOS or UEFI.
10. Allow Windows to boot.

Some computers use:

```text
F10 = Save and Exit
```

However, the exact key depends on the manufacturer.

---

# 13. Confirming Virtualization in Windows Task Manager

After enabling virtualization:

1. Press:

```text
Ctrl + Shift + Esc
```

2. Open Task Manager.
3. Click:

```text
Performance
```

4. Select:

```text
CPU
```

5. Look for:

```text
Virtualization: Enabled
```

You should see something similar to:

```text
Cores: 4
Logical processors: 8
Virtualization: Enabled
```

If it says:

```text
Virtualization: Disabled
```

you may need to enable it in BIOS or UEFI.

---

# 14. Installing WSL 2

Open PowerShell as Administrator.

Run:

```powershell
wsl --install
```

This command usually enables the required Windows components and installs a default Linux distribution.

Restart the computer if requested.

After restarting, update WSL:

```powershell
wsl --update
```

Set WSL 2 as the default version:

```powershell
wsl --set-default-version 2
```

Check the WSL status:

```powershell
wsl --status
```

List installed distributions:

```powershell
wsl --list --verbose
```

Example output:

```text
NAME      STATE           VERSION
Ubuntu    Running         2
```

The important value is:

```text
VERSION 2
```

---

# 15. Installing Ubuntu Manually

If Ubuntu was not installed automatically, use:

```powershell
wsl --install -d Ubuntu
```

After installation, Ubuntu may ask you to create:

* A Linux username
* A Linux password

These credentials are for the Linux environment and are separate from your Windows password.

You can launch Ubuntu by searching for:

```text
Ubuntu
```

in the Windows Start Menu.

---

# 16. Enabling WSL Features Manually

If `wsl --install` fails, open PowerShell as Administrator and run:

```powershell
dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart
```

Then:

```powershell
dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart
```

Restart Windows.

Then run:

```powershell
wsl --set-default-version 2
```

---

# 17. Installing Docker Desktop

Install Docker Desktop for Windows.

During installation, enable or select the WSL 2 backend if prompted.

After installation:

1. Open Docker Desktop.
2. Wait until Docker finishes starting.
3. Open Settings.
4. Confirm that WSL 2 integration is enabled.
5. If available, enable integration with your Ubuntu distribution.

Docker Desktop must be running for Docker commands to work on Windows.

---

# 18. Verify Docker Installation

Open PowerShell, Command Prompt, Git Bash, or a WSL terminal.

Run:

```bash
docker --version
```

Example:

```text
Docker version 28.x.x
```

Check Docker Compose:

```bash
docker compose version
```

Run the official test image:

```bash
docker run hello-world
```

If successful, Docker will download an image and run a small container that prints a confirmation message.

This confirms that:

* Docker CLI is installed
* Docker Engine is running
* Docker can download images
* Docker can create containers
* Docker can execute containers

---

# 19. Docker Registries

A Docker registry is a place where Docker images are stored.

The most popular public registry is Docker Hub.

Examples of images available from registries:

```text
node
postgres
nginx
redis
mysql
ubuntu
```

When you write:

```dockerfile
FROM node:22.23-alpine
```

Docker searches for the image from a registry if it does not already exist locally.

Similarly, this Compose configuration:

```yaml
image: postgres:16-alpine
```

means:

> Download and use the PostgreSQL 16 Alpine image.

---

# 20. Understanding Image Tags

Consider:

```text
node:22.23-alpine
```

This consists of:

```text
Image name: node
Version tag: 22.23
Variant: alpine
```

Another example:

```text
postgres:16-alpine
```

means:

```text
Image: postgres
Version: 16
Base variant: alpine
```

Tags help specify which version or variant of an image should be used.

Using a specific version is safer than using:

```dockerfile
FROM node:latest
```

because `latest` can change over time and potentially introduce unexpected breaking changes.

---

# 21. What Is Alpine Linux?

Alpine Linux is a small Linux distribution commonly used as a Docker base image.

For example:

```dockerfile
FROM node:22.23-alpine
```

means:

> Use Node.js version 22.23 built on Alpine Linux.

Advantages of Alpine images may include:

* Smaller image size
* Fewer unnecessary packages
* Faster downloads
* Reduced storage usage

However, Alpine can sometimes create compatibility problems with native dependencies because it uses musl libc instead of glibc.

This matters for packages that depend on operating system libraries, including some database drivers, image-processing libraries, and cryptographic packages.

---

# 22. What Is a Dockerfile?

A Dockerfile is a text file containing instructions used to build a Docker image.

It describes:

* Which base image to use
* Where the application should live
* Which files to copy
* Which dependencies to install
* Which commands to execute
* Which port the application uses
* Which command starts the application

A Dockerfile is similar to a recipe.

For your project:

```dockerfile
FROM node:22.23-alpine

WORKDIR /logitechapp

COPY package*.json ./

RUN npm install

COPY . .

RUN npx prisma generate

EXPOSE 3000

CMD npx prisma migrate deploy && node index.js
```

This file describes how Docker should package your Express and Prisma application.

---

# 23. Explaining the Dockerfile Line by Line

## 23.1 FROM

```dockerfile
FROM node:22.23-alpine
```

`FROM` defines the base image.

Your application requires Node.js, so instead of installing Node.js manually, you start from an image that already contains Node.js.

The base image provides:

* Linux environment
* Node.js
* npm
* Required basic operating system files

Without `FROM`, Docker would not know the starting point for the image.

---

## 23.2 WORKDIR

```dockerfile
WORKDIR /logitechapp
```

This sets the working directory inside the image and container.

It is similar to running:

```bash
cd /logitechapp
```

All subsequent commands operate from this directory unless another directory is specified.

For example:

```dockerfile
COPY package*.json ./
```

copies the files into:

```text
/logitechapp
```

The directory does not need to exist beforehand. Docker creates it if necessary.

---

## 23.3 COPY package*.json

```dockerfile
COPY package*.json ./
```

This copies package-related files from your computer into the image.

The pattern:

```text
package*.json
```

usually matches:

```text
package.json
package-lock.json
```

The destination:

```text
./
```

means the current working directory, which is:

```text
/logitechapp
```

At this stage, the image may contain:

```text
/logitechapp
 ├── package.json
 └── package-lock.json
```

---

## 23.4 Why Copy package Files First?

This is an important Docker optimization.

Docker builds images in layers.

Each Dockerfile instruction creates a layer.

If you copy the entire project before installing dependencies:

```dockerfile
COPY . .
RUN npm install
```

then any small source code change may invalidate the cache and cause npm install to run again.

Instead, you copy only dependency files first:

```dockerfile
COPY package*.json ./
RUN npm install
COPY . .
```

This allows Docker to reuse the dependency installation layer if package files have not changed.

Example:

```text
First build:
Copy package files
Install dependencies
Copy source code
```

Later, if only `index.js` changes:

```text
Copy package files: cached
Install dependencies: cached
Copy source code: rebuilt
```

This makes builds faster.

---

## 23.5 RUN npm install

```dockerfile
RUN npm install
```

`RUN` executes a command while building the image.

This installs the dependencies defined in `package.json`.

For your application, these may include:

```text
express
dotenv
prisma
@prisma/client
```

The dependencies become part of the image.

Important distinction:

```dockerfile
RUN npm install
```

runs during image creation.

It does not run every time the container starts.

---

## 23.6 COPY . .

```dockerfile
COPY . .
```

This copies the application source code from the build context into the image.

For example:

```text
Local Project
 ├── index.js
 ├── routes
 ├── prisma
 ├── package.json
 └── package-lock.json
```

becomes:

```text
/logitechapp
 ├── index.js
 ├── routes
 ├── prisma
 ├── package.json
 ├── package-lock.json
 └── node_modules
```

The first dot means:

> Current directory on the host

The second dot means:

> Current working directory inside the image

---

# 24. The Docker Build Context

When you run:

```bash
docker build .
```

the final dot means:

> Use the current directory as the build context.

Docker sends files from that directory to the Docker build process.

This is why `.dockerignore` is important.

Without `.dockerignore`, Docker may send unnecessary files such as:

* `node_modules`
* `.git`
* `.env`
* Logs
* Build output
* Temporary files

---

# 25. The .dockerignore File

A recommended `.dockerignore` for your project:

```text
node_modules
npm-debug.log
.env
.env.*
!.env.example
.git
.gitignore
Dockerfile*
docker-compose*.yml
coverage
.nyc_output
.next
dist
```

The purpose is similar to `.gitignore`, but it controls what Docker excludes from the build context.

For example:

```text
node_modules
```

should usually be excluded because dependencies installed on Windows may not be compatible with the Linux environment inside the container.

Docker should install dependencies inside the container using:

```dockerfile
RUN npm install
```

not copy Windows-installed dependencies into a Linux container.

---

# 26. Why .env Should Usually Be Excluded

Your `.env` contains sensitive values:

```env
POSTGRES_PASSWORD=password
DATABASE_URL=...
```

Copying `.env` into an image can expose secrets.

Instead, Docker Compose injects environment variables into the container at runtime:

```yaml
environment:
  - PORT=${PORT}
  - DATABASE_URL=${DATABASE_URL}
```

This means the `.env` file is used by Compose on the host, but does not need to be copied into the image.

---

# 27. Prisma Generate

Your Dockerfile contains:

```dockerfile
RUN npx prisma generate
```

Prisma Client is generated based on your Prisma schema.

For example, Prisma reads:

```text
prisma/schema.prisma
```

and generates a client that your application uses to communicate with the database.

The generated client may contain platform-specific components.

Running:

```dockerfile
RUN npx prisma generate
```

inside the image ensures that Prisma Client is generated in the environment where the application will run.

This is especially important when your host operating system is Windows but your container is Linux.

---

# 28. EXPOSE

```dockerfile
EXPOSE 3000
```

This documents that the application is expected to listen on port 3000 inside the container.

It does not automatically publish the port to your computer.

This is a common misunderstanding.

`EXPOSE` is documentation and metadata.

To make the application accessible from your host machine, you still need:

```yaml
ports:
  - 3000:3000
```

in Docker Compose, or:

```bash
docker run -p 3000:3000 image-name
```

---

# 29. CMD

Your Dockerfile contains:

```dockerfile
CMD npx prisma migrate deploy && node index.js
```

`CMD` defines the default command executed when the container starts.

The command means:

1. Run Prisma migrations.
2. If migrations succeed, start the Express server.

The `&&` operator means:

> Execute the second command only if the first command succeeds.

Conceptually:

```text
Start container
    |
    v
Run Prisma migrations
    |
    ├── Failure -> Container stops
    |
    └── Success
          |
          v
     Start Express
```

A more explicit version is:

```dockerfile
CMD ["sh", "-c", "npx prisma migrate deploy && node index.js"]
```

This explicitly tells the container to use the shell to execute the chained commands.

---

# 30. What Is Docker Compose?

Docker Compose is a tool used to define and run multiple related containers.

Your project requires:

1. An Express application
2. A PostgreSQL database

Without Compose, you would need to manually create and configure each container.

With Compose, you describe the entire application environment in one YAML file.

Your file is:

```text
docker-compose.yml
```

Compose allows you to define:

* Services
* Images
* Builds
* Ports
* Environment variables
* Volumes
* Networks
* Dependencies
* Restart policies

---

# 31. Why Your Project Needs Two Containers

Your application and database perform different responsibilities.

The Express container handles:

* HTTP requests
* Business logic
* Routes
* Prisma calls
* API responses

The PostgreSQL container handles:

* Data storage
* SQL queries
* Tables
* Transactions
* Database persistence

The architecture is:

```text
Client
  |
  v
Express Container
  |
  v
Prisma
  |
  v
PostgreSQL Container
```

This separation is useful because each service can be managed independently.

For example:

* Restart the application without deleting the database
* Upgrade the application without rebuilding PostgreSQL
* Move the database to another server later
* Scale the application separately
* Back up the database independently

---

# 32. Understanding Your docker-compose.yml

Your Compose file:

```yaml
services:
  logitech:
    build: .
    container_name: logitech_server
    ports:
      - 3000:3000
    environment:
      - PORT=${PORT}
      - DATABASE_URL=${DATABASE_URL}
    depends_on:
      - database

  database:
    image: postgres:16-alpine
    container_name: logitech_db
    restart: always
    environment:
      - POSTGRES_USER=${POSTGRES_USER}
      - POSTGRES_PASSWORD=${POSTGRES_PASSWORD}
      - POSTGRES_DB=${POSTGRES_DB}
    ports:
      - 5433:5432
    volumes:
      - postgres_volume:/var/lib/postgresql/data

volumes:
  postgres_volume:
```

---

# 33. The services Section

```yaml
services:
```

This defines the containers that make up the application.

Each item under `services` represents a service.

Your services are:

```yaml
logitech:
database:
```

The names are important because Docker Compose uses them as service identifiers and internal DNS names.

---

# 34. The logitech Service

```yaml
logitech:
```

This is the application service.

It represents your Express server.

The name `logitech` is not necessarily the container name. It is the Compose service name.

Inside the Docker network, other containers can refer to this service using:

```text
logitech
```

---

# 35. build: .

```yaml
build: .
```

This tells Compose to build the application image using the Dockerfile in the current directory.

The dot means:

> Use the current project directory as the build context.

Compose looks for a file named:

```text
Dockerfile
```

in that directory.

The process is:

```text
docker-compose.yml
       |
       v
build: .
       |
       v
Dockerfile
       |
       v
Application Image
       |
       v
Application Container
```

---

# 36. container_name

```yaml
container_name: logitech_server
```

This assigns a custom name to the container.

Without a custom name, Docker Compose may generate a name such as:

```text
project-logitech-1
```

With this configuration, the container is named:

```text
logitech_server
```

You can then run:

```bash
docker logs logitech_server
```

or:

```bash
docker exec -it logitech_server sh
```

---

# 37. Ports Mapping

```yaml
ports:
  - 3000:3000
```

Port mapping follows this structure:

```text
HOST_PORT:CONTAINER_PORT
```

Therefore:

```text
3000:3000
```

means:

```text
Port 3000 on your computer
        |
        v
Port 3000 inside the container
```

Your Express application listens on:

```js
const port = process.env.PORT || 5000;
```

If `PORT=3000`, Express listens on port 3000 inside the container.

Docker forwards requests from:

```text
http://localhost:3000
```

to the container's port 3000.

---

# 38. Changing the Host Port

You could use:

```yaml
ports:
  - 8080:3000
```

This means:

```text
Host port 8080 -> Container port 3000
```

The application still listens on port 3000 inside the container.

You would access it using:

```text
http://localhost:8080
```

The two ports do not have to be identical.

---

# 39. Environment Variables in Compose

Your application service contains:

```yaml
environment:
  - PORT=${PORT}
  - DATABASE_URL=${DATABASE_URL}
```

`${PORT}` means Compose reads the value from the `.env` file or the shell environment.

For example:

```env
PORT=3000
```

becomes:

```yaml
environment:
  - PORT=3000
```

Inside the container:

```js
process.env.PORT
```

returns:

```text
3000
```

Similarly:

```js
process.env.DATABASE_URL
```

returns the database connection string.

---

# 40. Understanding the Database URL

This is one of the most important Docker concepts.

When the application runs outside Docker and PostgreSQL runs inside Docker, you may use:

```env
DATABASE_URL=postgresql://user:password@localhost:5433/postgres?schema=public
```

But when both the application and PostgreSQL run inside Docker, you should use:

```env
DATABASE_URL=postgresql://user:password@database:5432/postgres?schema=public
```

Why?

Because `localhost` means different things depending on where the application runs.

---

# 41. The Localhost Trap

Inside a container:

```text
localhost
```

means:

> This same container.

It does not mean your Windows computer.

It also does not mean another container.

Suppose your application container tries:

```text
localhost:5433
```

It is looking for PostgreSQL inside the application container itself.

But PostgreSQL is running in a separate container.

Therefore, the connection fails.

The correct hostname is the Compose service name:

```text
database
```

Thus:

```env
DATABASE_URL=postgresql://user:password@database:5432/postgres?schema=public
```

means:

```text
Connect to the database service on port 5432.
```

---

# 42. Why Use database:5432 Instead of localhost:5433?

Your database service contains:

```yaml
ports:
  - 5433:5432
```

This means:

```text
Host computer port 5433
        |
        v
PostgreSQL container port 5432
```

Port 5433 is only the host-facing port.

Inside the Docker network, PostgreSQL is still listening on its normal internal port:

```text
5432
```

Therefore:

```text
Application container -> database:5432
```

is correct.

The host port 5433 is used when connecting from your Windows computer.

Example:

```text
Windows PostgreSQL client -> localhost:5433
```

But:

```text
Express container -> database:5432
```

---

# 43. External and Internal Database URLs

You can think of the two connection scenarios as follows.

## Application Running on Windows, Database in Docker

```text
Node.js on Windows
       |
       v
localhost:5433
       |
       v
PostgreSQL Container:5432
```

Use:

```env
DATABASE_URL=postgresql://user:password@localhost:5433/postgres?schema=public
```

## Application and Database Both in Docker

```text
Express Container
       |
       v
database:5432
       |
       v
PostgreSQL Container
```

Use:

```env
DATABASE_URL=postgresql://user:password@database:5432/postgres?schema=public
```

---

# 44. The database Service

Your database service:

```yaml
database:
  image: postgres:16-alpine
```

This means Compose should create the database container from the PostgreSQL image.

Unlike the application service, you are not building PostgreSQL from your own Dockerfile.

You are using an existing official image.

---

# 45. PostgreSQL Environment Variables

```yaml
environment:
  - POSTGRES_USER=${POSTGRES_USER}
  - POSTGRES_PASSWORD=${POSTGRES_PASSWORD}
  - POSTGRES_DB=${POSTGRES_DB}
```

The official PostgreSQL image uses these variables during initialization.

For example:

```env
POSTGRES_USER=user
POSTGRES_PASSWORD=password
POSTGRES_DB=postgres
```

This creates a database configuration with:

```text
Username: user
Password: password
Database: postgres
```

These values are used when PostgreSQL initializes its data directory for the first time.

---

# 46. Important PostgreSQL Volume Behavior

PostgreSQL initialization variables are generally applied only when the database data directory is empty.

If the database already exists in a persistent volume, changing:

```env
POSTGRES_PASSWORD
```

may not change the existing database password.

This surprises many beginners.

For example:

1. Start PostgreSQL with password `password`.
2. PostgreSQL stores data in a volume.
3. Change the password in `.env`.
4. Restart the container.
5. PostgreSQL still uses the original initialized credentials.

The reason is that the database has already been initialized.

---

# 47. restart: always

```yaml
restart: always
```

This tells Docker to restart the database container automatically if it stops unexpectedly.

This is useful for services such as databases that should remain available.

However, restart policies should be used carefully in production because they do not solve every type of failure.

For example, a container may repeatedly restart because of an invalid configuration.

---

# 48. The Database Port Mapping

```yaml
ports:
  - 5433:5432
```

This exposes PostgreSQL to the host machine.

The mapping is:

```text
Windows port 5433
       |
       v
Container port 5432
```

You can connect from a database client on Windows using:

```text
Host: localhost
Port: 5433
```

Examples of clients include:

* DBeaver
* pgAdmin
* TablePlus
* Prisma Studio
* Another local application

Inside Docker, use:

```text
database:5432
```

---

# 49. Docker Volumes

Your Compose file contains:

```yaml
volumes:
  - postgres_volume:/var/lib/postgresql/data
```

This is extremely important.

Containers are designed to be disposable.

If you remove a container, the data stored only inside that container may disappear.

A database cannot depend on the container filesystem alone because deleting and recreating the container could delete the database.

A volume provides persistent storage outside the container's temporary writable layer.

---

# 50. Understanding the PostgreSQL Volume Path

PostgreSQL stores its database data inside the container at:

```text
/var/lib/postgresql/data
```

Your Compose configuration maps:

```yaml
postgres_volume:/var/lib/postgresql/data
```

This means:

```text
Docker Volume: postgres_volume
          |
          v
PostgreSQL data directory inside container
```

The data survives even if the database container is removed and recreated.

---

# 51. Container Without a Volume

Without a volume:

```text
PostgreSQL Container
 └── Database files
```

If the container is deleted:

```bash
docker rm database-container
```

the database files may be lost.

With a volume:

```text
Docker Volume
 └── Database files

PostgreSQL Container
 └── Uses the volume
```

If the container is deleted, the volume can remain.

A new container can attach to the same volume.

---

# 52. Named Volumes

This section:

```yaml
volumes:
  postgres_volume:
```

declares a named Docker volume.

Docker manages the physical location of the volume.

You do not need to manually choose a Windows folder.

Docker handles the storage location.

You can list volumes using:

```bash
docker volume ls
```

---

# 53. docker-compose down Versus down -v

This command:

```bash
docker compose down
```

usually removes:

* Containers
* Compose network

It normally preserves named volumes.

This command:

```bash
docker compose down -v
```

also removes named volumes.

For your project:

```bash
docker compose down -v
```

can delete the PostgreSQL volume and therefore delete the database data.

Use it carefully.

It is useful when you want a completely fresh database, but dangerous if you have important data.

---

# 54. Docker Networks

When Docker Compose starts your services, it usually creates a private network automatically.

For example:

```text
logitech_default
```

Both services join the same network:

```text
Application Container
       |
       | Docker Network
       |
Database Container
```

Containers on the same Compose network can communicate using service names.

That is why this works:

```env
DATABASE_URL=postgresql://user:password@database:5432/postgres?schema=public
```

The hostname:

```text
database
```

is resolved by Docker's internal DNS.

---

# 55. Docker Service Names Act as Hostnames

Your Compose service is:

```yaml
database:
```

Therefore, other services can reach it using:

```text
database
```

If the service were named:

```yaml
postgres:
```

then the connection hostname would be:

```text
postgres
```

The hostname is the service name, not necessarily the container name.

This is why Compose service names should be descriptive and stable.

---

# 56. depends_on

Your application contains:

```yaml
depends_on:
  - database
```

This tells Compose that the application depends on the database service.

Compose starts the database service before starting the application service.

However, a critical detail is that basic `depends_on` does not necessarily mean PostgreSQL is fully ready to accept connections.

It mainly controls startup order.

The database container may have started, but PostgreSQL may still be initializing.

---

# 57. Startup Order Versus Readiness

Consider this sequence:

```text
Database container starts
       |
       | PostgreSQL is still initializing
       |
Application container starts
       |
       v
Prisma migration runs
       |
       v
Connection refused
```

The database container is technically running, but PostgreSQL is not ready yet.

This is why production applications often use health checks.

---

# 58. Health Checks

A health check allows Docker to determine whether a service is actually ready.

Example:

```yaml
database:
  image: postgres:16-alpine
  container_name: logitech_db
  restart: always
  environment:
    - POSTGRES_USER=${POSTGRES_USER}
    - POSTGRES_PASSWORD=${POSTGRES_PASSWORD}
    - POSTGRES_DB=${POSTGRES_DB}
  ports:
    - 5433:5432
  volumes:
    - postgres_volume:/var/lib/postgresql/data
  healthcheck:
    test: ["CMD-SHELL", "pg_isready -U user -d postgres"]
    interval: 5s
    timeout: 5s
    retries: 10
```

Then the application can depend on the database health:

```yaml
logitech:
  build: .
  container_name: logitech_server
  ports:
    - 3000:3000
  environment:
    - PORT=${PORT}
    - DATABASE_URL=${DATABASE_URL}
  depends_on:
    database:
      condition: service_healthy
```

This is more reliable than basic startup ordering.

---

# 59. The Complete Application Flow

When you run:

```bash
docker compose up --build -d
```

the process is approximately:

```text
Docker Compose reads docker-compose.yml
          |
          v
Reads .env variables
          |
          v
Builds logitech image
          |
          v
Downloads postgres image if necessary
          |
          v
Creates Docker network
          |
          v
Creates postgres container
          |
          v
Creates application container
          |
          v
Mounts postgres volume
          |
          v
Starts PostgreSQL
          |
          v
Starts application
          |
          v
Runs Prisma migrations
          |
          v
Starts Express server
```

---

# 60. Understanding Your .env File

Your original environment file contains:

```env
PORT = 3000
POSTGRES_DB=postgres
POSTGRES_PASSWORD=password
POSTGRES_USER=user
DATABASE_URL="postgresql://user:password@database:5432/postgres?schema=public"
```

A cleaner version is:

```env
PORT=3000
POSTGRES_DB=postgres
POSTGRES_PASSWORD=password
POSTGRES_USER=user
DATABASE_URL=postgresql://user:password@database:5432/postgres?schema=public
```

Avoid unnecessary spaces around the equals sign:

```env
PORT=3000
```

instead of:

```env
PORT = 3000
```

Different environment parsers may handle spaces differently, so the safest style is to avoid them.

---

# 61. Why Environment Variables Exist

Environment variables allow configuration to change without modifying application code.

For example:

```js
const port = process.env.PORT || 5000;
```

The application does not hardcode one port.

The port can change depending on the environment:

```text
Development: 3000
Testing: 4000
Production: 8080
```

Similarly, the database URL can change:

```text
Local development:
localhost:5433

Docker:
database:5432

Production:
production-database-host
```

The code remains the same.

---

# 62. Never Hardcode Secrets

Avoid writing this directly in application code:

```js
const password = "mypassword";
```

Instead:

```js
const password = process.env.POSTGRES_PASSWORD;
```

Environment variables are useful for:

* Database passwords
* API keys
* JWT secrets
* Port numbers
* Database URLs
* Third-party credentials

However, `.env` files should not be committed to Git.

---

# 63. Understanding Your Express Application

Your `index.js` file:

```js
import express from "express";
import "dotenv/config";
import { publishProduct } from "./routes/publishproduct.js";
import { fetchProducts } from "./routes/fetchProducts.js";

const app = express();
app.use(express.json());

const port = process.env.PORT || 5000;

const styles = {
  heading: "color: red; font-family: sans-serif;"
};

app.get("/", (req, res) => {
  res.send(`<h1 style="${styles.heading}">app running</h1>`);
});

app.post("/product/publish", publishProduct);
app.get("/product/fetch", fetchProducts);

app.listen(port, () => {
  console.log(`app listening on port ${port}`);
});
```

Docker does not change how Express works.

Docker simply provides the environment where Express runs.

The application still:

* Creates an Express instance
* Registers middleware
* Registers routes
* Reads environment variables
* Starts a server
* Listens on a port

---

# 64. Why the Application Must Listen on the Correct Port

Your application uses:

```js
const port = process.env.PORT || 5000;
```

If Compose injects:

```env
PORT=3000
```

then the application listens on port 3000.

Your Compose mapping is:

```yaml
ports:
  - 3000:3000
```

Therefore, everything matches:

```text
Host port 3000
       |
       v
Container port 3000
       |
       v
Express port 3000
```

If the application listens on port 5000 but Compose maps 3000:3000, the application may not be reachable as expected.

---

# 65. Understanding Prisma in Docker

Prisma has two important parts:

1. Prisma CLI
2. Prisma Client

The Prisma CLI is used for commands such as:

```bash
npx prisma generate
npx prisma migrate dev
npx prisma migrate deploy
npx prisma studio
```

Prisma Client is used inside application code to query the database.

For example:

```js
const products = await prisma.product.findMany();
```

The Prisma Client needs to be generated for the environment where it runs.

That is why your Dockerfile contains:

```dockerfile
RUN npx prisma generate
```

---

# 66. Prisma Migrations

A migration is a controlled change to the database structure.

For example, you may initially have:

```text
Product
 ├── id
 ├── name
 └── price
```

Later, you add:

```text
Product
 ├── id
 ├── name
 ├── price
 └── stock
```

A migration records this change.

Prisma migrations allow your database schema to evolve in a predictable way.

---

# 67. migrate dev Versus migrate deploy

## migrate dev

Used during development:

```bash
npx prisma migrate dev --name add_stock
```

It may:

* Create a migration
* Apply the migration
* Update the development database
* Regenerate Prisma Client

## migrate deploy

Used when deploying existing migrations:

```bash
npx prisma migrate deploy
```

It applies migrations that already exist in the migrations folder.

Your Dockerfile uses:

```dockerfile
npx prisma migrate deploy
```

This is appropriate because the container should apply committed migrations rather than create new development migrations.

---

# 68. Why Migrations Must Be Copied into the Image

Your Dockerfile includes:

```dockerfile
COPY . .
```

This copies the Prisma directory into the image.

For example:

```text
prisma/
 ├── schema.prisma
 └── migrations/
      ├── migration_1/
      └── migration_2/
```

Without the migrations directory, this command may fail:

```dockerfile
npx prisma migrate deploy
```

because the container would not have the migration history.

---

# 69. Docker Build Process

When you run:

```bash
docker compose up --build
```

Docker builds the application image.

The build process follows the Dockerfile:

```text
FROM node:22.23-alpine
       |
       v
Create working directory
       |
       v
Copy package files
       |
       v
Install dependencies
       |
       v
Copy source code
       |
       v
Generate Prisma Client
       |
       v
Create final image
```

The result is an image stored locally.

You can inspect images using:

```bash
docker images
```

---

# 70. Docker Image Layers

Docker images are built in layers.

For example:

```dockerfile
FROM node:22.23-alpine
```

creates a base layer.

```dockerfile
COPY package*.json ./
```

creates another layer.

```dockerfile
RUN npm install
```

creates another layer.

```dockerfile
COPY . .
```

creates another layer.

This allows Docker to reuse unchanged layers during future builds.

That is why Dockerfile instruction order matters.

---

# 71. Docker Cache

Suppose your Dockerfile is:

```dockerfile
COPY package*.json ./
RUN npm install
COPY . .
```

If you change only:

```text
index.js
```

Docker can reuse:

```text
FROM layer
COPY package layer
npm install layer
```

and rebuild only the source code layer.

But if you change:

```text
package.json
```

Docker must run:

```bash
npm install
```

again because the dependency layer is no longer valid.

---

# 72. Running the Project

The recommended command is:

```bash
docker compose up --build -d
```

Meaning:

```text
docker compose
```

Use Docker Compose.

```text
up
```

Create and start services.

```text
--build
```

Build images before starting.

```text
-d
```

Run in detached mode, meaning in the background.

---

# 73. Foreground and Detached Mode

Without `-d`:

```bash
docker compose up
```

the terminal remains attached to the running services and displays logs.

This is useful during development.

With `-d`:

```bash
docker compose up -d
```

the containers run in the background.

You can later inspect logs using:

```bash
docker compose logs
```

---

# 74. Useful Docker Commands

## List running containers

```bash
docker ps
```

## List all containers

```bash
docker ps -a
```

## List images

```bash
docker images
```

## List volumes

```bash
docker volume ls
```

## List networks

```bash
docker network ls
```

## Show Compose services

```bash
docker compose ps
```

## Show logs

```bash
docker compose logs
```

## Follow logs continuously

```bash
docker compose logs -f
```

## Show application logs only

```bash
docker compose logs -f logitech
```

## Show database logs only

```bash
docker compose logs -f database
```

---

# 75. Entering a Running Container

To open a shell inside the application container:

```bash
docker exec -it logitech_server sh
```

The command means:

```text
docker exec
```

Execute a command inside a running container.

```text
-it
```

Interactive terminal.

```text
sh
```

Open a shell.

Once inside, you may run:

```bash
ls
```

```bash
pwd
```

```bash
env
```

```bash
node --version
```

```bash
npx prisma --version
```

To exit:

```bash
exit
```

---

# 76. Inspecting Environment Variables

Inside the application container, run:

```bash
env
```

You should see variables such as:

```text
PORT=3000
DATABASE_URL=postgresql://...
```

This helps confirm that Compose correctly injected the variables.

You can also inspect the container configuration from the host:

```bash
docker inspect logitech_server
```

---

# 77. Checking Container Status

Run:

```bash
docker compose ps
```

Example:

```text
NAME             SERVICE     STATUS
logitech_server  logitech    running
logitech_db      database    running
```

If the application keeps restarting, inspect its logs:

```bash
docker compose logs logitech
```

If PostgreSQL fails, inspect:

```bash
docker compose logs database
```

---

# 78. Stopping Containers

To stop services without removing them:

```bash
docker compose stop
```

The containers remain available but are stopped.

To start them again:

```bash
docker compose start
```

To restart:

```bash
docker compose restart
```

---

# 79. Removing Containers

```bash
docker compose down
```

This removes the Compose containers and network.

Named volumes usually remain.

To remove containers and volumes:

```bash
docker compose down -v
```

Be careful because this may delete PostgreSQL data.

---

# 80. Testing the Express Application

Once the containers are running, open:

```text
http://localhost:3000
```

Your root route should return:

```html
<h1>app running</h1>
```

You can also test using a browser, Postman, Insomnia, curl, or PowerShell.

---

# 81. Testing with curl

For the GET endpoint:

```bash
curl http://localhost:3000/product/fetch
```

For the POST endpoint:

```bash
curl -X POST http://localhost:3000/product/publish \
  -H "Content-Type: application/json" \
  -d '{"name":"Sample Product","price":100}'
```

The exact JSON body depends on how your `publishProduct` route is implemented.

---

# 82. Testing from PowerShell

PowerShell uses:

```powershell
Invoke-WebRequest
```

or:

```powershell
Invoke-RestMethod
```

Example:

```powershell
Invoke-RestMethod http://localhost:3000/product/fetch
```

POST example:

```powershell
Invoke-RestMethod `
  -Uri http://localhost:3000/product/publish `
  -Method POST `
  -ContentType "application/json" `
  -Body '{"name":"Sample Product","price":100}'
```

---

# 83. Understanding the Complete Network

Your project has two different networking perspectives.

## From Windows

```text
Windows
 ├── localhost:3000 -> Express container
 └── localhost:5433 -> PostgreSQL container
```

## Inside Docker

```text
logitech container
       |
       v
database:5432
       |
       v
PostgreSQL container
```

This distinction is one of the most important things to understand when working with Docker.

---

# 84. Why the Application Does Not Use localhost

Your application is running here:

```text
logitech_server
```

PostgreSQL is running here:

```text
logitech_db
```

They are separate containers.

Therefore:

```text
localhost
```

inside `logitech_server` refers to:

```text
logitech_server itself
```

It does not refer to:

```text
logitech_db
```

Docker's internal DNS resolves:

```text
database
```

to the database container.

---

# 85. Common Docker Error: Connection Refused

You may see errors such as:

```text
Can't reach database server
```

or:

```text
ECONNREFUSED
```

Possible causes include:

1. PostgreSQL is not running.
2. The database hostname is incorrect.
3. You used `localhost` inside the container.
4. You used port 5433 internally instead of 5432.
5. PostgreSQL has not finished initializing.
6. The database credentials are incorrect.
7. The database volume contains old credentials.
8. The application started before the database was ready.

---

# 86. Common Error: Using localhost in Docker

Incorrect:

```env
DATABASE_URL=postgresql://user:password@localhost:5433/postgres?schema=public
```

when both services are inside Docker.

Correct:

```env
DATABASE_URL=postgresql://user:password@database:5432/postgres?schema=public
```

---

# 87. Common Error: Wrong Internal Port

Incorrect:

```env
DATABASE_URL=postgresql://user:password@database:5433/postgres?schema=public
```

Correct:

```env
DATABASE_URL=postgresql://user:password@database:5432/postgres?schema=public
```

The internal PostgreSQL port is 5432.

Port 5433 is only used from the host machine.

---

# 88. Common Error: Docker Daemon Not Running

You may see:

```text
Cannot connect to the Docker daemon
```

This usually means Docker Desktop is not running.

Solution:

1. Open Docker Desktop.
2. Wait until it finishes starting.
3. Run:

```bash
docker ps
```

again.

---

# 89. Common Error: Virtualization Disabled

If Docker Desktop reports virtualization errors:

1. Check Task Manager.
2. Go to Performance.
3. Select CPU.
4. Check whether virtualization is enabled.
5. If disabled, enable Intel VT-x or AMD SVM in BIOS or UEFI.

---

# 90. Common Error: Port Already in Use

You may see:

```text
port is already allocated
```

This means another application is already using the port.

For example, another application may already be using port 3000.

On Windows, check:

```powershell
netstat -ano | findstr :3000
```

You can either stop the process or change the host port:

```yaml
ports:
  - 3001:3000
```

Then access the application using:

```text
http://localhost:3001
```

---

# 91. Common Error: Container Name Already Exists

You may see an error saying:

```text
The container name is already in use
```

This happens when a container with the same name already exists.

Check all containers:

```bash
docker ps -a
```

Remove the old container if it is no longer needed:

```bash
docker rm logitech_server
```

Or bring the Compose project down:

```bash
docker compose down
```

---

# 92. Common Error: Old Database Credentials

Suppose your `.env` contains:

```env
POSTGRES_PASSWORD=password123
```

You start the project.

Later you change it to:

```env
POSTGRES_PASSWORD=newpassword
```

The database may still use the old password because the volume was already initialized.

For a development environment where data can be deleted:

```bash
docker compose down -v
docker compose up --build -d
```

This creates a fresh database.

Do not do this in production unless you intentionally want to delete the data.

---

# 93. Common Error: Prisma Native Dependencies

Prisma may sometimes produce errors related to:

* OpenSSL
* Query engine
* Linux binaries
* musl
* glibc
* Unsupported platform

This can happen when Prisma Client is generated on one operating system but executed on another.

For example:

```text
Windows-generated Prisma Client
```

being used inside:

```text
Linux Alpine container
```

Running this inside the Dockerfile helps:

```dockerfile
RUN npx prisma generate
```

If Alpine compatibility becomes difficult, you may use a Debian-based Node image instead:

```dockerfile
FROM node:22.23-slim
```

Debian-based images are usually larger but may have better compatibility with native dependencies.

---

# 94. Alpine Versus Debian-Based Node Images

Alpine:

```dockerfile
FROM node:22.23-alpine
```

Advantages:

* Smaller image
* Lightweight
* Lower storage usage

Potential disadvantages:

* Native dependency compatibility issues
* musl-related problems
* Additional packages may be required

Debian slim:

```dockerfile
FROM node:22.23-slim
```

Advantages:

* Often better compatibility
* Easier support for many native libraries
* More familiar Linux environment

Disadvantages:

* Larger image size

For beginners, `node:slim` can sometimes be easier when dealing with Prisma or native dependencies.

---

# 95. Docker Compose Configuration Improvement

A more reliable version of your Compose file could be:

```yaml
services:
  logitech:
    build: .
    container_name: logitech_server
    ports:
      - "3000:3000"
    environment:
      PORT: ${PORT}
      DATABASE_URL: ${DATABASE_URL}
    depends_on:
      database:
        condition: service_healthy

  database:
    image: postgres:16-alpine
    container_name: logitech_db
    restart: always
    environment:
      POSTGRES_USER: ${POSTGRES_USER}
      POSTGRES_PASSWORD: ${POSTGRES_PASSWORD}
      POSTGRES_DB: ${POSTGRES_DB}
    ports:
      - "5433:5432"
    volumes:
      - postgres_volume:/var/lib/postgresql/data
    healthcheck:
      test: ["CMD-SHELL", "pg_isready -U ${POSTGRES_USER} -d ${POSTGRES_DB}"]
      interval: 5s
      timeout: 5s
      retries: 10

volumes:
  postgres_volume:
```

This version uses clearer YAML mapping syntax and a database health check.

---

# 96. Improved Dockerfile

A cleaner version of your Dockerfile:

```dockerfile
FROM node:22.23-alpine

WORKDIR /logitechapp

COPY package*.json ./

RUN npm install

COPY . .

RUN npx prisma generate

EXPOSE 3000

CMD ["sh", "-c", "npx prisma migrate deploy && node index.js"]
```

For production, you may eventually replace:

```dockerfile
RUN npm install
```

with:

```dockerfile
RUN npm ci
```

provided that `package-lock.json` exists and is valid.

`npm ci` is more predictable for reproducible builds.

---

# 97. Why npm ci Is Useful

`npm install` may update dependency resolution in some situations.

`npm ci` installs exactly according to the lock file.

This is useful in CI/CD and production because the same dependency versions should be installed every time.

Example:

```dockerfile
COPY package.json package-lock.json ./
RUN npm ci
```

Use `npm install` during ordinary development if necessary, but prefer `npm ci` for reproducible production builds.

---

# 98. Development Containers Versus Production Containers

A development container may:

* Install development dependencies
* Mount source code as a volume
* Use nodemon
* Expose debugging ports
* Reload automatically

A production container should generally:

* Contain only required files
* Use predictable dependency versions
* Avoid unnecessary development tools
* Run with a non-root user
* Use health checks
* Use proper logging
* Avoid exposing the database publicly

The Dockerfile you currently have is a simple and useful learning or small deployment Dockerfile.

It can later be improved for production.

---

# 99. Multi-Stage Builds

A multi-stage Dockerfile uses multiple build stages to produce a smaller final image.

Example concept:

```dockerfile
FROM node:22.23-alpine AS builder

WORKDIR /app

COPY package*.json ./
RUN npm ci

COPY . .
RUN npm run build

FROM node:22.23-alpine

WORKDIR /app

COPY --from=builder /app/package*.json ./
COPY --from=builder /app/node_modules ./node_modules
COPY --from=builder /app/dist ./dist

CMD ["node", "dist/index.js"]
```

The builder stage compiles or prepares the application.

The final stage contains only what is needed to run it.

This reduces unnecessary files in the production image.

---

# 100. Why the Database Should Usually Be Separate

You could theoretically install PostgreSQL inside the same container as Node.js, but that is generally not recommended.

Bad architecture:

```text
One Container
 ├── Node.js
 ├── Express
 └── PostgreSQL
```

Better architecture:

```text
Application Container
 └── Node.js + Express

Database Container
 └── PostgreSQL
```

Reasons include:

* Each container has one main responsibility
* Easier maintenance
* Independent restarts
* Easier scaling
* Easier backups
* Better separation of concerns
* Easier upgrades

---

# 101. The Single Responsibility Principle in Containers

A container should generally focus on one main process or service.

For your project:

```text
logitech container:
Application server

database container:
Database server
```

This makes the architecture easier to understand and operate.

The application does not need to know how PostgreSQL is installed internally. It only needs to know how to connect to it.

---

# 102. Docker Compose Is Not Kubernetes

Docker Compose is designed mainly for:

* Local development
* Small deployments
* Single-server applications
* Testing multi-container applications
* Simple environments

Kubernetes is designed for larger container orchestration needs such as:

* Large-scale deployments
* Automatic scheduling
* Service discovery
* Self-healing
* Horizontal scaling
* Cluster management

For your Express and PostgreSQL project, Docker Compose is a very good starting point.

You do not need Kubernetes to learn Docker.

---

# 103. Understanding the Full Architecture

Your project can be represented as:

```text
                         Browser/Postman
                                |
                                |
                         localhost:3000
                                |
                                v
                    +----------------------+
                    |  logitech_server     |
                    |  Express Application |
                    |  Node.js             |
                    |  Prisma              |
                    +----------------------+
                                |
                                | database:5432
                                v
                    +----------------------+
                    |  logitech_db         |
                    |  PostgreSQL 16       |
                    +----------------------+
                                |
                                v
                    +----------------------+
                    | postgres_volume      |
                    | Persistent Database  |
                    | Storage              |
                    +----------------------+
```

---

# 104. What Happens When a Request Is Sent?

Suppose you send:

```http
GET http://localhost:3000/product/fetch
```

The process is:

1. Your browser sends a request to Windows port 3000.
2. Docker forwards port 3000 to the application container.
3. Express receives the request.
4. Express executes the `fetchProducts` route.
5. The route uses Prisma.
6. Prisma connects to `database:5432`.
7. PostgreSQL processes the query.
8. PostgreSQL returns the result.
9. Prisma returns the data to Express.
10. Express sends the HTTP response.
11. Docker forwards the response to your browser.

The complete flow:

```text
Browser
   |
   v
localhost:3000
   |
   v
Docker Port Mapping
   |
   v
Express
   |
   v
Prisma
   |
   v
database:5432
   |
   v
PostgreSQL
   |
   v
Response
```

---

# 105. Why Containers Can Communicate Without Exposing Every Port

Your application can communicate with PostgreSQL internally even if PostgreSQL is not exposed to the host.

For example, you could remove:

```yaml
ports:
  - 5433:5432
```

from the database service.

The application could still connect using:

```text
database:5432
```

because both containers share the Docker network.

This is often safer in production because the database does not need to be accessible directly from the public host.

The database only needs to be accessible by the application container.

---

# 106. Development Database Access

During development, exposing PostgreSQL is convenient:

```yaml
ports:
  - 5433:5432
```

This allows you to use tools such as:

```text
DBeaver
pgAdmin
Prisma Studio
```

from Windows.

In production, you may remove the port mapping unless external database access is genuinely required.

---

# 107. Docker Security Considerations

Do not assume containers automatically make applications secure.

Important practices include:

* Do not commit `.env` files
* Use strong database passwords
* Avoid exposing PostgreSQL publicly
* Do not use default passwords in production
* Keep images updated
* Avoid running containers as root when possible
* Limit exposed ports
* Use trusted base images
* Scan images for vulnerabilities
* Keep dependencies updated
* Do not include unnecessary secrets in images

---

# 108. Why Secrets Should Not Be Written in Dockerfiles

Avoid:

```dockerfile
ENV DATABASE_PASSWORD=password
```

because the value may become part of the image history or image metadata.

Instead, inject secrets at runtime through:

* Environment variables
* Docker secrets
* Secret management systems
* Deployment platform secret settings

---

# 109. Difference Between Build Time and Runtime

This distinction is important.

## Build Time

Commands executed while creating the image:

```dockerfile
RUN npm install
RUN npx prisma generate
```

## Runtime

Commands executed when the container starts:

```dockerfile
CMD ["sh", "-c", "npx prisma migrate deploy && node index.js"]
```

Build time creates the image.

Runtime starts the application from that image.

---

# 110. Image Lifecycle

A typical lifecycle is:

```text
Dockerfile
    |
    v
docker build
    |
    v
Docker Image
    |
    v
docker run
    |
    v
Container
    |
    v
Running Application
```

With Compose:

```text
docker-compose.yml
       |
       v
docker compose up
       |
       v
Images and Containers
```

---

# 111. Container Lifecycle

A container may be:

```text
Created
Running
Paused
Stopped
Restarting
Exited
Removed
```

Useful commands:

```bash
docker ps
```

shows running containers.

```bash
docker ps -a
```

shows all containers, including stopped containers.

A stopped container is not necessarily deleted.

---

# 112. Images and Containers Are Different

You can remove a container without removing its image.

For example:

```bash
docker rm logitech_server
```

removes the container.

The image can still exist.

You can check images using:

```bash
docker images
```

You can create another container from the same image later.

---

# 113. Cleaning Unused Docker Resources

Docker may accumulate:

* Old containers
* Unused images
* Build cache
* Unused networks
* Unused volumes

You can inspect disk usage:

```bash
docker system df
```

You can remove unused resources with:

```bash
docker system prune
```

Be careful with prune commands because they can remove resources you still need.

Do not use aggressive cleanup commands blindly, especially when databases and volumes are involved.

---

# 114. Useful Inspection Commands

Inspect a container:

```bash
docker inspect logitech_server
```

Inspect a volume:

```bash
docker volume inspect postgres_volume
```

Inspect a network:

```bash
docker network inspect project_default
```

View image history:

```bash
docker history image-name
```

View Compose configuration after variable substitution:

```bash
docker compose config
```

The last command is particularly useful for checking whether `.env` values are being loaded correctly.

---

# 115. Why docker compose config Is Useful

Run:

```bash
docker compose config
```

It shows the final Compose configuration after variables such as:

```yaml
${DATABASE_URL}
```

have been resolved.

This helps identify errors such as:

* Missing environment variables
* Incorrect port mappings
* Wrong database URLs
* Incorrect service names
* Invalid YAML structure

---

# 116. Project Directory Example

Your project may look like:

```text
logitech/
├── Dockerfile
├── docker-compose.yml
├── .dockerignore
├── .env
├── package.json
├── package-lock.json
├── index.js
├── routes/
│   ├── publishproduct.js
│   └── fetchProducts.js
└── prisma/
    ├── schema.prisma
    └── migrations/
```

Each file has a specific role:

```text
Dockerfile
```

Instructions for building the application image.

```text
docker-compose.yml
```

Defines and connects application services.

```text
.env
```

Stores environment configuration.

```text
.dockerignore
```

Excludes unnecessary files from the image build context.

```text
prisma/schema.prisma
```

Defines the database schema.

```text
prisma/migrations
```

Stores database structure changes.

```text
index.js
```

Starts the Express server.

---

# 117. What Students Should Understand From This Project

By studying this project, students should understand that Docker is not replacing Express, Prisma, or PostgreSQL.

Instead:

* Express remains the application framework.
* Prisma remains the database ORM.
* PostgreSQL remains the database engine.
* Node.js remains the runtime.
* Docker packages and runs them consistently.
* Docker Compose connects the services together.

Docker is the environment and orchestration layer around the application.

---

# 118. Important Mental Model

Think of the project this way:

```text
Express answers HTTP requests.
Prisma communicates with PostgreSQL.
PostgreSQL stores data.
Docker packages Express.
Docker runs PostgreSQL.
Docker Compose connects everything.
Volumes preserve database data.
Networks allow containers to communicate.
Environment variables configure the services.
```

---

# 119. Suggested Beginner Learning Sequence

Students should learn Docker in this order:

## Stage 1: Basic Concepts

Understand:

* What Docker is
* Why Docker exists
* Image
* Container
* Docker Engine
* Dockerfile
* Docker Compose

## Stage 2: Basic Commands

Practice:

```bash
docker --version
docker ps
docker images
docker pull
docker run
docker stop
docker rm
docker logs
```

## Stage 3: Dockerfile

Learn:

```dockerfile
FROM
WORKDIR
COPY
RUN
EXPOSE
CMD
```

## Stage 4: Compose

Learn:

```yaml
services:
build:
image:
ports:
environment:
depends_on:
volumes:
```

## Stage 5: Networking

Understand:

* localhost
* Host ports
* Container ports
* Service names
* Internal Docker DNS

## Stage 6: Persistence

Understand:

* Volumes
* Database data
* Container deletion
* Volume deletion

## Stage 7: Production Concepts

Learn:

* Health checks
* Multi-stage builds
* Secrets
* Image optimization
* Logging
* Backups
* Security

---

# 120. Classroom Exercises

## Exercise 1: Run a Basic Container

Run:

```bash
docker run hello-world
```

Explain what happened.

---

## Exercise 2: Run Nginx

```bash
docker run -d -p 8080:80 nginx
```

Open:

```text
http://localhost:8080
```

Explain:

```text
8080:80
```

---

## Exercise 3: Inspect the Container

```bash
docker ps
```

Then:

```bash
docker logs container-name
```

Then:

```bash
docker inspect container-name
```

---

## Exercise 4: Build the Express Image

```bash
docker compose build
```

Explain each Dockerfile instruction.

---

## Exercise 5: Run the Full Application

```bash
docker compose up --build -d
```

Confirm:

```bash
docker compose ps
```

---

## Exercise 6: Break the Database URL

Change:

```env
DATABASE_URL=postgresql://user:password@database:5432/postgres?schema=public
```

to:

```env
DATABASE_URL=postgresql://user:password@localhost:5433/postgres?schema=public
```

Restart the application and observe the failure.

Explain why it fails.

---

## Exercise 7: Explain the Volume

Run:

```bash
docker compose down
```

Start again:

```bash
docker compose up -d
```

Check whether the data remains.

Then discuss the difference between:

```bash
docker compose down
```

and:

```bash
docker compose down -v
```

---

# 121. Docker Command Cheat Sheet

```bash
docker --version
```

Check Docker version.

```bash
docker compose version
```

Check Compose version.

```bash
docker ps
```

List running containers.

```bash
docker ps -a
```

List all containers.

```bash
docker images
```

List images.

```bash
docker volume ls
```

List volumes.

```bash
docker network ls
```

List networks.

```bash
docker compose build
```

Build services.

```bash
docker compose up
```

Start services in the foreground.

```bash
docker compose up -d
```

Start services in the background.

```bash
docker compose up --build -d
```

Build and start services.

```bash
docker compose ps
```

Show service status.

```bash
docker compose logs
```

Show logs.

```bash
docker compose logs -f
```

Follow logs.

```bash
docker compose stop
```

Stop services.

```bash
docker compose start
```

Start stopped services.

```bash
docker compose restart
```

Restart services.

```bash
docker compose down
```

Remove containers and network.

```bash
docker compose down -v
```

Remove containers, network, and volumes.

```bash
docker exec -it logitech_server sh
```

Enter a running container.

```bash
docker inspect logitech_server
```

Inspect a container.

```bash
docker compose config
```

Validate and display the resolved Compose configuration.

---

# 122. Final Summary

Docker allows applications to run in consistent isolated environments.

An image is a template used to create containers.

A container is a running instance of an image.

A Dockerfile describes how an image is built.

Docker Compose defines multiple services and how they work together.

In this project:

```text
logitech
```

is the Express application service.

```text
database
```

is the PostgreSQL service.

```text
postgres_volume
```

preserves database data.

```text
database:5432
```

is the internal database address used by the application container.

```text
localhost:5433
```

is the database address used from the host computer.

```text
localhost:3000
```

is the address used to access the Express application from the host computer.

The most important Docker networking rule is:

> Inside a container, localhost refers to that same container. To communicate with another Compose service, use the service name.

The most important database persistence rule is:

> Removing a container does not necessarily remove a named volume, but removing the volume can delete the database data.

The most important build rule is:

> Dockerfile instructions are executed during image creation, while CMD runs when the container starts.

The most important architecture rule is:

> Keep the application and database in separate containers, then connect them through a Docker network.

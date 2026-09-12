import express from "express";
import "dotenv/config";
import { publishProduct } from "./routes/publishproduct.js";
import { fetchProducts } from "./routes/fetchProducts.js";
const app = express();
app.use(express.json());
const port = process.env.PORT || 5000;
const styles = {
  heading: "color: red; font-family: sans-serif;",
};

app.get("/", (req, res) => {
  res.send(`  <h1 style="${styles.heading}">app running</h1>`);
});

app.post("/product/publish", publishProduct);
app.get("/product/fetch", fetchProducts);
app.listen(port, () => {
  console.log(`app listening on port ${port}`);
});

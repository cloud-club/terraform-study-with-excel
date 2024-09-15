const express = require("express");

const app = express();

app.use(express.static("public"));
app.use(express.json());
app.use(express.urlencoded({ extended: false }));

app.get("/", (req, res, next) => {
  res.send("Hello, Terraform!");
});

app.listen(80, () => {
  console.log("start! express server on port 80");
});

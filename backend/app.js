const express = require("express");
const app = express();
const path = require("path");

const morgan = require("morgan");
const fs = require("fs");

const cors = require("cors");
const errorMiddleware = require("./middlewares/error");
const cookieParser = require("cookie-parser");
const auth = require("./routes/auth");
const product = require("./routes/product");
const wishlist = require("./routes/wishList");
const cart = require("./routes/cart");

const accessLogStream = fs.createWriteStream(
  path.join(__dirname, "access.log"),
  { flags: "a" }
);

// Setup logger
app.use(morgan("combined", { stream: accessLogStream }));

app.use(express.json());
app.use(cookieParser());

app.use(
  cors({
    origin: /^http:\/\/localhost:\d+$/,
    methods: ["GET", "POST"],
    credentials: true,
  })
);

app.set("trust proxy", 1);

app.get("/", (req, res) => {
  res.send("Vanakkam Da Maapula....");
});
app.use("/", auth);
app.use("/", product);
app.use("/", cart);
app.use("/", wishlist);

app.use(errorMiddleware);

module.exports = app;

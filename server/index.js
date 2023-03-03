const express = require("express");
const mongoose = require("mongoose");
const authRouter = require("./routes/auth");
const dotenv = require('dotenv');
dotenv.config();
const app = express();
//==========================================================================
//PORT
const PORT = process.env.PORT;
// MONGO DB CONNECTION URL
const DB =process.env.DB_URL;
//=========================================================================
//middleware
app.use(express.json());
app.use(authRouter);

//==========================================================================
// db connection
mongoose
  .connect(DB)
  .then(() => {
    console.log("database connected");
  })
  .catch((err) => {
    console.log(`error : ${err}`);
  });

//==========================================================================

// server
app.listen(
  PORT,
  /*"0.0.0.0",*/ () => {
    console.log(`server connected port : ${PORT}`);
  }
);

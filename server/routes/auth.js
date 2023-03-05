const express = require("express");
const User = require("../models/user");
const bcrypt = require("bcryptjs");
const authRouter = express.Router();
const validator = require("../middleware/validate");
const jwt = require("jsonwebtoken");
const auth = require("../middleware/auth");

// signup route
authRouter.post("/api/signup", validator.signupValidator, async (req, res) => {
  const { name, email, password } = req.body;
  try {
    const existUser = await User.findOne({ email });

    if (existUser) {
      return res.status(400).json({
        message: "Email Already Exists!",
      });
    }

    const hashedPassword = await bcrypt.hash(password, 8);
    let user = User({
      name,
      email,
      password: hashedPassword,
    });

    user = await user.save();
    return res.json(user);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

// log in
authRouter.post("/api/signin", validator.signinValidator, async (req, res) => {
  const { name, email, password } = req.body;
  try {
    const existUser = await User.findOne({ email });

    if (!existUser) {
      return res.status(400).json({
        message: "Email Not Exists Try Sign Up Instead!",
      });
    }
    const isValid = await bcrypt.compare(password, existUser.password);

    if (!isValid) {
      return res.status(400).json({ message: "Incorrect password!" });
    }
    const token = jwt.sign({ id: existUser._id }, process.env.ACCESS_TOKEN_KEY);
    return res.json({ token, ...existUser._doc });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

// verify token
authRouter.post("/api/tokenIsValid", async (req, res) => {
  try {
    const token = req.header("x-auth-token");
    // if token not attached
    if (!token) return res.json(false);

    // if token not valid
    const verified = jwt.verify(token, process.env.ACCESS_TOKEN_KEY);
    if (!verified) return res.json(false);

    // if user from token is not exist in our database
    const user = User.findById(verified.id);
    if (!user) return res.json(false);

    // here user attach token and it is valid and id is in our database
    return res.json(true);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

// get user data
authRouter.get("/", auth, async (req, res) => {
  try {
    // return user data
    const user = await User.findById(req.userId);
    return res.json({ ...user._doc, token: req.token });
  } catch (error) {
    return res.status(500).json({ error: error.message });
  }
});
module.exports = authRouter;

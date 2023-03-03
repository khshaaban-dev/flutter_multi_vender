const express = require("express");
const User = require("../models/user");
const authRouter = express.Router();
const signupValidator  = require("../middleware/validate");

// signup route
authRouter.post("/api/signup", signupValidator, async (req, res) => {
  const { name, email, password } = req.body;
  try {
    const existUser = await User.findOne({ email });

    if (existUser) {
      return res.status(400).json({
        message: "Email Already Exists!",
      });
    }
    let user = User({
      name,
      email,
      password,
    });

    user = await user.save();
    return res.json(user);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

// log in
authRouter.post("/api/signin", (req, res) => {
  res.json({ name: "khalil" });
});

// delete account

module.exports = authRouter;

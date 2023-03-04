const express = require("express");
const User = require("../models/user");
const bcrypt = require("bcryptjs");
const authRouter = express.Router();
const validator = require("../middleware/validate");
const jwt = require('jsonwebtoken');

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
authRouter.post("/api/signin", validator.signinValidator, async(req, res) => {
  const { name, email, password } = req.body;
  try {
    const existUser = await User.findOne({ email });

    if (!existUser) {
      return res.status(400).json({ 
        message: "Email Not Exists Try Sign Up Instead!",
      });
    }
      const isValid = await bcrypt.compare(password , existUser.password,);

      if (!isValid) {
        return res.status(400).json({message:"Incorrect password!"});
      }
      const token = jwt.sign({user :existUser._id} , process.env.ACCESS_TOKEN_KEY);
      return res.json({token , ...existUser._doc});

  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

// delete account

module.exports = authRouter;

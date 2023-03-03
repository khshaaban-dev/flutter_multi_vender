const mongoose = require("mongoose");

const userSchema = mongoose.Schema({
  name: {
    required: true,
    type: String,
    trim: true,
  },
  email: {
    type: String,
    required: true,
    trim: true,
    validate: {
      validator: (value) => {
        const rx =
          /^(([^<>()[\]\.,;:\s@\"]+(\.[^<>()[\]\.,;:\s@\"]+)*)|(\".+\"))@(([^<>()[\]\.,;:\s@\"]+\.)+[^<>()[\]\.,;:\s@\"]{2,})$/i;
        return value.match(rx);
      },
      message: (props) => "Inter valid email",
    },
  },
  password: {
    required: true,
    type: String,
    validate: {
      validator: (value) => {
        return value.length > 6;
      },
      message: (props) => "Please Inter long password",
    },
  },
  userType: {
    type: String,
    default: "user",
  },
  address: {
    type: String,
    default: "",
  },

  // cart:[String]
});
const User = mongoose.model("user", userSchema);
module.exports = User;

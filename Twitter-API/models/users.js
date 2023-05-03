const mongoose = require("mongoose");

const userSchema = new mongoose.Schema({
  email: {
    type: String,
    required: true,
    unique: true,
  },
  username: {
    type: String,
    unique: true,
    required: true,
  },
  name: {
    type: String,
    required: true,
  },
  profilepicture: {
    type: String,
    default: "http://localhost:3000/assets/profile-pictures/default-image.png",
  },

  password: {
    type: String,
    required: true,
  },
});

const registerUser = new mongoose.model("User", userSchema);
module.exports = registerUser;

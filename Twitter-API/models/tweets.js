const mongoose = require("mongoose");

const tweetSchema = new mongoose.Schema({
  username: {
    type: String,
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
  tweet: {
    type: String,
    required: true,
  },
});

const registerTweet = new mongoose.model("Tweet", tweetSchema);
module.exports = registerTweet;

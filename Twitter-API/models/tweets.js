const mongoose = require("mongoose");

const commentSchema = new mongoose.Schema({
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
  comment: {
    type: String,
    required: true,
  },
  timestamp: {
    type: Date,
    default: Date.now,
  },
});

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
  timestamp: {
    type: Date,
    default: Date.now,
  },
  likes: [{ type: mongoose.Schema.Types.ObjectId, ref: "User" }],
  comments: [commentSchema],
});

const Tweet = mongoose.model("Tweet", tweetSchema);
module.exports = Tweet;

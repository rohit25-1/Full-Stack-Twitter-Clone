const express = require("express");
const app = express();
const bodyParser = require("body-parser");
const jwt = require("jsonwebtoken");
const session = require("express-session");

const upload = require("./storage/storage");

require("./db/connect");
app.use(express.static("public"));
const users = require("./models/users");
const tweets = require("./models/tweets");

app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: true }));

app.get("/status", async (req, res) => {
  const headers = req.headers["authorization"];
  console.log(headers);
  if (headers) {
    // const token = headers.split(" ")[1];
    const email = jwt.verify(headers, "SECRET");
    const isUser = await users.findOne({
      email,
    });
    if (isUser) {
      console.log(isUser);
      res.status(200).json({ success: 1 });
    } else {
      res.status(400).json({ success: 0 });
    }
  }
});

app.post("/login", async (req, res) => {
  try {
    const email = req.body.email;
    const password = req.body.password;
    const findUser = await users.findOne({
      email,
      password,
    });
    if (findUser) {
      const token = jwt.sign(email, "SECRET");
      resp = {
        token: token,
        username: findUser.username,
        name: findUser.name,
        profilepicture: findUser.profilepicture,
      };
      res.send(resp).status(200);
    } else {
      res.status(400).send("No User Found");
    }
  } catch (error) {
    console.log(error);
  }
});

app.post("/register", async (req, res) => {
  try {
    console.log(req.body);
    const email = req.body.email;
    const password = req.body.password;
    const username = req.body.username;
    const name = req.body.name;
    const findUser = new users({
      email,
      password,
      username,
      name,
    });

    const isSuccess = await findUser.save();
    if (isSuccess) {
      res.send(isSuccess).status(200);
    } else {
      res.status(400).send("User Not Registered");
    }
  } catch (error) {
    if (error.code == 11000) {
      res.status(400).send({ message: "Email already registered" });
    } else {
      console.log(error);
    }
  }
});

app.post("/reset-password", async (req, res) => {
  try {
    const email = req.body.email;
    const password = req.body.password;
    const findUser = await users.updateOne(
      {
        email,
      },
      {
        password: password,
      }
    );

    if (findUser.modifiedCount != 0) {
      res.send(findUser).status(200);
    } else {
      res.status(400).send("Error");
    }
  } catch (error) {
    if (error.code == 11000) {
      res.status(400).send({ message: "Email already registered" });
    } else {
      console.log(error);
    }
  }
});

app.post("/tweet", async (req, res) => {
  try {
    const headers = req.headers["authorization"];
    console.log(req.body);
    if (headers) {
      // const token = headers.split(" ")[1];
      const email = jwt.verify(headers, "SECRET");
      const tweet = req.body.tweet;
      const findUser = await users.findOne({
        email,
      });
      const tweetModel = new tweets({
        tweet,
        name: findUser.name,
        username: findUser.username,
        profilepicture: findUser.profilepicture,
      });
      const isSaved = await tweetModel.save();
      if (isSaved) {
        res.status(200).send({ success: 1 });
      } else {
        res.status(400).send({ success: 0 });
      }
    }
  } catch (error) {
    console.log(error);
  }
});

app.post("/uploadpp", upload.single("image"), async (req, res) => {
  console.log(req.file);
  const headers = req.headers["authorization"];
  if (headers) {
    const email = jwt.verify(headers, "SECRET");
    const updatePP = await users.updateOne(
      {
        email,
      },
      {
        profilepicture:
          "http://localhost:3000/assets/profile-pictures/" + req.file.filename,
      }
    );
    const findUser = await users.findOne({
      email,
    });
    const updatePP2 = await tweets.updateMany(
      {
        username: findUser.username,
      },
      {
        profilepicture:
          "http://localhost:3000/assets/profile-pictures/" + req.file.filename,
      }
    );
    console.log(updatePP);
    console.log(updatePP2);
    res.status(200).send("File uploaded successfully");
  }
});

app.get("/all", async (req, res) => {
  try {
    const findUser = await tweets.find({});
    if (findUser) {
      res.send(findUser);
    } else {
      res.send("No User Found");
    }
  } catch (error) {
    console.log(error);
  }
});

app.get("/userdata", async (req, res) => {
  try {
    const header = req.headers["authorization"];
    if (header) {
      const email = jwt.verify(header, "SECRET");
      const findUser = await users.findOne({ email });
      console.log(findUser);
      if (findUser) {
        res.status(200).send({
          email: findUser.email,
          username: findUser.username,
          name: findUser.name,
          profilepicture: findUser.profilepicture,
        });
      } else {
        res.status(400);
      }
    }
    res.status(400);
  } catch (error) {
    console.log(error);
  }
});

app.get("/status", async (req, res) => {
  res.status(200);
});

app.listen(3000);

const express = require("express");
const app = express();
const bodyParser = require("body-parser");
const jwt = require("jsonwebtoken");
const session = require("express-session");

app.use(
  session({
    secret: "my-secret-key",
    resave: false,
    saveUninitialized: true,
  })
);
require("./db/connect");

const users = require("./models/users");

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
      resp = { token: token };
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
    const email = req.body.email;
    const password = req.body.password;
    const username = req.body.username;
    const findUser = new users({
      email,
      password,
      username,
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

app.get("/all", async (req, res) => {
  try {
    const findUser = await users.find({});
    if (findUser) {
      res.send(findUser);
    } else {
      res.send("No User Found");
    }
  } catch (error) {
    console.log(error);
  }
});

app.listen(3000);

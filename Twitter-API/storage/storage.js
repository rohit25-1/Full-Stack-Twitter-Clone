const multer = require("multer");
const path = require("path");

const ppStorage = multer.diskStorage({
  destination: "public/assets/profile-pictures",
  filename: function (req, file, cb) {
    const uniqueSuffix = Date.now() + "-" + path.extname(file.originalname);
    cb(null, file.fieldname + "-" + uniqueSuffix);
  },
});

const ppUpload = multer({
  storage: ppStorage,
  limits: {
    fileSize: 1024 * 1024 * 10, // 10 MB
  },
});

module.exports = ppUpload;

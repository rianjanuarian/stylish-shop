const multer = require("multer");


// const storage = multer.diskStorage({
//     destination: function (req, file, cb) {
//         cb(null, "public/uploads"); // Simpan file di folder 'uploads/'
//     },
//     filename: function (req, file, cb) {
//         cb(null, file.fieldname+ Date.now() + '-' + file.originalname); 
//     }
// });

const upload = multer({dest: "public/uploads"});

module.exports = upload;

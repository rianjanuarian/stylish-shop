const cartRoutes = require("express").Router();
const CartController = require('../controllers/CartController');
const { verifyUser } = require("../middlewares/verifyRole");

// cartRoutes.get('/', CartController.getCart);
cartRoutes.post('/create',CartController.create);
cartRoutes.put('/update/:id',CartController.update);
cartRoutes.delete('/delete/:id', CartController.delete);
cartRoutes.get('/user/:id', CartController.getByCart);




module.exports = cartRoutes;
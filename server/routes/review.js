const reviewRoutes = require("express").Router();
const ReviewControllers = require("../controllers/ReviewController");


reviewRoutes.get('/', ReviewControllers.getReviews);
reviewRoutes.get('/:reviewId', ReviewControllers.getReview);
reviewRoutes.get('/:id', ReviewControllers.getReviewByProduct);
reviewRoutes.post('/create', ReviewControllers.createReview);
reviewRoutes.delete('/delete/:id', ReviewControllers.deleteReview);
reviewRoutes.post('/update/:id', ReviewControllers.updateReview);


module.exports = reviewRoutes;
const reviewRoutes = require("express").Router();
const { verifyUser } = require("../middlewares/verifyRole");
const ReviewControllers = require("../controllers/ReviewController");

reviewRoutes.get("/", ReviewControllers.getReviews);
reviewRoutes.get("/:reviewId", verifyUser, ReviewControllers.getReview);
reviewRoutes.get("/:id", verifyUser, ReviewControllers.getReviewByProduct);
reviewRoutes.post(
  "/create/:productId",
  verifyUser,
  ReviewControllers.createReview
);
reviewRoutes.put("/update/:id", verifyUser, ReviewControllers.updateReview);
reviewRoutes.delete("/delete/:id", verifyUser, ReviewControllers.deleteReview);

module.exports = reviewRoutes;

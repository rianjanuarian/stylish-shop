const { review } = require("../models");

class ReviewControllers {
  static async getReviews(req, res, next) {
    try {
      const reviews = await review.findAll();
      res.status(200).json(reviews);
    } catch (error) {
      next(error);
    }
  }

  static async getReview(req, res, next) {
    try {
      const id = parseInt(req.params.reviewId);
      const review = await review.findByPk(id);
      res.status(200).json(review);
    } catch (error) {
      next(error);
    }
  }

  static async getReviewByProduct(req, res, next) {
    try {
      const productId = parseInt(req.params.id);
      const reviews = await review.findAll({
        where: {
          productId,
        },
      });
      res.status(200).json(reviews);
    } catch (error) {
      next(error);
    }
  }

  static async createReview(req, res, next) {
    try {
      const user_id = req.user.dataValues.id;
      const products_id = parseInt(req.params.productId);
      const newReview = await review.create({
        review: req.body.review,
        user_id,
        products_id,
      });
      res.status(201).json(newReview);
    } catch (error) {
      next(error);
    }
  }

  static async updateReview(req, res, next) {
    try {
      const user_id = req.user.dataValues.id;
      const id = parseInt(req.params.id);
      const currentReview = await review.findByPk(id);

      if (!currentReview) {
        return next(createError(404, "Review not found!"));
      }

      if (user_id !== currentReview.user_id) {
        return next(createError(401, "You are not the owner of this review!"));
      }

      const response = await currentReview.update({
        review: req.body.review,
      });

      if (response.dataValues) {
        res.status(200).json({ message: "success updated review" });
      }
    } catch (error) {
      next(error);
    }
  }

  static async deleteReview(req, res, next) {
    try {
      const id = parseInt(req.params.id);
      const user_id = req.user.dataValues.id;
      const currentReview = await review.findByPk(id);

      if (!currentReview) {
        return next(createError(404, "Review not found!"));
      }

      if(user_id !== currentReview.user_id) {
        return next(createError(401, "You are not the owner of this review!"));
      }

      await currentReview.destroy();

      res.status(200).json({ message: "success deleted review" });
    } catch (error) {
      next(error);
    }
  }
}

module.exports = ReviewControllers;

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
      const review = await review.create(req.body);
      res.status(201).json(review);
    } catch (error) {
      next(error);
    }
  }

  static async updateReview(req, res, next) {
    try {
      const id = parseInt(req.params.id);
      const response = await review.update(req.body, {
        where: {
          id,
        },
      });
      if (response[0] === 1) {
        res.status(200).json({ msg: "success updated review" });
      }
    } catch (error) {
      next(error);
    }
  }

  static async deleteReview(req, res, next) {
    try {
      const id = parseInt(req.params.id);
      const response = await review.destroy({
        where: {
          id,
        },
      });
      if (response === 1) {
        res.status(200).json({ msg: "success deleted review" });
      }
    } catch (error) {
        next(error);
    }
  }
}

module.exports = ReviewControllers;

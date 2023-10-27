const createError = require("../middlewares/createError")
const {product,category,brand, categoryproduct, brandproduct} = require("../models")
const { Op } = require('sequelize');

class ProductControllers {
  static async getData(req, res, next) {
    try {
        const result = await product.findAll({
            include: [category,brand],
        })
        res.json(result)
    } catch (error) {
        next(error)
    }
  }

  static async create(req, res) {
    try {
        let {name,price,description,stock,image,categoryId,brandId} = req.body
        const products = await product.create({
            name,
            price,
            description,
            stock,
            image
        })

      
        const productCategories = await categoryproduct.create({
            productId : +products.id,
            categoryId : +categoryId
        })

        const productBrands = await brandproduct.create({
            productId : +products.id,
            brandId : +brandId
        })

        res.json({message:"success"})
    } catch (error) {
        next(error)
    }
  }

  static async delete(req, res) {
    try {
        const id = +req.params.id
        let result = await product.destroy({
            where: {id},
        })
        res.json({message:"delete success"})
    } catch (error) {
        next(error)
    }
  }
  
  static async update(req,res){
    try {
        const id = +req.params.id
        const {name,price,description,stock,image} = req.body
        let result = await product.update({
            name,price,description,stock,image
        },{
            where:{id}
        })
        res.json(result)
    } catch (error) {
        res.json(error)   
    }
  }

  static async detail(req,res){
    try {
        const id = +req.params.id;
        let result = await product.findByPk(id,{
            include: [
                category,brand
            ]
        })
        res.json(result)
    } catch (error) {
        res.json(error)
    }
  }

  static async getProductsByCategories(req,res){
    try {
        const id = +req.params.id
        let result = await category.findByPk(id,{
            include:[product]
        })
        res.json(result)
    } catch (error) {
        res.json(error)
    }
  }

  static async getProductsByBrands(req,res){
    try {
        const id = +req.params.id
        let result = await brand.findByPk(id,{
            include:[product]
        })
        res.json(result)
    } catch (error) {
        res.json(error)
    }
  }

  static async getProductsBySearch(req,res){
    try {
        const {name} = req.query
       let result = await product.findAll({
           include: [category,brand],
           where : {
            name:{
                [Op.iLike]: `%${name}%`
            }
           }
        })
     res.json(result)
      
    } catch (error) {
        res.json(error)
    }
  }
  static async getProductsBycategorySearch(req,res){
    try {
        const {categories} = req.query
        let result = await category.findAll({
            include: [product],
            where : {
                name:{
                    [Op.iLike]: `%${categories}%`
                }
            }
        })
        res.json(result)
    } catch (error) {
        res.json(error)
    }
  }
  static async getProductsBybrandSearch(req,res){
    try {
        const {brands} = req.query
        let result = await brand.findAll({
            include: [product],
            where : {
                name:{
                    [Op.iLike]: `%${brands}%`
                }
            }
        })
        res.json(result)
    } catch (error) {
        res.json(error)
    }
  }
}

module.exports = ProductControllers;

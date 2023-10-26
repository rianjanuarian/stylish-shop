const {product,category,brand, categoryproduct, brandproduct} = require("../models")
class ProductControllers {
  static async getData(req, res) {
    try {
        const result = await product.findAll({
            include: [category,brand],
        })
        res.json(result)
    } catch (error) {
        res.json(error)
    }
  }

  static async create(req, res) {
    try {
        let {name,price,description,stock,image,categoryName,brandName,imageName} = req.body
        const products = await product.create({
            name,
            price,
            description,
            stock,
            image
        })
        const categories = await category.create({
            name: categoryName
        })
        const brands = await brand.create({
            name: brandName,
            image: imageName
        })
      
        const productCategories = await categoryproduct.create({
            productId : +products.id,
            categoryId : +categories.id
        })

        const productBrands = await brandproduct.create({
            productId : +products.id,
            brandId : +brands.id
        })

        res.json({message:"success"})
    } catch (error) {
        res.json(error)
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
        res.json(error)
    }
  }
  
  static async update(req,res){}

  static async detail(req,res){}
}

module.exports = ProductControllers;

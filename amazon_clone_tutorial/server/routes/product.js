const expres=require('express');
const productRouter=expres.Router();
const auth=require('../middleware/auth');
const Product=require("../models/product");

productRouter.get("/api/getProducts/",auth,async(req,res)=>{
    try {

        const products=await Product.find({category: req.query.category});
        res.json(products);
    } catch (error) {
        res.status(500).json({error:error.message});
    }
})

// create get request to search products and get them
// /api/products/search/i
productRouter.get("/api/products/search/:name",auth,async(req,res)=>{
    try {

        const products=await Product.find({name: {$regex:req.params.name,$options:"i"}});
        res.json(products);
    } catch (error) {
        res.status(500).json({error:error.message});
    }
})

module.exports=productRouter;
const expres=require('express');
const adminRouter=expres.Router();
const admin=require('../middleware/admin');
const {Product} = require('../models/product');


// Add Product
adminRouter.post('/admin/add-product',admin,async (req,res)=>{
    try {
        const {name,description,images,quantity,price,category}=req.body;
        let product=new Product({
            name,
            description,
            images,
            quantity,
            price,
            category
        });
        product=await product.save();
        res.json(product);
    } catch (error) {
        res.status(500).json({error:e.message});
    }
})

  // get all the products
  adminRouter.get('/admin/getProducts',admin,async (req,res)=>{
    try {
        const products=await Product.find({});
        res.json(products);
    } catch (error) {
        res.status(500).json({error:e.message});
    }
  });

//   delete the product
adminRouter.post('/admin/deleteProduct',async (req,res)=>{
    try {
       const {id}=req.body;
       let product=await Product.findByIdAndDelete(id);
       res.json(product);
       
    } catch (error) {
        res.status(500).json({error:e.message}); 
    }
})

module.exports=adminRouter;




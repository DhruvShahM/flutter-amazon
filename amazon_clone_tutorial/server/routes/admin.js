const expres=require('express');
const adminRouter=expres.Router();
const admin=require('../middleware/admin');
const {Product} = require('../models/product');
const Order = require('../models/order');


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
  adminRouter.get('/admin/getProducts',async (req,res)=>{
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

adminRouter.get('/admin/getOrders',admin,async (req,res)=>{
    try {
        const orders=await Order.find({});
        res.json(orders);

    } catch (error) {
        res.json(500).json({error:error.message});
    }
})

adminRouter.post('/admin/changeOrderStatus',async (req,res)=>{
    try {
       const {id,status}=req.body;
       let order=await Order.findById(id);
       order.status=status;
       order=await order.save();
       res.json(order);
       
    } catch (error) {
        res.status(500).json({error:e.message}); 
    }
})


adminRouter.get('/admin/analytics',async(req,res)=>{
    try {
        const order=await Order.find({});
        let totalEarnings=0;


        for(let i=0;i<order.length;i++){
            for(let j=0;j<order[i].products.length;j++){
                totalEarnings+=order[i].products[j].quantity*order[i].products[j].product.price;
            }
        }

        // CATEGORY WISE ORDER FETCHING

        let mobileEarnings=await fetchCategoryWiseProduct('Mobiles');
        let essentialsEarnings=await fetchCategoryWiseProduct('Essentials');
        let appliancesEarnings=await fetchCategoryWiseProduct('Appliances');
        let booksEarnings=await fetchCategoryWiseProduct('Books');
        let fashionEarnings=await fetchCategoryWiseProduct('Fashion');
        
        let earnings={
            totalEarnings,
            mobileEarnings,
            essentialsEarnings,
            appliancesEarnings,
            booksEarnings,
            fashionEarnings
        };

        res.json(earnings);


    } catch (error) {
        res.status(500).json({error:error.message});
    }
})

async function fetchCategoryWiseProduct(category){

    let earnings=0;

    let categoryOrders=await Order.find({
        'products.product.category':category
    });

    for(let i=0;i<categoryOrders.length;i++){
        for(let j=0;j<categoryOrders[i].products.length;j++){
            earnings+=categoryOrders[i].products[j].quantity*categoryOrders[i].products[j].product.price;
        }
    }

    return earnings;
}

module.exports=adminRouter;




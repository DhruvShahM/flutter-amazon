const expres=require('express');
const auth = require('../middleware/auth');
const userRouter=expres.Router();
const {Product}=require('../models/product');
const User = require("../models/user");

userRouter.post('/api/addToCart',auth,async (req,res)=>{
    try {
        const {id}=req.body;
        const product=await Product.findById(id);
        let user=await User.findById(req.user);
        let isProductFound=false;


        if(user.cart.length===0){
            user.cart.push({product,quantity:1});
        }
        else{
            for(let i=0;i<user.cart.length;i++){
                if(user.cart[i].product._id.equals(product._id)){
                    isProductFound=true;
                    break;
                }
            }


        if(isProductFound){
            let producttt =user.cart.find((producttt)=> producttt.product._id.equals(product._id));
            producttt.quantity+=1;
        }
        else{
            user.cart.push({product,quantity:1});
        }
    }

        user=await user.save();
        res.json(user);

    } catch (error) {
        res.status(500).json({error:e.message});
    }
})

userRouter.delete('/api/removeFromCart/:id',auth,async (req,res)=>{
    try {
        const {id}=req.params;
        const product=await Product.findById(id);
        let user=await User.findById(req.user);

            for(let i=0;i<user.cart.length;i++){
                if(user.cart[i].product._id.equals(product._id)){
                    if(user.cart[i].quantity==1){
                        user.cart.splice(i,1);
                    }
                    else{
                        user.cart[i].quantity-=1;
                    }
                }
            }
        

        user=await user.save();
        res.json(user);

    } catch (error) {
        res.status(500).json({error:e.message});
    }
})

module.exports=userRouter;
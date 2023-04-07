const mongoose = require('mongoose');

const productSchmea=mongoose.Schema({
    name:{
        type:String,
        required:true,
        trim:true
    },
    description:{
        type:String,
        required:true,
        trim:true
    },
    images:[
        {
            type:String,
            required:true,
        }
    ],
    quantity:{
        type:Number,
        required:true
    },
    price:{
        type:Number,
        required:true
    },
    category:{
        type:String,
        required:true
    }
    // rating
});


const Product=mongoose.model('Product',productSchmea);
module.exports=Product;
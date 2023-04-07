const path=require('path');
const dotenv=require('dotenv');
const express = require('express');
const authRouter = require("./routes/auth");
const adminRouter = require("./routes/admin");
const mongoose = require('mongoose');
const productRouter = require('./routes/product');

const absolute=path.resolve("./.env")
console.log(absolute);
const result =dotenv.config({path:absolute});
if (result.error) {
  const paths=path.resolve("./amazon_clone_tutorial/server/.env")
  console.log(paths);
  dotenv.config({path:paths})
  }

 const db=process.env.DATABASE_URL 
 console.log(db)





const PORT = 3000;
const app = express();

// Middleware
app.use(express.json());
app.use(authRouter);
app.use(adminRouter);
app.use(productRouter);

// Connections
mongoose.connect(db, { useUnifiedTopology: true, useNewUrlParser: true }).then(() => {
    console.log('connection successful');
}).catch((e)=>{
    console.log(e);
})



console.log('Hello world');


app.listen(PORT,"0.0.0.0", () => {
    console.log(`connected at port ${PORT} hello`);
});





import 'package:amazon_clone_tutorial/common/widgets/loader.dart';
import 'package:amazon_clone_tutorial/features/account/widgets/single_product.dart';
import 'package:amazon_clone_tutorial/features/admin/services/admin_services.dart';
import 'package:amazon_clone_tutorial/features/order_details/screens/order_detail_screen.dart';
import 'package:amazon_clone_tutorial/models/order.dart';
import 'package:flutter/material.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen ({Key? key}): super(key: key);

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {

  List<Order>? orders;
  
  final AdminServices adminServices=AdminServices();

  fetchOrders() async{
    orders= await adminServices.fetchAllOrders(context);
    setState(() {
      
    });
  }

  @override
  void initState() {
    super.initState();
   fetchOrders();
  }

  @override
  Widget build(BuildContext context) {
    return orders==null ? const Loader() : GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount:2
      ),
      itemCount: orders!.length,
      itemBuilder: (context,index){
        final orderData = orders![index];
        return GestureDetector(
          onTap: (){
            Navigator.pushNamed(context, OrderDetailScreen.routeName,arguments: orderData);
          },
          child: SizedBox(height:140,child:SingleProduct(image: orderData.products[0].images[0],)));

      },
    );
  }
}
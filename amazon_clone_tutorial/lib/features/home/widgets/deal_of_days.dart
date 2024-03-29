import 'package:amazon_clone_tutorial/common/widgets/loader.dart';
import 'package:amazon_clone_tutorial/constants/global_variables.dart';
import 'package:amazon_clone_tutorial/features/admin/services/home_services.dart';
import 'package:amazon_clone_tutorial/features/product_details/screens/product_detail_screen.dart';
import 'package:amazon_clone_tutorial/models/product.dart';
import 'package:flutter/material.dart';

class DealOfDay extends StatefulWidget {
  const DealOfDay({Key? key}) : super(key: key);

  @override
  State<DealOfDay> createState() => _DealOfDayState();
}

class _DealOfDayState extends State<DealOfDay> {
  Product? product;
  final HomeServices homeServices=HomeServices();

  @override
  void initState() {
    super.initState();
    fetchDealOfDay();
  }

  void fetchDealOfDay() async {
    product=await homeServices.fetchDealOfDay(context: context);
    setState(() {
      
    });
  }

  void navigateToDetailScreen(){
    Navigator.pushNamed(context, ProductDetailScreen.routeName,arguments: product);
  }

  @override
  Widget build(BuildContext context) {
    return product == null
        ? const Loader()
        : product!.name.isEmpty ? const SizedBox() : GestureDetector(
          onTap: navigateToDetailScreen,
          child: Column(
              children: [
                Container(
                    alignment: Alignment.topLeft,
                    padding: const EdgeInsets.only(left: 10, top: 15),
                    child: const Text(
                      'Deal of the day',
                      style: TextStyle(fontSize: 20),
                    )),
                Image.network(
                   product!.images[0],
                    height: 235,
                    fit: BoxFit.fitHeight),
                Container(
                  padding: const EdgeInsets.only(left: 15),
                  alignment: Alignment.topLeft,
                  child: const Text(
                    '\$999.0',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                Container(
                  alignment: Alignment.topLeft,
                  padding: const EdgeInsets.only(left: 15, top: 5, right: 14),
                  child: const Text(
                    'Dhruv',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: product!.images.map((e) => Image.network(
                        e,
                        fit: BoxFit.fitHeight,
                        height: 100,
                        width: 100,
                      ),).toList()
                      
                    ,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 15,
                  ).copyWith(left: 15),
                  alignment: Alignment.topLeft,
                  child: Text(
                    'See all deals',
                    style: TextStyle(
                      color: GlobalVariables.selectedNavBarColor,
                    ),
                  ),
                )
              ],
            ),
        );
  }
}

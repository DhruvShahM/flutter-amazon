import 'package:amazon_clone_tutorial/constants/global_variables.dart';
import 'package:amazon_clone_tutorial/common/widgets/loader.dart';
import 'package:amazon_clone_tutorial/features/home/widgets/address_box.dart';
import 'package:amazon_clone_tutorial/features/search/services/search_Services.dart';
import 'package:amazon_clone_tutorial/features/search/widget/searched_product.dart';
import 'package:amazon_clone_tutorial/models/product.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  static const String routeName = '/search-screen';
  final String searchQuery;
  const SearchScreen({Key? key, required this.searchQuery}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<Product>? products;
  final SearchServices searchServices = SearchServices();

  @override
  void initState() {
    super.initState();
    fetchSearchProduct();
  }

  fetchSearchProduct() async {
    products = await searchServices.fetchSearchProducts(
        context: context, searchQuery: widget.searchQuery);
    setState(() {});
  }

  void navigateToSearchQuery(String query) {
    Navigator.pushNamed(context, SearchScreen.routeName, arguments: query);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
            appBar: PreferredSize(
              preferredSize: const Size.fromHeight(60),
              child: AppBar(
                  flexibleSpace: Container(
                    decoration: const BoxDecoration(
                        gradient: GlobalVariables.appBarGradient),
                  ),
                  title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Container(
                            height: 42,
                            margin: const EdgeInsets.only(left: 15, top: 2),
                            child: Material(
                              borderRadius: BorderRadius.circular(7),
                              elevation: 1,
                              child: TextFormField(
                                onFieldSubmitted: navigateToSearchQuery,
                                decoration: InputDecoration(
                                  prefix: InkWell(
                                    onTap: () {},
                                    child: const Padding(
                                      padding: EdgeInsets.only(left: 6),
                                      child: Icon(
                                        Icons.search,
                                        color: Colors.black,
                                        size: 23,
                                      ),
                                    ),
                                  ),
                                  filled: true,
                                  fillColor: Colors.white,
                                  contentPadding:
                                      const EdgeInsets.only(top: 10),
                                  border: const OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(7)),
                                      borderSide: BorderSide.none),
                                  enabledBorder: const OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(7)),
                                      borderSide: BorderSide(
                                          color: Colors.black38, width: 1)),
                                  hintText: 'Search Amazon.in',
                                  hintStyle: const TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 17,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          color: Colors.transparent,
                          height: 42,
                          margin: const EdgeInsets.symmetric(horizontal: 10),
                          child: const Icon(Icons.mic,
                              color: Colors.black, size: 25),
                        )
                      ])),
            ),
            body: products == null
        ? const Loader()
        : Column(
              children: [
                const AddressBox(),
                const SizedBox(height: 10),
                Expanded(child:ListView.builder(itemCount: products!.length,itemBuilder: (context,index) {
                  return SearchProduct(product: products![index]);
                })
        )],
            ));
  }
}

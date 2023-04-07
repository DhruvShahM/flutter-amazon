import 'dart:convert';
import 'dart:io';

import 'package:amazon_clone_tutorial/constants/error_handling.dart';
import 'package:amazon_clone_tutorial/constants/global_variables.dart';
import 'package:amazon_clone_tutorial/constants/utils.dart';
import 'package:amazon_clone_tutorial/models/product.dart';
import 'package:amazon_clone_tutorial/providers/user_provider.dart';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class AdminServices {
  void sellProducts(
      {required BuildContext context,
      required String name,
      required String description,
      required double price,
      required double quantity,
      required String category,
      required List<File> images}) async {
    try {
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      final cloudinary = CloudinaryPublic('dce47wn4p', 'ovythhww');
      List<String> imagesUrls = [];

      for (int i = 0; i < images.length; i++) {
        CloudinaryResponse res = await cloudinary
            .uploadFile(CloudinaryFile.fromFile(images[i].path, folder: name));
        imagesUrls.add(res.secureUrl);
      }

      Product product = Product(
          name: name,
          description: description,
          quantity: quantity,
          images: imagesUrls,
          category: category,
          price: price);

      http.Response res = await http.post(Uri.parse('$uri/admin/add-product'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'x-auth-token': userProvider.user.token
          },
          body: product.toJson());

      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            showSnackBar(context, 'Prodcut Added Successfully');
            Navigator.pop(context);
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  // get all products
  // /admin/getProducts

  Future<List<Product>> fetchAllProducts(BuildContext context) async {
    final userProvider = Provider.of<UserProvider>(context,listen: false);
    List<Product> productList = [];

    try {
      http.Response res =
          await http.get(Uri.parse('$uri/admin/getProducts'), headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'x-auth-token': userProvider.user.token
      });

      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            for (int i = 0; i < jsonDecode(res.body).length; i++) {
              productList
                  .add(Product.fromJson(jsonEncode(jsonDecode(res.body)[i])));
            }
          });


    } catch (e) {
      showSnackBar(context, e.toString());
    }

    return productList;
  }

  // delete the product
  // /admin/deleteProduct
  void deleteProduct({required BuildContext context,required Product product,required VoidCallback onSuccess}) async{
       final userProvider = Provider.of<UserProvider>(context,listen: false);
        try {
      http.Response res =
          await http.post(Uri.parse('$uri/admin/deleteProduct'), headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'x-auth-token': userProvider.user.token
      },
      body: jsonEncode({
        'id':product.id
      }));

      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            showSnackBar(context, 'Delete the product successfully.');
            onSuccess();
          });


    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}

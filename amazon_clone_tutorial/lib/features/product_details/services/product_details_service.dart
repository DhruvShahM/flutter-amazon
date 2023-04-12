import 'dart:convert';

import 'package:amazon_clone_tutorial/constants/error_handling.dart';
import 'package:amazon_clone_tutorial/constants/global_variables.dart';
import 'package:amazon_clone_tutorial/constants/utils.dart';
import 'package:amazon_clone_tutorial/models/product.dart';
import 'package:amazon_clone_tutorial/models/users.dart';
import 'package:amazon_clone_tutorial/providers/user_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class ProductDetailsServices {

    void addToCart(
      {required BuildContext context,
      required Product product}) async {
    try {
      final userProvider = Provider.of<UserProvider>(context, listen: false);

      http.Response res = await http.post(Uri.parse('$uri/api/addToCart'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'x-auth-token': userProvider.user.token
          },
          body: jsonEncode({'id': product.id!}));

      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            // showSnackBar(context, 'product added in a cart to succcessfully');
            User user=userProvider.user.copyWith(
              cart:jsonDecode(res.body)['cart']
            );
            userProvider.setUserFromModel(user);
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  void rateProduct(
      {required BuildContext context,
      required Product product,
      required double rating}) async {
    try {
      final userProvider = Provider.of<UserProvider>(context, listen: false);

      http.Response res = await http.post(Uri.parse('$uri/api/rateProduct'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'x-auth-token': userProvider.user.token
          },
          body: jsonEncode({'id': product.id, 'rating': rating}));

      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            // showSnackBar(context, 'rating updated succcessfully');
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}

import 'dart:convert';
import 'dart:io';

import 'package:amazon_clone_tutorial/constants/error_handling.dart';
import 'package:amazon_clone_tutorial/constants/global_variables.dart';
import 'package:amazon_clone_tutorial/constants/utils.dart';
import 'package:amazon_clone_tutorial/models/users.dart';
import 'package:amazon_clone_tutorial/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class AddressServices {

  void sellProducts(
      {required BuildContext context, 
      required List<File> images,
      required String address,
      }) async {
    try {
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      http.Response res = await http.post(Uri.parse('$uri/api/save-user-address'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'x-auth-token': userProvider.user.token
          },
          body: jsonEncode({
            'address':address
          }));

      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            User user=userProvider.user.copyWith(
              address: jsonDecode(res.body)['address']
            );
            userProvider.setUserFromModel(user);
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}

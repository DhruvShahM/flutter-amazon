import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:amazon_clone_tutorial/models/users.dart';
class UserProvider extends ChangeNotifier{
    User _user=User(
      id:'',
      name:'',
      email:'',
      password:'',
      address:'',
      type:'',
      token:''
    );

    User get user=>_user;

    void setUser(String user){
      _user=User.fromJson(user);
      notifyListeners();
    }

}
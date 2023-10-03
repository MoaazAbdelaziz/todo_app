import 'package:flutter/material.dart';
import 'package:todo_app/models/user_model.dart';

class AuthProvider extends ChangeNotifier {
  UserModel? currentUser;

  void updateUser(UserModel newUser) {
    currentUser = newUser;
    notifyListeners();
  }
}

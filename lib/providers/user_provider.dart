import 'package:flutter/material.dart';
import 'package:socio_sphere/authentication/auth_methods.dart';
import 'package:socio_sphere/models/user.dart';

class UserProvider extends ChangeNotifier {
  User? _user;

  final AuthMethods _authMethods = AuthMethods();

  User get getUser => _user!;
  Future<void> refreshUser() async {
    User user = await _authMethods.getUserDetails();
    _user=user;
    notifyListeners();
  }
}
import 'package:flutter/material.dart';

class AuthService with ChangeNotifier {
  String? _name;
  String? _address;
  String? _phoneNumber;
  bool _isLoggedIn = false;

  String? get name => _name;
  String? get address => _address;
  String? get phoneNumber => _phoneNumber;
  bool get isLoggedIn => _isLoggedIn;

  void login(String name, String address, String phoneNumber) {
    _name = name;
    _address = address;
    _phoneNumber = phoneNumber;
    _isLoggedIn = true;
    notifyListeners();
  }

  void logout() {
    _name = null;
    _address = null;
    _phoneNumber = null;
    _isLoggedIn = false;
    notifyListeners();
  }

  void updateProfile(String name, String address, String phoneNumber) {
    _name = name;
    _address = address;
    _phoneNumber = phoneNumber;
    notifyListeners();
  }
}

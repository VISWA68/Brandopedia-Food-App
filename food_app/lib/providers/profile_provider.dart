import 'package:flutter/material.dart';
import '../data/local/db_helper.dart';

class ProfileProvider with ChangeNotifier {
  String _name = '';
  String _email = '';
  String _phone = '';
  String _address = '';
  bool _isProfileComplete = false;

  String get name => _name;
  String get email => _email;
  String get phone => _phone;
  String get address => _address;
  bool get isProfileComplete => _isProfileComplete;

  Future<void> loadProfile() async {
    final profile = await DBHelper().getUserProfile();
    if (profile != null) {
      _name = profile['name'] ?? '';
      _email = profile['email'] ?? '';
      _phone = profile['phone'] ?? '';
      _address = profile['address'] ?? '';
      _isProfileComplete = true;
    } else {
      _isProfileComplete = false;
    }
    notifyListeners();
  }

  Future<void> saveProfile(String name, String email, String phone, String address) async {
    await DBHelper().saveUserProfile(name, email, phone, address);
    _name = name;
    _email = email;
    _phone = phone;
    _address = address;
    _isProfileComplete = true;
    notifyListeners();
  }
}

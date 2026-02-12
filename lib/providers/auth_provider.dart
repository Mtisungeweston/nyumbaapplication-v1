import 'package:flutter/material.dart';
import '../models/auth_model.dart';
import '../data/test_data.dart';

class AuthProvider extends ChangeNotifier {
  AuthModel _state = AuthModel();
  String _userRole = '';
  String _userName = '';
  bool _isRegistered = false;

  AuthModel get state => _state;
  String get userRole => _userRole;
  String get userName => _userName;
  bool get isRegistered => _isRegistered;

  Future<void> requestOTP(String phoneNumber) async {
    _state = AuthModel(phoneNumber: phoneNumber);
    notifyListeners();

    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 800));

    // Mock OTP sent
    _state = _state.copyWith(isOtpSent: true, errorMessage: null);
    notifyListeners();
  }

  Future<bool> verifyOTP(String otp) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 800));

    // Check if OTP matches test data
    if (otp == TEST_OTP) {
      _state = _state.copyWith(isVerified: true, errorMessage: null);
      notifyListeners();
      return true;
    } else {
      _state = _state.copyWith(errorMessage: 'Invalid OTP. Try: $TEST_OTP');
      notifyListeners();
      return false;
    }
  }

  void setUserRole(String role, String name) {
    _userRole = role;
    _userName = name;
    _isRegistered = true;
    _state = _state.copyWith(isVerified: true);
    notifyListeners();
  }

  void updateProfile(String name, String role) {
    _userName = name;
    _userRole = role;
    notifyListeners();
  }

  void logout() {
    _state = AuthModel();
    _userRole = '';
    _userName = '';
    _isRegistered = false;
    notifyListeners();
  }

  void reset() {
    _state = AuthModel();
    notifyListeners();
  }
}

// lib/services/api_service.dart (FINAL CODE with Fast2SMS Key)

import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;

class ApiService {
  // --- CONFIGURATION ---
  
  // 1. Fast2SMS Key (Aapke Screenshot se li gayi final key)
  static const String _otpApiKey = 'ghOtMQlXJKr8FkL3jayPw6452fsRziubdocE0Ypq1G'; 

  // 2. InfinityFree Razorpay Order Creation URL (BADALNA ZAROORI HAI)
  // Example: 'https://aapkiwebsite.com/create_order.php'
  static const String _createOrderUrl = 'https://yourinfinityfreehost.com/create_order.php'; 

  // Store OTP temporarily 
  static Map<String, String> _tempOtpStorage = {}; 

  // --- 1. AUTHENTICATION SERVICE (Fast2SMS) ---
  
  // Send OTP Function
  Future<bool> sendOtp(String mobileNumber) async {
    try {
      final String otp = (100000 + Random().nextInt(899999)).toString();
      _tempOtpStorage[mobileNumber] = otp; 
      
      final url = Uri.parse('https://www.fast2sms.com/dev/bulkV2');
      final response = await http.post(
        url,
        headers: {
          'authorization': _otpApiKey, // FINAL KEY USED HERE
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          "route": "otp", 
          "sender_id": "FSTSMS", 
          "message": "Your GAMERZADDA OTP is $otp",
          "variables": "{}",
          "numbers": [mobileNumber],
        }),
      );
      
      return response.statusCode == 200 || response.statusCode == 202;
    } catch (e) {
      print('Network Error in sendOtp: $e');
      return false;
    }
  }

  // Verify OTP Function
  Future<bool> verifyOtp(String mobileNumber, String enteredOtp) async {
    if (_tempOtpStorage[mobileNumber] == enteredOtp) {
      _tempOtpStorage.remove(mobileNumber); 
      return true;
    }
    return false;
  }

  // --- 2. PAYMENT SERVICE (Razorpay/InfinityFree) ---

  // Razorpay Order Creation Function (PHP Server Ko Call Karega)
  Future<Map<String, dynamic>> createRazorpayOrder(double amount, String userId) async {
    final response = await http.post(
      Uri.parse(_createOrderUrl), // FINAL URL BADALNA HAI
      headers: <String, String>{
        'Content-Type': 'application/x-www-form-urlencoded',
      },
      body: { 
        'amount': amount.toString(),
        'user_id': userId, 
      },
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body); 
    } else {
      throw Exception('Failed to create Razorpay Order. Status: ${response.statusCode}');
    }
  }
  
  // --- 3. GENERAL SERVICES (Games/Tournaments) ---
  
  Future<List<Map<String, dynamic>>> fetchGames() async {
    // Demo data for now
    return [
      {'id': '1', 'name': 'FREE FIRE', 'imageUrl': 'assets/game_ff.jpg'},
      // ...
    ];
  }
}
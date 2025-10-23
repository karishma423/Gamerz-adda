// lib/screens/login_screen.dart V2

import 'package:flutter/material.dart';
import 'otp_verification_screen.dart'; // OTP screen ko import kiya
import 'signup_screen.dart';           // Signup screen ko import kiya

const Color primaryRed = Color(0xFFE50045); 
const Color darkBackground = Color(0xFF1E1E1E);

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _mobileController = TextEditingController();
  bool _isLoading = false;

  void _sendOtpAndNavigate() async {
    // Basic Validation
    String mobile = _mobileController.text.trim();
    if (mobile.isEmpty || mobile.length != 10 || !RegExp(r'^[0-9]+$').hasMatch(mobile)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a valid 10-digit mobile number.')),
      );
      return;
    }

    setState(() => _isLoading = true);

    // Yahan par hum seedha OTP verification screen par jaayenge
    // Aur OTP bhej ne ka kaam uss screen ke initState mein ho jayega.
    
    // Lekin best practice ke liye, hum yahin par sendOtp API call shuru karte hain
    // Taki user ko pata chale ki kuch ho raha hai.
    
    // (Actual API call ko hum OtpVerificationScreen mein shift kar rahe hain,
    // jisse loading state manage karna aasan ho)

    // Ab hum directly navigate kar rahe hain
    setState(() => _isLoading = false);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => OtpVerificationScreen(mobileNumber: mobile),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkBackground,
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 25.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            // 1. Logo
            const SizedBox(height: 60),
            Center(
              child: Image.asset(
                'assets/logo.png', // Aapka App Logo
                height: 150,
              ),
            ),
            const SizedBox(height: 20),

            // 2. Title
            const Text(
              'Login', 
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 20),

            // 3. Mobile Number Input Field
            _buildInputField(
              controller: _mobileController,
              hintText: 'Mobile Number', 
              icon: Icons.call_outlined, 
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 30),

            // 4. SEND OTP Button
            _buildSendOtpButton(
              text: 'SEND OTP',
              onPressed: _isLoading ? null : _sendOtpAndNavigate, // Loading state mein disable
            ),
            const SizedBox(height: 80),

            // 5. New User? Create an Account Link
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('New User? ', style: TextStyle(color: Colors.white70)),
                GestureDetector(
                  onTap: () {
                    // Signup Screen par navigate karein
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const SignupScreen()));
                  },
                  child: const Text(
                    'Create an Account',
                    style: TextStyle(
                      color: primaryRed,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 150), 

            // 6. Bottom Text
             const Text(
              'ONLINE GAMING IS ADDICTIVE IN NATURE',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white54, fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 1),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  // --- Reusable Widgets ---
  
  Widget _buildInputField({
    required TextEditingController controller,
    required String hintText,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      maxLength: 10,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        counterText: '', // Hide the character counter
        prefixIcon: Icon(icon, color: primaryRed),
        hintText: hintText,
        hintStyle: const TextStyle(color: Colors.white54),
        filled: true,
        fillColor: const Color(0xFF2C2C2C),
        contentPadding: const EdgeInsets.symmetric(vertical: 18.0, horizontal: 15.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none),
        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: primaryRed, width: 2)),
      ),
    );
  }

  Widget _buildSendOtpButton({required String text, required VoidCallback? onPressed}) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: onPressed == null ? Colors.grey : const Color(0xFF333333), // Loading state mein grey
        boxShadow: onPressed == null ? null : [
          BoxShadow(
            color: primaryRed.withOpacity(0.4),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(10),
          child: Center(
            child: _isLoading 
              ? const CircularProgressIndicator(color: Colors.white)
              : Text(
                  text,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
          ),
        ),
      ),
    );
  }
}
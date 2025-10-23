// lib/screens/signup_screen.dart V2

import 'package:flutter/material.dart';
import 'otp_verification_screen.dart'; // OTP screen ko import kiya
import 'login_screen.dart';           // Login screen ko import kiya

const Color primaryRed = Color(0xFFE50045); 
const Color darkBackground = Color(0xFF1E1E1E);

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  // Controllers
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _referralController = TextEditingController();

  // State
  bool _agreedToTerms = false;
  bool _agreedToKyc = false;
  bool _isLoading = false;

  void _sendOtpAndNavigate() async {
    // Basic Validation
    String mobile = _mobileController.text.trim();
    if (mobile.isEmpty || mobile.length != 10 || !_agreedToTerms || !_agreedToKyc) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill all required fields and agree to terms.')),
      );
      return;
    }

    setState(() => _isLoading = true);

    // Yahan par hum signup data ko local memory mein ya future mein Firebase mein store kar sakte hain.
    // Abhi hum seedha OTP verification screen par navigate kar rahe hain.

    // Simulate Network Delay (Optional)
    await Future.delayed(const Duration(milliseconds: 500)); 
    
    setState(() => _isLoading = false);

    // OTP Verification Screen par bhej te hain
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
                'assets/logo.png', 
                height: 150,
              ),
            ),
            const SizedBox(height: 20),
            
            // 2. Title
            const Text(
              'Create an Account', 
              style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 20),

            // 3. Input Fields
            _buildInputField(controller: _nameController, hintText: 'Name', icon: Icons.person_outline),
            const SizedBox(height: 15),
            _buildInputField(controller: _mobileController, hintText: 'Mobile Number', icon: Icons.call_outlined, keyboardType: TextInputType.phone, isMobile: true),
            const SizedBox(height: 15),
            _buildInputField(controller: _emailController, hintText: 'Email', icon: Icons.mail_outline, keyboardType: TextInputType.emailAddress),
            const SizedBox(height: 15),
            _buildInputField(controller: _referralController, hintText: 'Referral Code (Optional)', icon: Icons.share_outlined, isOptional: true),
            const SizedBox(height: 25),

            // 4. Checkbox 1: Terms & Conditions
            _buildCheckboxWithText(
              value: _agreedToTerms,
              onChanged: (bool? newValue) { setState(() { _agreedToTerms = newValue ?? false; }); },
              text: 'Please check Terms & Condition and Legality & Legality & Responsible Gaming & Privacy Policy to further proceed',
            ),
            const SizedBox(height: 15),

            // 5. Checkbox 2: 18+ and KYC
            _buildCheckboxWithText(
              value: _agreedToKyc,
              onChanged: (bool? newValue) { setState(() { _agreedToKyc = newValue ?? false; }); },
              text: "I'm 18 years old and I understand that under-age use of this app may be illegal. I agree to complete my KYC before the first cash withdrawal on the app.",
            ),
            const SizedBox(height: 30),

            // 6. Existing User? Login Now Link
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Existing User? ', style: TextStyle(color: Colors.white70)),
                GestureDetector(
                  onTap: () {
                    // Login Screen par navigate karein (Stack clear karna zaroori hai)
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LoginScreen()));
                  },
                  child: const Text('Login Now', style: TextStyle(color: primaryRed, fontWeight: FontWeight.bold)),
                ),
              ],
            ),
            const SizedBox(height: 15),


            // 7. NEXT Button
            _buildNextButton(
              onPressed: (_agreedToTerms && _agreedToKyc) ? _sendOtpAndNavigate : null, // Checkbox check hone par hi button enable
            ),
            const SizedBox(height: 20),

            // 8. Footer Text
            const Text(
              'You will be receiving a verification code on\nyour entered mobile number',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white54, fontSize: 12),
            ),
            const SizedBox(height: 40),
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
    bool isMobile = false,
    bool isOptional = false,
  }) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      maxLength: isMobile ? 10 : null,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        counterText: isMobile ? '' : null,
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

  Widget _buildCheckboxWithText({required bool value, required ValueChanged<bool?> onChanged, required String text,}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 24.0, width: 24.0,
          child: Checkbox(
            value: value, onChanged: onChanged, activeColor: primaryRed, checkColor: Colors.white,
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            side: const BorderSide(color: Colors.white70, width: 1.5),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text.rich(
            TextSpan(
              text: text.substring(0, text.indexOf('Terms & Condition')),
              style: const TextStyle(color: Colors.white70, fontSize: 13),
              children: <TextSpan>[
                // Terms & Condition ko Red aur underlined karna
                TextSpan(
                  text: 'Terms & Condition and Legality & Legality & Responsible Gaming & Privacy Policy',
                  style: const TextStyle(color: primaryRed, decoration: TextDecoration.underline, decorationColor: primaryRed),
                  // TODO: Yahan par onTap functionality add hogi
                ),
                TextSpan(text: text.substring(text.indexOf('to further proceed'))),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildNextButton({required VoidCallback? onPressed}) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: onPressed == null ? Colors.grey : primaryRed, // Enable/Disable color
        boxShadow: onPressed == null ? null : [
          BoxShadow(color: primaryRed.withOpacity(0.4), blurRadius: 10, offset: const Offset(0, 4)),
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
              : const Text(
                  'NEXT',
                  style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                ),
          ),
        ),
      ),
    );
  }
}
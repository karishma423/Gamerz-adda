// lib/screens/add_money_screen.dart (Final Code - Cleaned)

import 'package:flutter/material.dart';
// Agar aap Razorpay use kar rahe hain toh yeh package zaroori hai
// import 'package:razorpay_flutter/razorpay_flutter.dart'; 
// import '../services/api_service.dart';

const Color primaryRed = Color(0xFFE50045); 
const Color darkBackground = Color(0xFF1E1E1E);

class AddMoneyScreen extends StatefulWidget {
  const AddMoneyScreen({super.key});

  @override
  State<AddMoneyScreen> createState() => _AddMoneyScreenState();
}

class _AddMoneyScreenState extends State<AddMoneyScreen> {
  final List<int> fixedAmounts = const [100, 200, 500, 1000, 2000, 5000];
  final TextEditingController _amountController = TextEditingController();
  // final ApiService _apiService = ApiService(); // Commented out to keep code clean
  // late Razorpay _razorpay; // Commented out to keep code clean
  
  // Real App mein is function mein Razorpay ka code aayega
  void _startPaymentProcess() async {
    double? amount = double.tryParse(_amountController.text);

    if (amount == null || amount < 10) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a valid amount (Min ₹10).')),
      );
      return;
    }

    // --- YAHAN PAR FINAL RAZORPAY / PHP SERVER KA CODE AAYEGA ---
    
    // Abhi hum sirf ek demo message dikhate hain
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Processing ₹$amount for payment..."))
    );
  }

  // --- UI ---
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkBackground,
      appBar: AppBar(
        backgroundColor: primaryRed,
        leading: const BackButton(color: Colors.white),
        title: const Text('Add Money', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        actions: const [Padding(padding: EdgeInsets.only(right: 15.0), child: Icon(Icons.notifications_none, color: Colors.white))],
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Select Amount', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 15),

                  _buildAmountButtons(),
                  const SizedBox(height: 30),

                  const Text('Or enter a different amount', style: TextStyle(color: Colors.white70, fontSize: 16)),
                  const SizedBox(height: 15),

                  _buildCustomAmountField(),
                  const SizedBox(height: 10),

                  // Coupon Code Link
                  Center(
                    child: TextButton(
                      onPressed: () {},
                      child: const Text('Have coupon code? Click here!', style: TextStyle(color: primaryRed, decoration: TextDecoration.underline)),
                    ),
                  ),
                ],
              ),
            ),
          ),
          
          // Bottom Add Button
          _buildAddButton(context),
        ],
      ),
    );
  }

  Widget _buildAmountButtons() {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3, crossAxisSpacing: 10, mainAxisSpacing: 10, childAspectRatio: 2.5,
      ),
      itemCount: fixedAmounts.length,
      itemBuilder: (context, index) {
        return ElevatedButton(
          onPressed: () {
            // Amount select hone par input field mein set karo
            _amountController.text = fixedAmounts[index].toString();
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF2C2C2C),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
          child: Text('₹${fixedAmounts[index]}', style: const TextStyle(color: Colors.white, fontSize: 16)),
        );
      },
    );
  }

  Widget _buildCustomAmountField() {
    return TextField(
      controller: _amountController,
      keyboardType: TextInputType.number,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        hintText: 'enter amount in rupees',
        hintStyle: const TextStyle(color: Colors.white54),
        filled: true,
        fillColor: const Color(0xFF2C2C2C),
        contentPadding: const EdgeInsets.symmetric(vertical: 18.0, horizontal: 15.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide.none),
      ),
    );
  }

  Widget _buildAddButton(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16.0),
      child: ElevatedButton(
        onPressed: _startPaymentProcess,
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryRed,
          minimumSize: const Size(double.infinity, 50),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
        child: const Text('Add', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
      ),
    );
  }
}
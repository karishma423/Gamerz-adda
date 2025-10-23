// lib/screens/withdrawal_screen.dart (Final Code)

import 'package:flutter/material.dart';
// import '../services/api_service.dart'; // Agar API calls karni ho toh

const Color primaryRed = Color(0xFFE50045); 
const Color darkBackground = Color(0xFF1E1E1E);

// Models
class WithdrawalMethod {
  final String name;
  final IconData icon;
  final Color color;
  WithdrawalMethod({required this.name, required this.icon, required this.color});
}

class LinkedAccount {
  final String type;
  final String details;
  final IconData icon;
  LinkedAccount({required this.type, required this.details, required this.icon});
}

class WithdrawalScreen extends StatefulWidget {
  const WithdrawalScreen({super.key});

  @override
  State<WithdrawalScreen> createState() => _WithdrawalScreenState();
}

class _WithdrawalScreenState extends State<WithdrawalScreen> {
  // Dynamic Data
  final double currentWinningBalance = 0.91; 

  final List<WithdrawalMethod> withdrawalMethods = [
    WithdrawalMethod(name: 'BHIM UPI', icon: Icons.account_balance_wallet_outlined, color: Colors.green),
    WithdrawalMethod(name: 'Bank Transfer', icon: Icons.account_balance, color: Colors.orange),
    WithdrawalMethod(name: 'Google Play Gift Card', icon: Icons.card_giftcard, color: Colors.blue),
  ];
  
  final List<LinkedAccount> linkedAccounts = [
    LinkedAccount(type: 'UPI', details: '6266480143@upi', icon: Icons.account_balance_wallet_outlined),
    LinkedAccount(type: 'Bank A/C', details: '**** **** *123', icon: Icons.account_balance),
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // _showBankingPartnerAlert(context); // Alert box ka code yahan aayega
    });
  }

  // --- UI ---
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkBackground,
      appBar: AppBar( /* ... */ ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ... (Full UI structure, jismein upar ke dynamic data use honge)
            // ...
          ],
        ),
      ),
    );
  }
}
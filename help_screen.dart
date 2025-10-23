// lib/screens/help_screen.dart V2 (Dynamic Data)

import 'package:flutter/material.dart';

const Color primaryRed = Color(0xFFE50045); 
const Color darkBackground = Color(0xFF1E1E1E);

// --- Support Contact Model ---
class SupportContact {
  final String whatsappNumber;
  final String emailAddress;
  SupportContact({required this.whatsappNumber, required this.emailAddress});
}

class HelpScreen extends StatelessWidget {
  const HelpScreen({super.key});

  // Dynamic Contact Details
  final SupportContact contacts = const SupportContact(
    whatsappNumber: '+91 98765 43210',
    emailAddress: 'support@gamerzadda.com',
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkBackground,
      appBar: AppBar(
        backgroundColor: primaryRed,
        title: const Text('Help & Support', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        leading: const BackButton(color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'How can we help you?',
              style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 30),

            // WhatsApp Support (Dynamic Number)
            _buildSupportTile(
              icon: Icons.whatsapp,
              title: 'WhatsApp Support',
              details: contacts.whatsappNumber, // Dynamic Number
              color: const Color(0xFF25D366),
              onTap: () {},
            ),
            const SizedBox(height: 15),

            // Email Support (Dynamic Email)
            _buildSupportTile(
              icon: Icons.email,
              title: 'Email Support',
              details: contacts.emailAddress, // Dynamic Email
              color: Colors.blueAccent,
              onTap: () {},
            ),
            const SizedBox(height: 15),

            // FAQ
            _buildSupportTile(
              icon: Icons.question_answer,
              title: 'Frequently Asked Questions (FAQ)',
              details: 'Find quick answers to common queries.',
              color: Colors.amber,
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSupportTile({
    required IconData icon,
    required String title,
    required String details,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Container(
      decoration: BoxDecoration(color: const Color(0xFF2C2C2C), borderRadius: BorderRadius.circular(10)),
      child: ListTile(
        leading: Icon(icon, color: color, size: 30),
        title: Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        subtitle: Text(details, style: const TextStyle(color: Colors.white70)),
        trailing: const Icon(Icons.chevron_right, color: Colors.white70),
        onTap: onTap,
      ),
    );
  }
}
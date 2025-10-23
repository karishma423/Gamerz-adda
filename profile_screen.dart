// lib/screens/profile_screen.dart V2 (Dynamic Data)

import 'package:flutter/material.dart';

const Color primaryRed = Color(0xFFE50045); 
const Color darkBackground = Color(0xFF1E1E1E);

// --- User Profile Model ---
class UserProfile {
  final String username;
  final String email;
  final String mobile;
  final String gameId;
  UserProfile({required this.username, required this.email, required this.mobile, required this.gameId});
}

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});
  
  // Dynamic User Data
  final UserProfile userData = const UserProfile(
    username: 'Gamer_Aditya_77',
    email: 'aditya.kumar@example.com',
    mobile: '+91 98765 43210',
    gameId: 'FF_Player_12345',
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkBackground,
      appBar: AppBar(
        backgroundColor: primaryRed,
        title: const Text('My Profile', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        leading: const BackButton(color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const CircleAvatar(
              radius: 60,
              backgroundColor: primaryRed,
              child: Icon(Icons.person, size: 70, color: Colors.white),
            ),
            const SizedBox(height: 10),
            
            TextButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.edit, color: primaryRed),
              label: const Text('Edit Profile', style: TextStyle(color: primaryRed, fontWeight: FontWeight.bold)),
            ),
            const SizedBox(height: 30),

            _buildInfoCard(userData), // Dynamic Data Card
            const SizedBox(height: 30),

            _buildActionTile(Icons.vpn_key, 'Change Password', () {}),
            _buildActionTile(Icons.account_balance_wallet, 'KYC & Bank Details', () {}),
            _buildActionTile(Icons.info, 'About App', () {}),
            
            const SizedBox(height: 40),
            
            ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.logout, color: Colors.white),
              label: const Text('LOGOUT', style: TextStyle(color: Colors.white, fontSize: 16)),
              style: ElevatedButton.styleFrom(backgroundColor: primaryRed, minimumSize: const Size(double.infinity, 50)),
            ),
          ],
        ),
      ),
    );
  }

  // Helper Widgets (use userData)
  Widget _buildInfoCard(UserProfile data) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(color: const Color(0xFF2C2C2C), borderRadius: BorderRadius.circular(10)),
      child: Column(
        children: [
          _buildDetailRow(Icons.person, 'Username', data.username),
          _buildDetailRow(Icons.mail, 'Email ID', data.email),
          _buildDetailRow(Icons.phone, 'Mobile Number', data.mobile),
          _buildDetailRow(Icons.gamepad, 'Game ID', data.gameId),
        ],
      ),
    );
  }

  Widget _buildDetailRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(icon, color: primaryRed, size: 20),
          const SizedBox(width: 15),
          Expanded(child: Text(label, style: const TextStyle(color: Colors.white70))),
          Text(value, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }

  Widget _buildActionTile(IconData icon, String title, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: primaryRed),
      title: Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w500)),
      trailing: const Icon(Icons.chevron_right, color: Colors.white70),
      onTap: onTap,
      tileColor: const Color(0xFF2C2C2C),
      contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      visualDensity: VisualDensity.compact,
    );
  }
}
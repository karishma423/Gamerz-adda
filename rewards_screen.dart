// lib/screens/rewards_screen.dart V2

import 'package:flutter/material.dart';

const Color primaryRed = Color(0xFFE50045); 
const Color darkBackground = Color(0xFF1E1E1E);

class RewardsScreen extends StatelessWidget {
  const RewardsScreen({super.key});

  // Dynamic values
  final String totalRewardsEarned = '₹338.99'; 
  final String currentWalletBalance = '₹450.00';

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: darkBackground,
        body: Column(
          children: [
            // Top Red Header
            Container(
              color: primaryRed,
              padding: const EdgeInsets.only(top: 40, bottom: 20, left: 15, right: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ... Top Bar (Back, Noti, Wallet)
                  const SizedBox(height: 20),
                  Text(totalRewardsEarned, style: const TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold)), // Dynamic Rewards
                  const Text('Total Rewards Earned', style: TextStyle(color: Colors.white70, fontSize: 16)),
                  const SizedBox(height: 20),
                  // ... Sort By Button
                ],
              ),
            ),
            
            // Live/Expired Rewards Tabs
            const TabBar(
              indicatorColor: primaryRed, labelColor: primaryRed, unselectedLabelColor: Colors.white70,
              tabs: [Tab(text: 'Live rewards'), Tab(text: 'Expired rewards')],
            ),
            
            // Content Area (No Data Found)
            const Expanded(
              child: TabBarView(
                children: [
                  Center(child: Text('No Live Rewards found.', style: TextStyle(color: Colors.white54, fontSize: 18))),
                  Center(child: Text('No Expired Rewards found.', style: TextStyle(color: Colors.white54, fontSize: 18))),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  // ... Helper Widgets (Wallet Button, Sort Button)
}
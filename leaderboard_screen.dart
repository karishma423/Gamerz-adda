// lib/screens/leaderboard_screen.dart V2

import 'package:flutter/material.dart';

const Color primaryRed = Color(0xFFE50045); 
const Color darkBackground = Color(0xFF1E1E1E);
const Color accentGreen = Color(0xFF32CD32);

// Winner Model
class LeaderboardUser {
  final String name;
  final String winnings;
  final int rank;
  final String avatarUrl;
  LeaderboardUser({required this.name, required this.winnings, required this.rank, required this.avatarUrl});
}

class LeaderboardScreen extends StatelessWidget {
  const LeaderboardScreen({super.key});

  // Dynamic Data
  final List<LeaderboardUser> allWinners = const [
    // Top 3
    LeaderboardUser(name: 'Pratima Lakra', winnings: '146738', rank: 1, avatarUrl: 'assets/p1.png'),
    LeaderboardUser(name: 'Mala Pau', winnings: '133440', rank: 2, avatarUrl: 'assets/p2.png'),
    LeaderboardUser(name: 'Monika B', winnings: '119253', rank: 3, avatarUrl: 'assets/p3.png'),
    // Ranks 4+
    LeaderboardUser(name: 'Prince Kumar', winnings: '109564', rank: 4, avatarUrl: 'assets/p4.png'),
    LeaderboardUser(name: 'Durgesh Ghanshyam', winnings: '108031', rank: 5, avatarUrl: 'assets/p5.png'),
    // ...
  ];
  final List<String> gameFilters = const ['FREE FIRE', 'LUDO', 'FAN BATTLE'];

  @override
  Widget build(BuildContext context) {
    final topWinners = allWinners.where((u) => u.rank <= 3).toList();
    final remainingWinners = allWinners.where((u) => u.rank > 3).toList();
    
    // ... UI Code
    return Scaffold(
      backgroundColor: darkBackground,
      body: CustomScrollView(
        slivers: [
          // App Bar (Dynamic Title: Free Fire Leaderboard)
          // ...
          
          SliverList(
            delegate: SliverChildListDelegate([
              _buildTopWinnersSection(context, topWinners), // Dynamic Top Winners
              _buildGameFilterTabs(gameFilters), // Dynamic Filters
              ...remainingWinners.map((winner) => _buildRankTile(winner)).toList(), // Dynamic Rank List
            ]),
          ),
        ],
      ),
    );
  }

  // Helper functions use LeaderboardUser object
  Widget _buildTopWinnersSection(BuildContext context, List<LeaderboardUser> winners) {
    // ... UI code
    return Container();
  }
  Widget _buildTopWinnerPill(LeaderboardUser winner) {
    // ... UI code
    return Container();
  }
  Widget _buildGameFilterTabs(List<String> games) {
    // ... UI code
    return Container();
  }
  Widget _buildRankTile(LeaderboardUser winner) {
    // ... UI code
    return Container(
      // ...
      child: Row(
        children: [
          SizedBox(width: 30, child: Text('#${winner.rank}', style: const TextStyle(color: primaryRed, fontWeight: FontWeight.bold, fontSize: 18))),
          // ... Avatar
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(winner.name, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
                Text('Won:₹${winner.winnings}', style: const TextStyle(color: accentGreen, fontSize: 13)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
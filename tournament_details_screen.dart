// lib/screens/tournament_details_screen.dart V2

import 'package:flutter/material.dart';
import 'tournament_list_screen.dart'; // Tournament Model ke liye
import 'participants_screen.dart'; 
import 'join_form_screen.dart'; 

const Color primaryRed = Color(0xFFE50045); 
const Color darkBackground = Color(0xFF1E1E1E);
const Color accentGreen = Color(0xFF32CD32);

class TournamentDetailsScreen extends StatelessWidget {
  final Tournament tournament; // Naya Tournament Object
  final String gameName;

  const TournamentDetailsScreen({
    super.key,
    required this.tournament,
    required this.gameName,
  });

  @override
  Widget build(BuildContext context) {
    int tabLength = tournament.isJoined ? 3 : 2; // Joined toh My Leagues, warna Join tab
    
    // Tab ko JOIN par switch karne ka logic
    void switchToJoinTab() {
      DefaultTabController.of(context)?.animateTo(tournament.isJoined ? 2 : 1);
    }

    return DefaultTabController(
      length: 3, // Hum teen tabs ko hamesha rakhenge, aur JOIN ke liye bottom button
      child: Scaffold(
        backgroundColor: darkBackground,
        appBar: _buildAppBar(),
        
        body: Column(
          children: [
            _buildHeaderSection(),
            _buildTabBar(tournament.isJoined),

            Expanded(
              child: TabBarView(
                children: [
                  _buildDetailsTab(),
                  // User joined hai toh My Leagues, warna Participants ka dummy tab dikhega
                  tournament.isJoined ? _buildMyLeaguesTab() : ParticipantsScreen(gameName: gameName),
                  ParticipantsScreen(gameName: gameName), // Participants Tab
                ],
              ),
            ),
          ],
        ),
        bottomNavigationBar: _buildDynamicActionButton(context, switchToJoinTab),
      ),
    );
  }

  // --- Widgets ---
  
  // Header Section (Free Fire Image, Title, Date)
  Widget _buildHeaderSection() {
    // ... Home Screen ka code yahan aayega, jismein tournament.title aur tournament.startDate use honge
    return Container(); // Placeholder
  }

  // DETAILS Tab
  Widget _buildDetailsTab() {
    // Hardcoded prize distribution to dynamic data for this specific tournament
    final prizeDistribution = [
      {'Rank': '1-1', 'Prize': '100.0'},
      {'Rank': '2-2', 'Prize': '90.0'},
      // ...
    ];

    return SingleChildScrollView(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          // Stat Bar (Entry, Participant, Prize)
          _buildStatRow(tournament),
          
          // Kill Point, Mode, Bonus, Map
          _buildExtraInfoRow(tournament),

          // Prize Pool Breakdown Tabs
          _buildPrizePoolTabs(prizeDistribution), // Dynamic Prize
        ],
      ),
    );
  }
  
  // MY LEAGUES Tab
  Widget _buildMyLeaguesTab() {
    final myLeagues = [
      {'matchId': tournament.id, 'level': 'Lobby 1', 'slot': 'Slot 10'},
      // ...
    ];
    // ... Data Table logic
    return Container(); // Placeholder
  }

  // Dynamic Bottom Action Button
  Widget _buildDynamicActionButton(BuildContext context, VoidCallback switchToJoinTab) {
    String buttonText = 'VIEW / ACTION';
    Color buttonColor = primaryRed;
    VoidCallback? onPressed;
    IconData? icon;
    
    // Match Status Logic
    if (tournament.status == 'Upcoming' && !tournament.isJoined) {
      buttonText = 'JOIN NOW (₹${tournament.entryFee.toStringAsFixed(1)})';
      icon = Icons.group_add;
      buttonColor = accentGreen;
      onPressed = switchToJoinTab; // Tab ko join form par switch karega
    } else if (tournament.status == 'Live' && tournament.isJoined) {
      buttonText = 'VIEW ROOM ID & PASS';
      icon = Icons.vpn_key;
      buttonColor = primaryRed;
      onPressed = () => _showRoomDetailsDialog(context);
    } else if (tournament.status == 'Past') {
      buttonText = 'VIEW LEADERBOARD';
      icon = Icons.leaderboard;
      buttonColor = Colors.blueGrey;
      onPressed = () {};
    } else if (tournament.status == 'Upcoming' && tournament.isJoined) {
      // User joined hai aur match upcoming hai
      buttonText = 'JOINED (Waiting for Match)';
      icon = Icons.check_circle;
      buttonColor = Colors.blueGrey;
      onPressed = null; // Button disabled
    }

    // ... Button UI code
    return Container(); // Placeholder
  }

  // Helper Widgets (Jismein sirf tournament object use hoga)
  Widget _buildStatRow(Tournament t) { return Container(); }
  Widget _buildExtraInfoRow(Tournament t) { return Container(); }
  Widget _buildPrizePoolTabs(List<Map<String, String>> prizeDistribution) { return Container(); }
  void _showRoomDetailsDialog(BuildContext context) {}
}
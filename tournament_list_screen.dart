// lib/screens/tournament_list_screen.dart V2

import 'package:flutter/material.dart';
import '../components/tournament_card.dart';
import 'tournament_details_screen.dart';

const Color primaryRed = Color(0xFFE50045); 
const Color darkBackground = Color(0xFF1E1E1E);

// --- Tournament Model ---
class Tournament {
  final String id;
  final String title;
  final double entryFee;
  final double prizePool;
  final double killPoint;
  final String startDate;
  final int currentParticipants;
  final int maxParticipants;
  final String map;
  final String status; // 'Upcoming', 'Live', 'Past'
  final bool isJoined;

  Tournament({
    required this.id, required this.title, required this.entryFee, required this.prizePool, 
    required this.killPoint, required this.startDate, required this.currentParticipants, 
    required this.maxParticipants, required this.map, required this.status, this.isJoined = false,
  });
}

// Dummy Tournament Data (API se aane wala)
final List<Tournament> allTournaments = [
  Tournament(id: '1', title: '💥Maha Sangram Survival Battle( Vehicle + Air Drop NOT ALLOWED) #FF_61327', entryFee: 34.0, prizePool: 1225.0, killPoint: 0.0, startDate: '21 Aug 08:20 pm', currentParticipants: 48, maxParticipants: 48, map: 'Classic Bermuda', status: 'Upcoming', isJoined: true),
  Tournament(id: '2', title: 'Daily Grind Pro - Solo Match for BGMI Players', entryFee: 10.0, prizePool: 500.0, killPoint: 5.0, startDate: 'Today 04:00 pm', currentParticipants: 30, maxParticipants: 100, map: 'Erangel', status: 'Live'),
  Tournament(id: '3', title: 'Night Rush Squad Match (Completed)', entryFee: 50.0, prizePool: 2500.0, killPoint: 1.0, startDate: '18 Aug 10:00 pm', currentParticipants: 100, maxParticipants: 100, map: 'Pochinki', status: 'Past', isJoined: true),
];

class TournamentListScreen extends StatelessWidget {
  final String gameName; 
  final String gameImage;

  const TournamentListScreen({super.key, required this.gameName, required this.gameImage});

  @override
  Widget build(BuildContext context) {
    // Dummy filter logic: sirf woh tournaments jo is game se match karte hain
    final filteredTournaments = allTournaments; 

    final upcomingTournaments = filteredTournaments.where((t) => t.status == 'Upcoming' || t.status == 'Live').toList();
    final completedTournaments = filteredTournaments.where((t) => t.status == 'Past').toList();

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: darkBackground,
        appBar: AppBar(
          backgroundColor: darkBackground,
          title: Text('$gameName Tournaments', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)), // Dynamic Game Name
          bottom: const TabBar(
            indicatorColor: primaryRed,
            labelColor: primaryRed,
            unselectedLabelColor: Colors.white70,
            tabs: [Tab(text: 'Upcoming/Live'), Tab(text: 'Completed (Past)')],
          ),
        ),
        
        body: TabBarView(
          children: [
            _buildTournamentList(context, upcomingTournaments, gameImage),
            _buildTournamentList(context, completedTournaments, gameImage),
          ],
        ),
      ),
    );
  }

  Widget _buildTournamentList(BuildContext context, List<Tournament> tournaments, String image) {
    if (tournaments.isEmpty) {
      return const Center(child: Text("No tournaments found.", style: TextStyle(color: Colors.white70)));
    }
    
    return ListView.builder(
      padding: const EdgeInsets.only(top: 10, bottom: 20),
      itemCount: tournaments.length,
      itemBuilder: (context, index) {
        final t = tournaments[index];
        return TournamentCard(
          title: t.title,
          gameImage: image,
          entryFee: t.entryFee,
          prizePool: t.prizePool,
          killPoint: t.killPoint,
          startDate: t.startDate,
          currentParticipants: t.currentParticipants,
          maxParticipants: t.maxParticipants,
          map: t.map,
          status: t.status,
          onActionPressed: () {
            // Tournament Details Screen par navigate karo
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => TournamentDetailsScreen(
                  tournament: t, // Poora Tournament Object bhej rahe hain
                  gameName: gameName, // Game ka naam bhi bhej rahe hain
                ),
              ),
            );
          },
        );
      },
    );
  }
}
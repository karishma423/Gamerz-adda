// lib/screens/participants_screen.dart V2

import 'package:flutter/material.dart';

const Color primaryRed = Color(0xFFE50045); 
const Color darkBackground = Color(0xFF1E1E1E);

// Participant Model (API se aane wala)
class Participant {
  final String username;
  final String tag;
  final String avatarUrl;
  Participant({required this.username, required this.tag, required this.avatarUrl});
}

class ParticipantsScreen extends StatelessWidget {
  final String gameName;
  // Dynamic Participant List
  final List<Participant> participants = [
    Participant(username: 'Nitish Kumar Bind', tag: 'NITEESH | nk7754520', avatarUrl: 'assets/p1.png'),
    Participant(username: 'Yaksh Khandelwal', tag: 'yaksh | $\\triangle$LOADING!', avatarUrl: 'assets/p2.png'),
    // ...
  ];

  const ParticipantsScreen({super.key, required this.gameName});

  @override
  Widget build(BuildContext context) {
    // ... UI code
    return Scaffold(
      backgroundColor: darkBackground,
      body: Column(
        children: [
          // Top Banner
          Container(
            padding: const EdgeInsets.all(15), color: primaryRed,
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              const Icon(Icons.emoji_events, color: Colors.white), const SizedBox(width: 10),
              Text('Champions Adda', style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
            ]),
          ),
          // List View
          Expanded(
            child: ListView.builder(
              itemCount: participants.length,
              itemBuilder: (context, index) {
                return _buildParticipantTile(participants[index]); // Dynamic Participant
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildParticipantTile(Participant p) {
    return Container(
      // ... UI code
      child: Row(
        children: [
          CircleAvatar(radius: 25, backgroundImage: AssetImage(p.avatarUrl)),
          const SizedBox(width: 15),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(p.username, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
              Text(p.tag, style: const TextStyle(color: Colors.white70, fontSize: 13)),
            ],
          ),
        ],
      ),
    );
  }
}
// lib/components/tournament_card.dart

import 'package:flutter/material.dart';

// Global Colors (main.dart se define kiya gaya)
const Color primaryRed = Color(0xFFE50045); 
const Color darkBackground = Color(0xFF1E1E1E);

class TournamentCard extends StatelessWidget {
  // Card ko dynamic banane ke liye required data fields
  final String title;
  final String gameImage;
  final double entryFee;
  final double prizePool;
  final double killPoint;
  final String startDate;
  final int currentParticipants;
  final int maxParticipants;
  final String map;
  final VoidCallback onActionPressed;

  const TournamentCard({
    super.key,
    required this.title,
    required this.gameImage,
    required this.entryFee,
    required this.prizePool,
    required this.killPoint,
    required this.startDate,
    required this.currentParticipants,
    required this.maxParticipants,
    required this.map,
    required this.onActionPressed,
  });

  @override
  Widget build(BuildContext context) {
    // Card ka main structure
    return Card(
      color: const Color(0xFF2C2C2C), // Card ka dark background (image se matching)
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      child: Column(
        children: [
          // 1. Tournament Title Aur Image
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Game Image Placeholder
                ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Image.asset(
                    gameImage, // Example: 'assets/game_ff.jpg'
                    height: 40,
                    width: 40,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 10),
                // Title & Details
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      height: 1.4, // Line height for better readability
                    ),
                  ),
                ),
              ],
            ),
          ),

          // 2. Main Stats (Entry, Prize, Kill Point)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Row(
              children: [
                _buildStatItem(
                  icon: Icons.emoji_events, 
                  label: 'Entry', 
                  value: '₹${entryFee.toStringAsFixed(1)}',
                  valueColor: const Color(0xFF32CD32), // Green color for entry
                ),
                const SizedBox(width: 10),
                _buildStatItem(
                  icon: Icons.menu_book, 
                  label: 'Prizes', 
                  value: '₹${prizePool.toStringAsFixed(1)}',
                  valueColor: Colors.white,
                ),
                const SizedBox(width: 10),
                _buildStatItem(
                  icon: Icons.monetization_on, 
                  label: 'Kill Point', 
                  value: '₹${killPoint.toStringAsFixed(1)}/Kill',
                  valueColor: Colors.white,
                ),
              ],
            ),
          ),
          const SizedBox(height: 15),

          // 3. Progress Bar (Filled / Max)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  'Filled $currentParticipants/$maxParticipants',
                  style: const TextStyle(color: Colors.white70, fontSize: 12),
                ),
                const SizedBox(height: 5),
                LinearProgressIndicator(
                  value: currentParticipants / maxParticipants,
                  backgroundColor: const Color(0xFF3A3A3A),
                  valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF32CD32)), // Green progress bar
                  minHeight: 5,
                  borderRadius: BorderRadius.circular(5),
                ),
              ],
            ),
          ),
          const SizedBox(height: 15),

          // 4. Start Date, Total Participants, Map
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
            decoration: const BoxDecoration(
              border: Border(top: BorderSide(color: Color(0xFF3A3A3A), width: 1)),
            ),
            child: Row(
              children: [
                _buildDetailItem(
                  icon: Icons.schedule, 
                  label: 'Start Date', 
                  value: startDate
                ),
                _buildDetailItem(
                  icon: Icons.people, 
                  label: 'Total Participants', 
                  value: currentParticipants.toString()
                ),
                _buildDetailItem(
                  icon: Icons.map, 
                  label: 'Map', 
                  value: map
                ),
              ],
            ),
          ),
          
          // 5. Action Button (Bottom Red Area)
          Container(
            width: double.infinity,
            decoration: const BoxDecoration(
              color: primaryRed, // Bottom section pure red
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10),
              ),
            ),
            child: TextButton(
              onPressed: onActionPressed,
              style: TextButton.styleFrom(
                foregroundColor: Colors.white, // Text color
                padding: const EdgeInsets.symmetric(vertical: 12),
              ),
              child: const Text(
                'VIEW DETAILS / JOIN', // Ek hi button, jo detail page par le jaayega
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // --- Reusable Widget Functions ---

  // Stat Item (Entry, Prizes, Kill Point)
  Widget _buildStatItem({required IconData icon, required String label, required String value, required Color valueColor}) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: const Color(0xFF3A3A3A), // Stat box ka background
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: primaryRed, size: 16),
                const SizedBox(width: 5),
                Text(label, style: const TextStyle(color: Colors.white70, fontSize: 12)),
              ],
            ),
            const SizedBox(height: 5),
            Text(
              value,
              style: TextStyle(
                color: valueColor, 
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Detail Item (Date, Participants, Map)
  Widget _buildDetailItem({required IconData icon, required String label, required String value}) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: primaryRed, size: 16),
              const SizedBox(width: 4),
              Text(label, style: const TextStyle(color: Colors.white70, fontSize: 12)),
            ],
          ),
          const SizedBox(height: 2),
          Text(
            value,
            style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w600),
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
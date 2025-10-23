// lib/screens/join_form_screen.dart V2

import 'package:flutter/material.dart';
import 'tournament_list_screen.dart'; // Tournament Model ke liye

const Color primaryRed = Color(0xFFE50045); 
const Color darkBackground = Color(0xFF1E1E1E);

class JoinFormScreen extends StatelessWidget {
  final Tournament tournament; // Tournament Data

  const JoinFormScreen({super.key, required this.tournament});

  @override
  Widget build(BuildContext context) {
    // ... Form UI code
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ... Top Yellow Instructions
          const SizedBox(height: 20),

          // Input Fields (Data yahan se uthega)
          _buildInputField('Black^$\\,!NINJA', 'Username (Game Name)'),
          _buildInputField('1567224507', 'UserID (In-Game ID)'),
          _buildInputField('66', 'Game Level (Must be 25 or more than 25)'),
          const SizedBox(height: 20),

          // Map Download Radio Buttons
          Text('Have you downloaded ${tournament.map} map?', style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)), // Dynamic Map
          // ... Radio button aur note
          
          // ... Action Buttons
        ],
      ),
    );
  }
  
  // Helper Widgets (Same rahenge)
  Widget _buildInputField(String initialValue, String label) {
    // ...
  }
  Widget _buildRadioOption(String text, bool isSelected) {
    // ...
  }
  Widget _buildActionButton(String text, Color color) {
    // ...
  }
}
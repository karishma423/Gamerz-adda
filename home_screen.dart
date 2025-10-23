// lib/screens/home_screen.dart V4 (Categories Update)

// ... baaki imports aur constants same rahenge

// Dynamic Categories ko update kiya gaya
final List<String> gameCategories = [
  'FULL MAP', 
  'CLASH SQUAD', 
  'LONE WOLF', 
  'SURVIVAL', 
  'FREE MATCHES', 
  'WEEKLY SPECIAL',
]; 

// ...

class HomeScreen extends StatelessWidget {
  // ... constructor same
  
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: gameCategories.length, // Categories ki nayi length
      child: Scaffold(
        // ... baaki code same
        
        body: Column(
          children: <Widget>[
            _buildNotificationBanner(dummyNotification),
            _buildTabBar(), // Yeh naye categories ko dikhayega
            Expanded(
              child: TabBarView(
                children: gameCategories.map((category) {
                  // Ab har category ke liye aap alag list of games dikha sakte hain
                  if (category == 'FULL MAP' || category == 'SURVIVAL') {
                    return GamesGrid(games: dummyGames); // GamesGrid ka data filter karke bhejna hoga
                  }
                  return Center(child: Text('$category Matches Loading...', style: const TextStyle(color: Colors.white70)));
                }).toList(),
              ),
            ),
          ],
        ),
        // ... bottomNavBar same
      ),
    );
  }
  
  // _buildTabBar function: isme isScrollable: true hai, jo zaruri hai.
}
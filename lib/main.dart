import 'package:flutter/material.dart';

void main() {
  runApp(const NeoSceneApp());
}

class NeoSceneApp extends StatelessWidget {
  const NeoSceneApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NeoScene',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: const Color(0xFF00E5FF), // Neon Cyan
        scaffoldBackgroundColor: const Color(0xFF0A0E21), // Deep Navy Blue
        fontFamily: 'sans-serif',
      ),
      home: const MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const ReelsFeed(),
    const SearchScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        backgroundColor: const Color(0xFF0A0E21), // Deep Navy Blue
        selectedItemColor: const Color(0xFF00E5FF), // Neon Cyan
        unselectedItemColor: Colors.white38,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

// ---------- Reels Feed Screen ----------

class ReelsFeed extends StatefulWidget {
  const ReelsFeed({super.key});

  @override
  State<ReelsFeed> createState() => _ReelsFeedState();
}

class _ReelsFeedState extends State<ReelsFeed> {
  final PageController _pageController = PageController();
  final List<DramaClip> _clips = [
    DramaClip(
      title: 'The Last Scene',
      description: 'A director finds a mysterious script...',
      likes: 1243,
      thumbnailColor: const Color(0xFF1A237E), // Dark Blue
      icon: '🎬',
    ),
    DramaClip(
      title: 'Echoes of Love',
      description: 'Two strangers meet in a crowded market',
      likes: 2987,
      thumbnailColor: const Color(0xFF4A148C), // Dark Purple
      icon: '💔',
    ),
    DramaClip(
      title: 'Midnight Heist',
      description: 'One hour to steal the impossible',
      likes: 5432,
      thumbnailColor: const Color(0xFFB71C1C), // Dark Red
      icon: '💰',
    ),
    DramaClip(
      title: 'The AI Assistant',
      description: 'She discovers her AI is alive',
      likes: 8765,
      thumbnailColor: const Color(0xFF004D40), // Dark Teal
      icon: '🤖',
    ),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        controller: _pageController,
        scrollDirection: Axis.vertical,
        itemCount: _clips.length,
        itemBuilder: (context, index) {
          final clip = _clips[index];
          return _buildClipPage(clip);
        },
      ),
    );
  }

  Widget _buildClipPage(DramaClip clip) {
    return Stack(
      children: [
        // Placeholder background color for video
        Container(
          color: clip.thumbnailColor,
          child: Center(
            child: Text(
              clip.icon,
              style: const TextStyle(fontSize: 80, color: Colors.white24),
            ),
          ),
        ),
        // Gradient overlay for text readability
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.transparent,
                  Colors.black.withOpacity(0.8),
                ],
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  clip.title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  clip.description,
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.7),
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    const Icon(Icons.favorite, color: Color(0xFF00E5FF), size: 22),
                    const SizedBox(width: 6),
                    Text(
                      '${clip.likes}',
                      style: const TextStyle(color: Colors.white70, fontSize: 14),
                    ),
                    const Spacer(),
                    const Icon(Icons.chat_bubble_outline, color: Colors.white70, size: 22),
                    const SizedBox(width: 6),
                    const Text('Comment', style: TextStyle(color: Colors.white70, fontSize: 14)),
                  ],
                ),
              ],
            ),
          ),
        ),
        // Top bar with app name
        Positioned(
          top: 40,
          left: 20,
          child: Row(
            children: [
              const Icon(Icons.ondemand_video, color: Color(0xFF00E5FF), size: 28),
              const SizedBox(width: 8),
              const Text(
                'NeoScene',
                style: TextStyle(
                  color: Color(0xFF00E5FF),
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// ---------- Search Screen ----------

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.search, color: Colors.white54, size: 60),
            SizedBox(height: 20),
            Text(
              'Find Your Next Drama',
              style: TextStyle(color: Colors.white70, fontSize: 22, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10),
            Text(
              'Explore trending shorts, discover new genres, and search for your favorite stories.',
              style: TextStyle(color: Colors.white54, fontSize: 16),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

// ---------- Profile Screen ----------

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 50), // Spacing from top
          // Profile Picture (Placeholder)
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: const Color(0xFF00E5FF).withOpacity(0.5),
              border: Border.all(color: const Color(0xFF00E5FF), width: 3),
            ),
            child: const Center(
              child: Icon(Icons.person, size: 50, color: Colors.white),
            ),
          ),
          const SizedBox(height: 15),
          const Text(
            'User Name', // Placeholder
            style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 5),
          const Text(
            'NeoScene Creator', // Placeholder
            style: TextStyle(color: Colors.white54, fontSize: 16),
          ),
          const SizedBox(height: 30),
          // Stats Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildStatColumn('Dramas', '15'), // Placeholder
              _buildStatColumn('Following', '120'), // Placeholder
              _buildStatColumn('Followers', '3.5K'), // Placeholder
            ],
          ),
          const SizedBox(height: 40),
          // Uploaded Dramas Section (Placeholder)
          const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'My Dramas',
              style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 15),
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 10.0,
                mainAxisSpacing: 10.0,
              ),
              itemCount: 6, // Placeholder for drama thumbnails
              itemBuilder: (context, index) {
                return Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFF1A237E).withOpacity(0.6), // Dark blue placeholder
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: Text(
                      'Drama ${index + 1}',
                      style: const TextStyle(color: Colors.white54),
                    ),
                  ),
                );
              },
            ),
          ),
          // Settings Button (optional, can be added here or as an icon)
          ElevatedButton.icon(
            icon: const Icon(Icons.settings),
            label: const Text('Settings'),
            onPressed: () {
              // TODO: Navigate to settings screen
              print('Settings pressed');
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF00E5FF).withOpacity(0.2),
              foregroundColor: const Color(0xFF00E5FF),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatColumn(String label, String value) {
    return Column(
      children: [
        Text(value, style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(color: Colors.white54, fontSize: 14)),
      ],
    );
  }
}

// ---------- Data Model ----------

class DramaClip {
  final String title;
  final String description;
  final int likes;
  final Color thumbnailColor;
  final String icon;

  DramaClip({
    required this.title,
    required this.description,
    required this.likes,
    required this.thumbnailColor,
    required this.icon,
  });
}

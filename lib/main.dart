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
        primaryColor: const Color(0xFF00E5FF),
        scaffoldBackgroundColor: const Color(0xFF0A0E21),
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
        backgroundColor: const Color(0xFF0A0E21),
        selectedItemColor: const Color(0xFF00E5FF),
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

// ---------- Reels Feed (from previous step) ----------

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
      thumbnailColor: const Color(0xFF1A237E),
      icon: '🎬',
    ),
    DramaClip(
      title: 'Echoes of Love',
      description: 'Two strangers meet in a crowded market',
      likes: 2987,
      thumbnailColor: const Color(0xFF4A148C),
      icon: '💔',
    ),
    DramaClip(
      title: 'Midnight Heist',
      description: 'One hour to steal the impossible',
      likes: 5432,
      thumbnailColor: const Color(0xFFB71C1C),
      icon: '💰',
    ),
    DramaClip(
      title: 'The AI Assistant',
      description: 'She discovers her AI is alive',
      likes: 8765,
      thumbnailColor: const Color(0xFF004D40),
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
        Container(color: clip.thumbnailColor, child: Center(child: Text(clip.icon, style: const TextStyle(fontSize: 80)))),
        Positioned(
          bottom: 0, left: 0, right: 0,
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter, end: Alignment.bottomCenter,
                colors: [Colors.transparent, Colors.black.withOpacity(0.8)],
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(clip.title, style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                Text(clip.description, style: TextStyle(color: Colors.white.withOpacity(0.7), fontSize: 14)),
                const SizedBox(height: 20),
                Row(
                  children: [
                    const Icon(Icons.favorite, color: Color(0xFF00E5FF), size: 22),
                    const SizedBox(width: 6),
                    Text('${clip.likes}', style: const TextStyle(color: Colors.white70, fontSize: 14)),
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
        Positioned(
          top: 40, left: 20,
          child: Row(
            children: [
              const Icon(Icons.ondemand_video, color: Color(0xFF00E5FF), size: 28),
              const SizedBox(width: 8),
              const Text('NeoScene', style: TextStyle(color: Color(0xFF00E5FF), fontSize: 22, fontWeight: FontWeight.bold)),
            ],
          ),
        ),
      ],
    );
  }
}

// ---------- Placeholder Screens ----------

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('🔍 Search', style: TextStyle(color: Colors.white70, fontSize: 24)));
  }
}

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('👤 Profile', style: TextStyle(color: Colors.white70, fontSize: 24)));
  }
}

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

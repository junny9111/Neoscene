import 'package:flutter/material.dart';

class ReelsFeed extends StatefulWidget {
  const ReelsFeed({super.key});

  @override
  State<ReelsFeed> createState() => _ReelsFeedState();
}

class _ReelsFeedState extends State<ReelsFeed> {
  final PageController _pageController = PageController();

  // Dummy video data (replace with Supabase fetch later)
  final List<Map<String, String>> _videos = List.generate(
    10,
    (index) => {
      'title': 'Drama Clip #${index + 1}',
      'description': 'A short dramatic scene...',
      'likes': '${(index + 1) * 100}',
    },
  );

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0E21),
      body: PageView.builder(
        controller: _pageController,
        scrollDirection: Axis.vertical,
        itemCount: _videos.length,
        itemBuilder: (context, index) {
          final video = _videos[index];
          return Stack(
            children: [
              // Placeholder for video player – replace with VideoPlayer widget later
              Container(
                color: Colors.primaries[index % Colors.primaries.length]
                    .withOpacity(0.5),
                child: const Center(
                  child: Icon(Icons.play_circle_outline,
                      size: 80, color: Colors.white54),
                ),
              ),
              // Bottom overlay with title, description, likes
              Positioned(
                bottom: 80,
                left: 16,
                right: 16,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      video['title']!,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      video['description']!,
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        const Icon(Icons.favorite,
                            color: Color(0xFF00E5FF), size: 20),
                        const SizedBox(width: 6),
                        Text(
                          video['likes']!,
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              // Profile / action buttons on right side (optional)
              Positioned(
                right: 12,
                bottom: 120,
                child: Column(
                  children: [
                    _actionButton(Icons.favorite, () {}),
                    const SizedBox(height: 16),
                    _actionButton(Icons.comment, () {}),
                    const SizedBox(height: 16),
                    _actionButton(Icons.share, () {}),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _actionButton(IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.3),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: Colors.white, size: 28),
      ),
    );
  }
}

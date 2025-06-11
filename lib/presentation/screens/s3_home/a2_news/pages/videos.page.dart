import 'package:flutter/material.dart';
import '../component/video.card.dart';

class VideoPage extends StatelessWidget {
  const VideoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: 5, // Number of video cards to display
        itemBuilder: (context, index) {
          return VideoCard(
            username: 'User ${index + 1}',
            videoTitle: 'Amazing Video #${index + 1}',
            views: (index + 1) * 1000,
            likes: (index + 1) * 100,
            comments: (index + 1) * 50,
          );
        },
      ),
    );
  }
}

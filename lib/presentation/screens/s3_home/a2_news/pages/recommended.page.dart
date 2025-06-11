import 'package:flutter/material.dart';
import 'dart:async'; // For Timer
import '../component/news.card.dart';

class News {
  final String title;
  final String description;
  final String imageUrl;
  final String date;

  const News({
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.date,
  });
}

// Define newsList as a top-level constant
const List<News> newsList = [
  News(
    title: 'Flutter 3.0 Released',
    description: 'Google announces the latest version of Flutter with new features and improvements.',
    imageUrl: 'https://picsum.photos/id/3/500/300',
    date: 'May 12, 2023',
  ),
  News(
    title: 'Dart 3.0 Brings Major Updates',
    description: 'The new version of Dart introduces pattern matching and other powerful features.',
    imageUrl: 'https://picsum.photos/id/3/500/300',
    date: 'May 10, 2023',
  ),
  News(
    title: 'Material You Comes to Flutter',
    description: 'Flutter now supports dynamic theming with Material You design principles.',
    imageUrl: 'https://picsum.photos/id/3/500/300',
    date: 'May 8, 2023',
  ),
  News(
    title: 'Material You Comes to Flutter',
    description: 'Flutter now supports dynamic theming with Material You design principles.',
    imageUrl: 'https://picsum.photos/id/3/500/300',
    date: 'May 8, 2023',
  ),
  News(
    title: 'Material You Comes to Flutter',
    description: 'Flutter now supports dynamic theming with Material You design principles.',
    imageUrl: 'https://picsum.photos/id/3/500/300',
    date: 'May 8, 2023',
  ),
];

class RecommendedPage extends StatefulWidget {
  const RecommendedPage({Key? key}) : super(key: key);

  @override
  State<RecommendedPage> createState() => _RecommendedPageState();
}

class _RecommendedPageState extends State<RecommendedPage> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    // Auto-scroll every 3 seconds
    _timer = Timer.periodic(const Duration(seconds: 3), (Timer timer) {
      if (_currentPage < newsList.length - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      _pageController.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeIn,
      );
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(
    BuildContext context,
    ) {
    return Column(
      children: [
        // Billboard/Slider Section
        SizedBox(
          height: 200,
          width: 350,
          child: PageView.builder(
            controller: _pageController,
            onPageChanged: (int page) {
              setState(() {
                _currentPage = page;
              });
            },
            itemCount: newsList.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Image.network(
                        newsList[index].imageUrl,
                        fit: BoxFit.cover,
                        width: double.infinity,
                      ),
                      // Semi-transparent black overlay bar at bottom
                      Positioned(
                        left: 0,
                        right: 0,
                        bottom: 0,
                        height: 25, // height of the overlay bar
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.5), // 50% opacity black
                            borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(12),
                              bottomRight: Radius.circular(12),
                            ),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              // BTC logo (use a placeholder circle with text or replace with actual image)
                              Container(
                                width: 20,
                                height: 20,
                                decoration: BoxDecoration(
                                  color: Colors.orange,
                                  shape: BoxShape.circle,
                                ),
                                alignment: Alignment.center,
                                child: const Text(
                                  '₿',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                              // BTC name
                              const Text(
                                'BTC',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                              const SizedBox(width: 12),
                              // Percentage drop with red color and down arrow icon
                              Row(
                                children: const [
                                  Icon(
                                    Icons.arrow_downward,
                                    color: Colors.red,
                                    size: 18,
                                  ),
                                  SizedBox(width: 4),
                                  Text(
                                    '-2.23%',
                                    style: TextStyle(
                                      color: Colors.red,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                              const Spacer(),
                              // Menu icon (three dots vertical)
                              // const Icon(
                              //   Icons.more_vert,
                              //   color: Colors.white,
                              // ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),

        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.all(16.0),
            itemCount: newsList.length,
            itemBuilder: (context, index) {
              final news = newsList[index];
              return Column(
                children: [
                  NewsCard(
                    title: news.title,
                    description: news.description,
                    imageUrl: news.imageUrl,
                    date: news.date,
                  ),
                  const SizedBox(height: 16),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}
import 'package:flutter/material.dart';
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


const List<News> newsList = [
  News(
    title: 'Flutter 3.0 Released',
    description: 'Google announces the latest version of Flutter with new features and improvements.',
    imageUrl: 'https://picsum.photos/id/1/500/300',
    date: 'May 12, 2023',
  ),
  News(
    title: 'Dart 3.0 Brings Major Updates',
    description: 'The new version of Dart introduces pattern matching and other powerful features.',
    imageUrl: 'https://picsum.photos/id/2/500/300',
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

class AllNewsPage extends StatelessWidget {
  const AllNewsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // News List
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

import 'package:flutter/material.dart';
import './pages/all.news.page.dart';
import './pages/recommended.page.dart';
import './pages/videos.page.dart';

// News model class
class News {
  final String title;
  final String description;
  final String imageUrl;
  final String date;

  News({
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.date,
  });
}

// Main News Page (Parent)
class NewsPage extends StatefulWidget {
  const NewsPage({super.key});

  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  final PageController _pageController = PageController();
  int _selectedTab = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Added white background to scaffold
      appBar: AppBar(
        backgroundColor: Colors.white, // White app bar background
        foregroundColor: Colors.black, // Black icons and text
        elevation: 0, // Remove shadow
        automaticallyImplyLeading: false,
        title: const Text(
          'News',
          style: TextStyle(
            fontWeight: FontWeight.w600, // Semi-bold
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {},
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            child: CircleAvatar(
              backgroundImage: NetworkImage(
                  'https://randomuser.me/api/portraits/men/1.jpg'),
            ),
          ),
        ],
      ),
      body: Container(
        color: Colors.white, // Ensure body has white background
        child: Column(
          children: [
            // Tab Switch
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                // border: Border(
                //   bottom: BorderSide(
                //     color: Colors.grey[300]!,
                //     width: 1.0,
                //   ),
                // ),
              ),
              padding: const EdgeInsets.only(bottom: 15, top: 15), 
              child: Row(
                children: [
                  _buildTabButton(0, 'Recommended'),
                  _buildTabButton(1, 'All News'),
                  _buildTabButton(2, 'Videos'),
                ],
              ),
            ),
            // Page View for the content
            Expanded(
              child: Container(
                color: Colors.white, // White background for page view
                child: PageView(
                  controller: _pageController,
                  onPageChanged: (index) {
                    setState(() {
                      _selectedTab = index;
                    });
                  },
                  children: const [
                    RecommendedPage(),
                    AllNewsPage(),
                    VideoPage(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabButton(int index, String text) {
    final isSelected = _selectedTab == index;

    return Expanded(
      child: InkWell(
        onTap: () {
          setState(() {
            _selectedTab = index;
          });
          _pageController.animateToPage(
            index,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          );
        },
        child: Container(
          color: isSelected ? Colors.grey[200] : Colors.transparent,
          // Remove vertical padding here or reduce it
          // padding: const EdgeInsets.symmetric(vertical: 16.0), // <-- remove or adjust
          height: 48, // fixed height for consistent layout
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween, // push border to bottom
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 12), // padding only on top
                child: Text(
                  text,
                  style: TextStyle(
                    color: isSelected ? Colors.black : Colors.grey[600],
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
              ),
              Container(
                height: 2,
                width: MediaQuery.of(context).size.width / 3 * 0.8,
                decoration: BoxDecoration(
                  color: isSelected ? Colors.blue : Colors.transparent,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }


}

// Recommended Page
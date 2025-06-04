import 'package:coinxplorer/core/constants/colors.dart';
import 'package:flutter/material.dart';

// Pages
import 'a1_market/market_page.dart';
import 'a2_news/news_page.dart';
import 'a3_search/search_page.dart';
import 'a4_portfolio/portfolio_page.dart';
import 'a5_community/community_page.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  final List<Widget> _pages = const [
    MarketPage(),
    NewsPage(),
    SearchPage(),
    PortfolioPage(),
    CommunityPage(),
  ];

  void _onItemTapped(int index) {
    setState(() => _selectedIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      body: SafeArea(child: _pages[_selectedIndex]),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.07),
              blurRadius: 12,
              offset: const Offset(0, -3),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(0),
            topRight: Radius.circular(0),
          ),
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            currentIndex: _selectedIndex,
            onTap: _onItemTapped,
            selectedItemColor: AppColors.textDark,
            unselectedItemColor: AppColors.textSecondary,
            backgroundColor: Colors.white,
            elevation: 0,
            showUnselectedLabels: true,
            selectedLabelStyle: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 12,
            ),
            unselectedLabelStyle: const TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 12,
            ),
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.show_chart),
                label: 'Market',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.article_outlined),
                label: 'News',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.search),
                label: 'Search',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.pie_chart_outline),
                label: 'Portfolio',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.chat_bubble_outline),
                label: 'Community',
              ),
            ],
          ),
        ),
      ),
    );
  }
}



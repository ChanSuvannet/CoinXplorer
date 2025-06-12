import 'package:coinxplorer/core/constants/colors.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  Widget buildSearchBar() {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16.0),
    child: Container(
      decoration: BoxDecoration(
        color: AppColors.backgroundLight,
        borderRadius: BorderRadius.circular(24.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1), // soft shadow
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
        border: Border.all(
          color: Colors.grey.shade200, // darker border
          width: 1.2,
        ),
      ),
      child: TextField(
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.search, color: Colors.grey),
          hintText: 'Search coins or exchanges...',
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(vertical: 14),
        ),
      ),
    ),
  );
}

 Widget buildRecentSearches() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Text("Recent Searches", style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold, color: Colors.grey)),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            children: [
              _searchChipWithImage("TRON", 'assets/images/tron.png'),
              const SizedBox(width: 8),
              _searchChipWithImage("SOL", 'assets/images/sol.png'),
            ],
          ),
        ),
      ],
   );
 }

  static Widget _searchChipWithImage(String name, String imageUrl) {
    return Chip(
      backgroundColor: Colors.white,
      avatar: CircleAvatar(
        backgroundColor: Colors.transparent,
        backgroundImage: AssetImage(imageUrl),
      ),
      label: Text(name),
    );
 }

  Widget buildTabs(BuildContext context, int selectedIndex, void Function(int) onTabSelected) {
  final tabs = ["Trending", "Most Visited", "Upcoming", "Recently"];

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Text(
          "Popular Coins",
          style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold, color: Colors.grey),
        ),
      ),
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4),
        padding: const EdgeInsets.all(4.0),
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(24.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List.generate(tabs.length, (index) {
            return Expanded(
              child: GestureDetector(
                onTap: () => onTabSelected(index),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                    color: selectedIndex == index ? Colors.white : Colors.transparent,
                    borderRadius: BorderRadius.circular(24.0),
                  ),
                  child: Center(
                    child: Text(
                      tabs[index],
                      style: TextStyle(
                        fontSize: 14,
                        color: selectedIndex == index ? Colors.black : Colors.grey,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    ],
  );
}


  Widget buildCoinRow({
  required String symbol,
  required String name,
  required String imageUrl, // <- NEW
  required Color color,
  required String price,
  required String marketCap,
  required double changePercent,
}) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
    decoration: const BoxDecoration(
      // border: Border(bottom: BorderSide(color: Colors.grey, width: 0.2)),
    ),
    child: Row(
      children: [
        CircleAvatar(
          backgroundColor: Colors.transparent,
          backgroundImage: NetworkImage(imageUrl),
          radius: 16,
          onBackgroundImageError: (_, __) => const Icon(Icons.error),
        ),
        const SizedBox(width: 12),
        Expanded(
          flex: 3,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(symbol, style: const TextStyle(fontWeight: FontWeight.bold)),
              Text(marketCap, style: const TextStyle(fontSize: 12, color: Colors.grey)),
            ],
          ),
        ),
        Expanded(flex: 2, child: Text(price, textAlign: TextAlign.right)),
        Expanded(
          flex: 2,
          child: Text(
            '${changePercent > 0 ? '+' : ''}${changePercent.toStringAsFixed(2)}%',
            textAlign: TextAlign.right,
            style: TextStyle(color: changePercent >= 0 ? Colors.green : Colors.red),
          ),
        ),
      ],
    ),
  );
}


  @override
  Widget build(BuildContext context) {
    int selectedIndex = 0;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: StatefulBuilder(
          builder: (context, setState) => SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 16),
                buildSearchBar(),
                const SizedBox(height: 16),
                buildRecentSearches(),
                buildTabs(context, selectedIndex, (i) => setState(() => selectedIndex = i)),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  child: Row(
                    children: [
                       Expanded(
                          flex: 1,
                          child: Padding(
                            padding: EdgeInsets.only(left: 18.0), // Adjusted padding for better alignment
                            child: Text("Coin", textAlign: TextAlign.left, style: TextStyle(color: Colors.grey, fontSize: 13)),
                          ),
                        ),
                      Expanded(flex: 4, child: Text("Price", textAlign: TextAlign.right, style: TextStyle(color: Colors.grey, fontSize: 13))),
                      Expanded(flex: 2, child: Text("24h%", textAlign: TextAlign.right, style: TextStyle(color: Colors.grey, fontSize: 13))),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(color: Colors.grey.withOpacity(0.1), blurRadius: 6, offset: const Offset(0, 2))
                    ],
                  ),
                  child: Column(
                    children: [
                      buildCoinRow(
                        symbol: "BTC",
                        name: "Bitcoin",
                        imageUrl: 'assets/images/btc1.png', // example URL
                        color: Colors.orange,
                        price: "\$40,000.58",
                        marketCap: "\$785.48B",
                        changePercent: 5.78,
                      ),
                      buildCoinRow(
                        symbol: "ETH",
                        name: "Ethereum",
                        imageUrl: 'assets/images/eth.png',
                        color: Colors.grey.shade700,
                        price: "\$2,845.67",
                        marketCap: "\$785.48B",
                        changePercent: -5.78,
                      ),
                      buildCoinRow(
                        symbol: "ADA",
                        name: "Cardano",
                        imageUrl: 'assets/images/ada.png',
                        color: Colors.blue,
                        price: "\$845.56",
                        marketCap: "\$785.48B",
                        changePercent: 5.78,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

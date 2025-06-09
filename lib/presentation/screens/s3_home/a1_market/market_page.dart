import 'package:coinxplorer/core/constants/colors.dart';
import 'package:coinxplorer/data/models/coin_model.dart';
import 'package:coinxplorer/data/services/coin_service.dart';
import 'package:coinxplorer/presentation/widgets/coin/coin_list_tab.dart';
import 'package:coinxplorer/presentation/widgets/coin/summary_card.dart';
import 'package:coinxplorer/presentation/widgets/shared/shared_appbar.dart';
import 'package:flutter/material.dart';

class MarketPage extends StatefulWidget {
  const MarketPage({super.key});

  @override
  State<MarketPage> createState() => _MarketPageState();
}

class _MarketPageState extends State<MarketPage> with TickerProviderStateMixin {
  late TabController _tabController;
  List<Coin> coins = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
    fetchCoinData();
  }

  Future<void> fetchCoinData() async {
    try {
      final fetchedCoins = await CoinService.fetchCoins();
      setState(() {
        coins = fetchedCoins;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      debugPrint('Error fetching coins: $e');
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SharedAppBar(title: 'Market', showBackButton: false),
      body: SafeArea(
        child: Container(
          color: AppColors.backgroundLight,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SummaryCard(),

              Padding(
                padding: const EdgeInsets.only(left: 0.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: TabBar(
                    controller: _tabController,
                    isScrollable: true,
                    labelColor: Colors.black,
                    unselectedLabelColor: Colors.grey,
                    indicatorColor: AppColors.textDark,
                    labelStyle: const TextStyle(fontWeight: FontWeight.bold),
                    tabs: const [
                      Tab(text: 'Coins'),
                      Tab(text: 'WatchList'),
                      Tab(text: 'Dexscan'),
                      Tab(text: 'Earn'),
                      Tab(text: 'Chains'),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 10),

              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    isLoading
                        ? const Center(child: CircularProgressIndicator())
                        : CoinListTab(coins: coins),
                    const Center(child: Text('WatchList Tab Coming Soon')),
                    const Center(child: Text('Dexscan Tab Coming Soon')),
                    const Center(child: Text('Earn Tab Coming Soon')),
                    const Center(child: Text('Chains Tab Coming Soon')),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

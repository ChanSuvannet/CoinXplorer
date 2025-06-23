import 'package:flutter/material.dart';
import 'package:coinxplorer/core/constants/colors.dart';

class DexscanTab extends StatefulWidget {
  const DexscanTab({super.key});

  @override
  State<DexscanTab> createState() => _DexscanTabState();
}

class _DexscanTabState extends State<DexscanTab> {
  String selectedFilter = 'Trending';
  
  // Sample data - replace with your actual data source
  final List<TradingPair> tradingPairs = [
    TradingPair(
      name: 'Simpson',
      symbol: 'WBNB',
      volume: 38.45,
      volumeUnit: 'K',
      price: 10.22,
      priceUnit: 'K',
      change24h: 5.78,
      liquidity: 0.013565,
    ),
    TradingPair(
      name: 'UNCN',
      symbol: 'USDT',
      volume: 10.26,
      volumeUnit: 'K',
      price: 1.62,
      priceUnit: 'M',
      change24h: 5.78,
      liquidity: 0.4967,
    ),
    TradingPair(
      name: 'BABYBNB',
      symbol: 'WBNB',
      volume: 19.23,
      volumeUnit: 'K',
      price: 120.91,
      priceUnit: 'K',
      change24h: 5.78,
      liquidity: 0.00142,
    ),
    TradingPair(
      name: 'REALIS',
      symbol: 'SOL',
      volume: 87.29,
      volumeUnit: 'K',
      price: 398.82,
      priceUnit: 'K',
      change24h: 5.78,
      liquidity: 0.002809,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.backgroundLight,
      child: Column(
        children: [
          // Filter tabs
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: [
                _buildFilterChip('Trending', true),
                const SizedBox(width: 8),
                _buildFilterChip('New', false),
                const SizedBox(width: 8),
                _buildFilterChip('Gainer', false),
                const SizedBox(width: 8),
                _buildFilterChip('24h %', false),
                const Spacer(),
                Icon(
                  Icons.tune,
                  color: Colors.grey[600],
                  size: 20,
                ),
              ],
            ),
          ),
          
          // Header row
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Row(
              children: [
                const Expanded(
                  flex: 4,
                  child: Text(
                    'Pairs',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 11,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const Expanded(
                  flex: 2,
                  child: Text(
                    'Vol/Txns',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 11,
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const Expanded(
                  flex: 2,
                  child: Text(
                    'Liq/MCap',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 11,
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const Expanded(
                  flex: 2,
                  child: Text(
                    '24h%/Price',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 11,
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
          
          // Trading pairs list
          Expanded(
            child: ListView.builder(
              itemCount: tradingPairs.length,
              itemBuilder: (context, index) {
                return _buildTradingPairItem(tradingPairs[index], index);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String label, bool isSelected) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: isSelected ? Colors.black : Colors.transparent,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: isSelected ? Colors.white : Colors.grey[600],
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildTradingPairItem(TradingPair pair, int index) {
    // Static values to match the image
    final List<Map<String, String>> staticVolLiq = [
      {'vol': '\$38.45 K', 'txns': '800', 'liq': '\$10.22 K', 'mcap': '\$0.013565'},
      {'vol': '\$10.26 K', 'txns': '150', 'liq': '\$1.62 M', 'mcap': '\$0.4967'},
      {'vol': '\$19.23 K', 'txns': '150', 'liq': '\$120.91 K', 'mcap': '\$0.001142'},
      {'vol': '\$87.29 K', 'txns': '492', 'liq': '\$398.82 K', 'mcap': '\$0.002809'},
    ];
    
    final currentData = index < staticVolLiq.length ? staticVolLiq[index] : staticVolLiq[0];
    
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Row(
        children: [
          // Pair info
          Expanded(
            flex: 4,
            child: Row(
              children: [
                // Token icon with local asset image
                Container(
                  width: 28,
                  height: 28,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                    color: Colors.grey[300],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(14),
                    child: Image.asset(
                      _getTokenAssetPath(pair.name),
                      width: 28,
                      height: 28,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          width: 28,
                          height: 28,
                          decoration: BoxDecoration(
                            color: _getTokenColor(pair.name),
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: Center(
                            child: Text(
                              pair.name.substring(0, 1).toUpperCase(),
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                const SizedBox(width: 6),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${pair.name}/${pair.symbol}',
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        '5m • 3 • 1h ago',
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 9,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          
          // Volume/Transactions
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  currentData['vol']!,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 11,
                  ),
                ),
                Text(
                  currentData['txns']!,
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 9,
                  ),
                ),
              ],
            ),
          ),
          
          // Liquidity/Market Cap
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  currentData['liq']!,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 11,
                  ),
                ),
                Text(
                  currentData['mcap']!,
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 9,
                  ),
                ),
              ],
            ),
          ),
          
          // 24h % change
          Expanded(
            flex: 2,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
              decoration: BoxDecoration(
                color: Colors.green.withOpacity(0.1),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                '▲ ${pair.change24h.toStringAsFixed(1)}%',
                style: const TextStyle(
                  color: Colors.green,
                  fontSize: 9,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _getTokenAssetPath(String tokenName) {
    // Map token names to their asset paths
    final Map<String, String> tokenAssets = {
      'Simpson': 'images/simpson.png',
      'UNCN': 'images/uncn.png',
      'BABYBNB': 'images/babybnb.png',
      'REALIS': 'images/realis.png',
    };
    
    // Return the asset path or a default one if not found
    return tokenAssets[tokenName] ?? 'images/wallet.png';
  }

  Color _getTokenColor(String name) {
    // Simple color assignment based on first character (fallback for error cases)
    switch (name.substring(0, 1).toUpperCase()) {
      case 'S':
        return Colors.orange;
      case 'U':
        return Colors.green;
      case 'B':
        return Colors.yellow[700]!;
      case 'R':
        return Colors.black;
      default:
        return Colors.blue;
    }
  }
}

class TradingPair {
  final String name;
  final String symbol;
  final double volume;
  final String volumeUnit;
  final double price;
  final String priceUnit;
  final double change24h;
  final double liquidity;

  TradingPair({
    required this.name,
    required this.symbol,
    required this.volume,
    required this.volumeUnit,
    required this.price,
    required this.priceUnit,
    required this.change24h,
    required this.liquidity,
  });
}
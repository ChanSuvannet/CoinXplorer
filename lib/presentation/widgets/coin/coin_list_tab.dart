import 'package:coinxplorer/core/constants/colors.dart';
import 'package:coinxplorer/data/models/coin_model.dart';
import 'package:flutter/material.dart';

class CoinListTab extends StatelessWidget {
  final List<Coin> coins;

  const CoinListTab({super.key, required this.coins});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Filter row with dropdowns
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              DropdownButton<String>(
                value: 'USD / BTC',
                items:
                    ['USD / BTC', 'USD / ETH'].map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                onChanged: (_) {},
              ),
              DropdownButton<String>(
                value: '24h %',
                items:
                    ['24h %', '7d %', '30d %'].map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                onChanged: (_) {},
              ),
              DropdownButton<String>(
                value: 'Top 100',
                items:
                    ['Top 100', 'Top 50'].map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                onChanged: (_) {},
              ),
              const Icon(Icons.filter_alt_outlined, color: Colors.grey),
            ],
          ),
        ),
        // Coin list header
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Row(
            children: [
              Text('#', style: TextStyle(color: AppColors.textTertiary)),
              SizedBox(width: 20),
              Expanded(
                child: Text(
                  'Market Cap',
                  style: TextStyle(color: AppColors.textTertiary),
                ),
              ),

              SizedBox(width: 150),
              Text('Price', style: TextStyle(color: AppColors.textTertiary)),
              SizedBox(width: 40),
              Text('24h%', style: TextStyle(color: AppColors.textTertiary)),
            ],
          ),
        ),
        // Coin list
        Expanded(
          child: ListView.builder(
            itemCount: coins.length,
            itemBuilder: (context, index) {
              final coin = coins[index];
              return ListTile(
                leading: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      '${coin.marketCapRank}',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(width: 8),
                    Image.network(
                      coin.image,
                      width: 20,
                      height: 20,
                      errorBuilder:
                          (_, __, ___) => const Icon(Icons.image_not_supported),
                    ),
                  ],
                ),
                title: Text(
                  '${coin.name}',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  '\$${_formatNumber(coin.marketCap)}',
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '\$${coin.currentPrice.toStringAsFixed(2)}',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          '${coin.priceChangePercentage24h.toStringAsFixed(2)}%',
                          style: TextStyle(
                            color:
                                coin.priceChangePercentage24h >= 0
                                    ? Colors.green
                                    : Colors.red,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(width: 8),
                    SizedBox(
                      width: 50,
                      height: 20,
                      child: Image.asset(
                        coin.priceChangePercentage24h >= 0
                            ? 'assets/images/line_up.png'
                            : 'assets/images/line_down.png',
                        fit: BoxFit.contain,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  String _formatNumber(num number) {
    if (number >= 1e12) return '${(number / 1e12).toStringAsFixed(2)}T';
    if (number >= 1e9) return '${(number / 1e9).toStringAsFixed(2)}B';
    if (number >= 1e6) return '${(number / 1e6).toStringAsFixed(2)}M';
    return number.toStringAsFixed(2);
  }
}

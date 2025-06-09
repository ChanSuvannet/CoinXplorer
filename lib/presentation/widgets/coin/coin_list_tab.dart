import 'package:coinxplorer/data/models/coin_model.dart';
import 'package:coinxplorer/presentation/widgets/coin/simple_line_chart.dart';
import 'package:flutter/material.dart';

class CoinListTab extends StatelessWidget {
  final List<Coin> coins;

  const CoinListTab({super.key, required this.coins});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: coins.length,
      itemBuilder: (context, index) {
        final coin = coins[index];
        return ListTile(
          leading: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '#${coin.rank}',
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
            coin.symbol,
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
                    '\$${coin.price.toStringAsFixed(2)}',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '${coin.change.toStringAsFixed(2)}%',
                    style: TextStyle(
                      color: coin.change >= 0 ? Colors.green : Colors.red,
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 8),
              SizedBox(
                width: 50,
                height: 20,
                child: CustomPaint(painter: SimpleLineChart()),
              ),
            ],
          ),
        );
      },
    );
  }

  String _formatNumber(num number) {
    if (number >= 1e12) return '${(number / 1e12).toStringAsFixed(2)}T';
    if (number >= 1e9) return '${(number / 1e9).toStringAsFixed(2)}B';
    if (number >= 1e6) return '${(number / 1e6).toStringAsFixed(2)}M';
    return number.toStringAsFixed(2);
  }
}

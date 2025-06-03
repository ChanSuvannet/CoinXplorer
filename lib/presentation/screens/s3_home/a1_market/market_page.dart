import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MarketPage extends StatefulWidget {
  const MarketPage({super.key});

  @override
  State<MarketPage> createState() => _MarketPageState();
}

class _MarketPageState extends State<MarketPage> {
  List<dynamic> _coins = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchCoinData();
  }

  Future<void> _fetchCoinData() async {
    try {
      final response = await http.get(
        Uri.parse('http://10.0.2.2:5174/api/coins/live'),
      );
      if (response.statusCode == 200) {
        setState(() {
          _coins = jsonDecode(response.body);
          _isLoading = false;
        });
      } else {
        throw Exception('Failed to load coin data');
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      print('Error fetching coin data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Markets'),
        actions: [
          IconButton(icon: const Icon(Icons.filter_list), onPressed: () {}),
        ],
      ),
      body:
          _isLoading
              ? const Center(child: CircularProgressIndicator())
              : Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildSummaryCard(
                          'Market Cap',
                          '\$${_formatNumber(_coins.fold(0, (sum, coin) => sum + coin['market_cap']))}',
                          '5.78%',
                        ),
                        _buildSummaryCard(
                          'Volume',
                          '\$${_formatNumber(_coins.fold(0, (sum, coin) => sum + coin['total_volume']))}',
                          '-5.78%',
                        ),
                        _buildSummaryCard('Dominance', '50.46% BTC', ''),
                        _buildSummaryCard('Fear & Greed', '50', ''),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
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
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: _coins.length,
                      itemBuilder: (context, index) {
                        final coin = _coins[index];
                        return ListTile(
                          leading: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                '${coin['market_cap_rank']}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Image.network(
                                coin['image'],
                                width: 30,
                                height: 30,
                              ),
                            ],
                          ),
                          title: Row(
                            children: [
                              Text(coin['symbol'].toString().toUpperCase()),
                              const SizedBox(width: 4),
                              Expanded(
                                child: Text(
                                  coin['name'],
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                          subtitle: Text(
                            '\$${_formatNumber(coin['market_cap'])}',
                          ),
                          trailing: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '\$${coin['current_price'].toStringAsFixed(2)}',
                              ),
                              Text(
                                '${coin['price_change_percentage_24h'].toStringAsFixed(2)}%',
                                style: TextStyle(
                                  color:
                                      coin['price_change_percentage_24h'] >= 0
                                          ? Colors.green
                                          : Colors.red,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
    );
  }

  Widget _buildSummaryCard(String title, String value, String change) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            ),
            const SizedBox(height: 4),
            Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
            if (change.isNotEmpty) ...[
              const SizedBox(height: 4),
              Text(
                change,
                style: TextStyle(
                  fontSize: 12,
                  color: change.startsWith('-') ? Colors.red : Colors.green,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  String _formatNumber(num number) {
    if (number >= 1e12) {
      return '${(number / 1e12).toStringAsFixed(2)}T';
    } else if (number >= 1e9) {
      return '${(number / 1e9).toStringAsFixed(2)}B';
    } else if (number >= 1e6) {
      return '${(number / 1e6).toStringAsFixed(2)}M';
    }
    return number.toString();
  }
}

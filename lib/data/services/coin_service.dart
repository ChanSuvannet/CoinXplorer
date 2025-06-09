import 'dart:convert';

import 'package:coinxplorer/data/models/coin_model.dart';
import 'package:http/http.dart' as http;

class CoinService {
  static Future<List<Coin>> fetchCoins() async {
    final url = Uri.parse('http://10.0.2.2:5174/api/coins/live');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return (data as List).map((e) => Coin.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load coins');
    }
  }
}

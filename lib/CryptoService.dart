// lib/crypto_service.dart

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'Crypto.dart';

class CryptoService {
  static const String apiUrl = 'https://api.coinlore.net/api/tickers/';

  Future<List<Crypto>> fetchCryptos() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body)['data'];
      return data.map((json) => Crypto.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load data');
    }
  }
}

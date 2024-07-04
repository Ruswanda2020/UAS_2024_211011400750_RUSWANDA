// lib/main.dart

import 'package:flutter/material.dart';
import 'Crypto.dart';
import 'CryptoService.dart';

void main() {
  runApp(const CryptoPriceApp());
}

class CryptoPriceApp extends StatelessWidget {
  const CryptoPriceApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Crypto Price App',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: const CryptoListPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class CryptoListPage extends StatefulWidget {
  const CryptoListPage({Key? key}) : super(key: key);

  @override
  _CryptoListPageState createState() => _CryptoListPageState();
}

class _CryptoListPageState extends State<CryptoListPage> {
  late Future<List<Crypto>> futureCryptos;

  @override
  void initState() {
    super.initState();
    futureCryptos = CryptoService().fetchCryptos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Crypto Prices',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.deepPurpleAccent,
      ),
      body: FutureBuilder<List<Crypto>>(
        future: futureCryptos,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
              child: Text(
                'Failed to load data: ${snapshot.error}',
                style: const TextStyle(color: Colors.red),
              ),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text(
                'No data available',
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
            );
          } else {
            final cryptos = snapshot.data!;
            return ListView.builder(
              itemCount: cryptos.length,
              itemBuilder: (context, index) {
                final crypto = cryptos[index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    elevation: 5,
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${crypto.name} (${crypto.symbol})',
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            'Price: \$${crypto.priceUsd.toStringAsFixed(2)}',
                            style: const TextStyle(
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            '24h Change: ${crypto.percentChange24h}%',
                            style: TextStyle(
                              fontSize: 16,
                              color: crypto.percentChange24h < 0
                                  ? Colors.red
                                  : Colors.green,
                            ),
                          ),
                          Text(
                            'Market Cap: \$${crypto.marketCapUsd.toStringAsFixed(2)}',
                            style: const TextStyle(
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            'Volume 24h: \$${crypto.volume24.toStringAsFixed(2)}',
                            style: const TextStyle(
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            'Circulating Supply: ${crypto.csupply}',
                            style: const TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}

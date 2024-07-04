class Crypto {
  final String id;
  final String symbol;
  final String name;
  final String nameid;
  final int rank;
  final double priceUsd;
  final double percentChange24h;
  final double percentChange1h;
  final double percentChange7d;
  final double marketCapUsd;
  final double volume24;
  final double csupply;

  Crypto({
    required this.id,
    required this.symbol,
    required this.name,
    required this.nameid,
    required this.rank,
    required this.priceUsd,
    required this.percentChange24h,
    required this.percentChange1h,
    required this.percentChange7d,
    required this.marketCapUsd,
    required this.volume24,
    required this.csupply,
  });

  factory Crypto.fromJson(Map<String, dynamic> json) {
    return Crypto(
      id: json['id'],
      symbol: json['symbol'],
      name: json['name'],
      nameid: json['nameid'],
      rank: json['rank'],
      priceUsd: double.parse(json['price_usd']),
      percentChange24h: double.parse(json['percent_change_24h']),
      percentChange1h: double.parse(json['percent_change_1h']),
      percentChange7d: double.parse(json['percent_change_7d']),
      marketCapUsd: double.parse(json['market_cap_usd']),
      volume24: double.parse(json['volume24'].toString()),
      csupply: double.parse(json['csupply']),
    );
  }
}

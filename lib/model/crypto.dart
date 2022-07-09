class Crypto {
  int rank;
  String id;
  String symbol;
  String name;
  String supply;
  double marketCapUsd;
  double changePercent24Hr;
  double priceUsd;

  Crypto(
    this.id,
    this.rank, 
    this.symbol, 
    this.name,
    this.supply,
    this.marketCapUsd,
    this.changePercent24Hr,
    this.priceUsd,
  );

  factory Crypto.fromMap(Map<String, dynamic> recivedMapData){
    return Crypto(
      recivedMapData['id'],
      int.parse(recivedMapData['rank']),
      recivedMapData['symbol'],
      recivedMapData['name'],
      recivedMapData['supply'],
      double.parse(recivedMapData['marketCapUsd']),
      double.parse(recivedMapData['changePercent24Hr']),
      double.parse(recivedMapData['priceUsd']),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:crypto/model/crypto.dart';

class ListOfCryptos extends StatefulWidget {
  ListOfCryptos({Key? key, this.list}) : super(key: key);
  List<Crypto>? list;
  @override
  State<ListOfCryptos> createState() => _ListOfCryptosState();
}

class _ListOfCryptosState extends State<ListOfCryptos> {
  List<Crypto>? list;
  @override
  void initState(){
    super.initState();
    list = widget.list;
  }
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: list!.length,
      itemBuilder: (context, index) {
        return _getCryptoItems(list![index]);
      },
    );
  }
  _getCryptoItems(crypto){
    return ListTile(
      leading: SizedBox(
        width: 30,
        child: Center(
          child: Text(
            crypto.rank.toString(),
            style: TextStyle(
              fontSize: 18,
            ),
            )
          ),
      ),
      title: Text(
        crypto.name,
        style: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 20,
        )
      ),
      subtitle: Text(crypto.symbol),
      trailing: SizedBox(
        width: 150,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  "\$"+crypto.priceUsd.toStringAsFixed(2),
                  style: TextStyle(
                    fontSize: 20
                    )
                ),
                Text(
                  (crypto.changePercent24Hr*100).toStringAsFixed(2)+"%",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: crypto.changePercent24Hr > 0 ? Colors.green : crypto.changePercent24Hr < 0 ? Colors.red : Colors.black,
                  ), 
                ),
              ],
            ),
            SizedBox(width: 15),
            _iconStatusPrice(crypto.changePercent24Hr),
          ]
        ),
      ),
    );
  }

  _iconStatusPrice(priceChange){
    if(priceChange > 0){
      return Icon(
        Icons.trending_up,
        size: 24,
        color: Colors.green,
      );
    }
    if(priceChange < 0){
      return Icon(
        Icons.trending_down,
        size: 24,
        color: Colors.red,
      );
    }
  }
}
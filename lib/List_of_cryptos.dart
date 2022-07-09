import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:crypto/model/crypto.dart';

class ListOfCryptos extends StatefulWidget {
  ListOfCryptos({Key? key, final this.list}) : super(key: key);
  final List<Crypto>? list;
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
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Flo Crypto",
          style: TextStyle(
            fontSize: 28,
          ),
        ),
        centerTitle: true,
        backgroundColor: Color(0xff080233),
      ),
      backgroundColor: Color(0xff080233),
      body: SafeArea(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
          Container(
            decoration: BoxDecoration(
              color: Color(0xff080233),
            ),
            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
            child: TextField(
              onChanged: (value) => { _search(value) },
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
              decoration: InputDecoration(
                enabledBorder: InputBorder.none,
                hintText: "Search ...",
                hintStyle: TextStyle(
                  color: Color.fromARGB(255, 167, 166, 166),
                  fontSize: 20,
                ),
              ),
            ),
          ),

        Expanded(
          child: ListView.builder(
            itemCount: list!.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: _getCryptoItems(list![index]),
              );
            },
          ),
        ),
      ],)
      ),
    );
  }


  _getCryptoItems(crypto){
    return ListTile(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
        
      ),
      tileColor: Color.fromARGB(206, 57, 52, 85),
      leading: SizedBox(
        width: 30,
        child: Center(
          child: Text(
            crypto.rank.toString(),
            style: TextStyle(
              fontSize: 22,
              color: Colors.white,
            ),
            )
          ),
      ),
      title: Text(
        crypto.name,
        style: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 20,
          color: Color.fromARGB(255, 200, 210, 252),
        )
      ),
      subtitle: Text(
        crypto.symbol,
        style: TextStyle(
          color: Colors.grey,
        ),  
      ),
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
                    fontSize: 18,
                    color: Color.fromARGB(255, 229, 234, 252),
                    fontWeight: FontWeight.w500
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

  Future<void> _search(String enteredKeyword) async {
    List<Crypto> cryptoResultList = [];
    if (enteredKeyword.isEmpty) {
      var result = await _getData();
      setState(() {
        list = result;
      });
      return;
    }
    cryptoResultList = list!.where((element) {
      return element.name.toLowerCase().contains(enteredKeyword.toLowerCase());
    }).toList();

    setState(() {
      list = cryptoResultList;
    });
  }

  Future<List<Crypto>> _getData() async {
    var response = await Dio().get('https://api.coincap.io/v2/assets');
    return response.data['data'].map<Crypto>((recivedJson) => Crypto.fromMap(recivedJson)).toList();
  }
}
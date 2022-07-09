import 'package:flutter/material.dart';
import './List_of_cryptos.dart';
import './load.dart';

import 'package:dio/dio.dart';
import './model/crypto.dart';


void main() {
  runApp(Application());
}

class Application extends StatefulWidget {
  const Application({Key? key}) : super(key: key);

  @override
  State<Application> createState() => _ApplicationState();
}

class _ApplicationState extends State<Application> {
  bool loaded = false;
  List<Crypto> list = [];
  @override
  void initState(){
    super.initState();
    _getData();
  }
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SafeArea(
          child: Content(),
        ),
      ),
    );
  }

  Content(){
    if(!loaded){
      return Load();

    } else {
      return ListOfCryptos(list: list);
    }
  }

  Future _getData() async{
    var response = await Dio().get('https://api.coincap.io/v2/assets');
    List<Crypto> allCryptos = response.data['data'].map<Crypto>((jsonObject) => Crypto.fromMap(jsonObject)).toList();
    setState((){
      loaded = true;
      list = allCryptos;
    });
  }
}

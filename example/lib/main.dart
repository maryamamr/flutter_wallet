import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter_wallet/flutter_wallet.dart';
import 'package:dio/dio.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  Future<void> getPass() async {
    String jsonParameters = '{';
    jsonParameters += '"serialNumber" : "123456789",';
    jsonParameters += '"relevantDate" : "2019-07-20T15:30:00-06:00",';
    jsonParameters += '"latitude" : 19.687,';
    jsonParameters += '"longitude" : -101.151,';
    jsonParameters += '"relevantText" : "Wellcome';
    jsonParameters += '"message" : "QQ2475P",';
    jsonParameters += '"date" : "20 Jul.",';
    jsonParameters += '"time" : "03:30 PM",';
    jsonParameters += '"movie" : "Movie Name",';
    jsonParameters += '"cinema" : "Cinema Name",';
    jsonParameters += '"seats" : "A1",';
    jsonParameters += '"room" : "10",';
    jsonParameters += '"poster" : "https://domain.com/images/image.jpg"';
    jsonParameters += '}';

    Response response;
    Dio dio = new Dio();

    response = await dio.post("http://domain.com/getPKPass.php",
        data: jsonParameters,
        options: Options(responseType: ResponseType.bytes));

    if (response.data != null) {
      try {
        var result = await FlutterWallet.addPass(pkpass: response.data);
        print(result);
      } catch (e) {
        print(e);
      }
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Passbook example app'),
        ),
        body: Center(
          child: ElevatedButton(
            child: Text("Get Passbook"),
            onPressed: () {
              getPass();
            },
          ),
        ),
      ),
    );
  }
}

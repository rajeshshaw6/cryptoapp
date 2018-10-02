import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return HomePage();
  }
}

class HomePage extends StatefulWidget {
  @override
  HomePageState createState() => new HomePageState();
}

class HomePageState extends State<HomePage> {
  List currency;
  List<MaterialColor> colors = [
    Colors.blue,
    Colors.indigo,
    Colors.red,
    Colors.green,
    Colors.teal,
    Colors.orange,
    Colors.brown
  ];

  Future<String> getCurrencies() async {
    String url = "https://api.coinmarketcap.com/v1/ticker/?limit=50";
    http.Response response = await http.get(Uri.encodeFull(url));
    currency = json.decode(response.body);
    this.setState(() {});
    return "Success";
  }

  @override
  void initState() {
    super.initState();
    getCurrencies();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: new ThemeData(
        primarySwatch: Colors.pink,
      ),
      home: new Scaffold(
        appBar: new AppBar(
          title: new Center(
            child: new Text(
              "Crypto App",
              style: new TextStyle(
                color: Colors.black,
                fontSize: 25.0,
              ),
            ),
          ),
        ),
        body: new Column(
          children: <Widget>[
            new Flexible(
              child: new ListView.builder(
                itemCount: currency.length,
                itemBuilder: (BuildContext context, int index) {
                  return new Container(
                    padding: EdgeInsets.only(bottom: 20.0),
                    child: new ListTile(
                      leading: new CircleAvatar(
                        maxRadius: 25.0,
                        backgroundColor: colors[index % colors.length],
                        child: new Text(
                          currency[index]["name"][0],
                          style: new TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      title: new Text(
                        currency[index]["name"],
                        style: new TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: new Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          new Row(
                            children: <Widget>[
                              new Text(
                                "\$",
                                style: new TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              new Text(
                                currency[index]["price_usd"],
                                style: new TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                          percentWidget(currency[index]["percent_change_1h"]),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget percentWidget(String pricechange) {
    Text pricetext;
    if (double.parse(pricechange) > 0) {
      pricetext = new Text(
        "1 hour:" + pricechange + "%",
        style: new TextStyle(
          color: Colors.green,
          fontWeight: FontWeight.bold,
        ),
      );
    } else {
      pricetext = new Text(
        "1 hour:" + pricechange + "%",
        style: new TextStyle(
          color: Colors.red,
          fontWeight: FontWeight.bold,
        ),
      );
    }
    return pricetext;
  }
}

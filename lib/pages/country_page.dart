import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CountryPage extends StatefulWidget {
  const CountryPage({Key key}) : super(key: key);

  @override
  _CountryPageState createState() => _CountryPageState();
}

class _CountryPageState extends State<CountryPage> {
  var urlCountries = 'https://corona.lmao.ninja/v2/countries?sort=cases';
  List countriesData;

  fetchCountriesData() async {
    http.Response response = await http.get(urlCountries);
    setState(() {
      countriesData = jsonDecode(response.body);
    });
  }

  @override
  void initState() {
    super.initState();
    fetchCountriesData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Countries Status'),
      ),
      body: countriesData == null
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: countriesData == null ? 0 : countriesData.length,
              itemBuilder: (context, index) {
                return Container(
                  height: 130,
                  margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey[100],
                        offset: Offset(0, 10),
                        blurRadius: 10,
                      )
                    ],
                  ),
                  child: Row(
                    children: <Widget>[
                      Container(
                        margin:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 1),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              countriesData[index]['country'],
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Image.network(
                              countriesData[index]['countryInfo']['flag'],
                              height: 40,
                              width: 50,
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                          child: Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              'Confirmed' +
                                  countriesData[index]['cases'].toString(),
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.red,
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                                'Active' +
                                    countriesData[index]['active'].toString(),
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue,
                                )),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                                'Recovered' +
                                    countriesData[index]['recovered']
                                        .toString(),
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green,
                                )),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                                'Deaths' +
                                    countriesData[index]['deaths'].toString(),
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey[800],
                                )),
                            SizedBox(
                              height: 5,
                            ),
                          ],
                        ),
                      ))
                    ],
                  ),
                );
              }),
    );
  }
}

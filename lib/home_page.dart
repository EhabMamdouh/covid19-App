import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutterappnew/data_source.dart';
import 'package:flutterappnew/pages/country_page.dart';
import 'package:flutterappnew/panels/info_panel.dart';
import 'package:flutterappnew/panels/most_affected_countries.dart';
import 'package:flutterappnew/panels/world_wide_panel.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var urlAll = 'https://corona.lmao.ninja/v2/all';
  Map worldData;

  fetchWorldWideData() async {
    http.Response response = await http.get(urlAll);
    setState(() {
      worldData = jsonDecode(response.body);
      //print(response.body);
    });
  }

  var urlCountries = 'https://corona.lmao.ninja/v2/countries?sort=cases';
  List countriesData;

  fetchCountriesData() async {
    http.Response response = await http.get(urlCountries);
    setState(() {
      countriesData = jsonDecode(response.body);
      //print(response.body);
    });
  }

  @override
  void initState() {
    super.initState();
    fetchWorldWideData();
    fetchCountriesData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text('COVID-19 Panel'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.all(10),
              height: 100,
              color: Colors.orange[100],
              child: Text(
                DataSource.quote,
                style: TextStyle(
                    color: Colors.orange[800],
                    fontWeight: FontWeight.bold,
                    fontSize: 16),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Worldwide',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CountryPage(),
                        ),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: primaryblack,
                      ),
                      padding: EdgeInsets.all(10),
                      child: Text(
                        'Regional',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            worldData == null
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : WorldWidePanel(
                    worldWide: worldData,
                  ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                'Most Affected Countries',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            countriesData == null
                ? Center(child: CircularProgressIndicator())
                : MostAffecyedPanel(
                    countryData: countriesData,
                  ),
            InfoPanel(),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'We are together in this :)',
                  style: TextStyle(
                    color: primaryblack,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutterappnew/data_source.dart';
import 'package:flutterappnew/home_page.dart';

void main() => runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Circular',
        primaryColor: primaryblack,
      ),
      home: HomePage(),
    ));

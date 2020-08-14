import 'package:flutter/material.dart';
import 'package:flutterappnew/data_source.dart';

class FAQPage extends StatelessWidget {
  const FAQPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('FAQS'),
      ),
      body: ListView.builder(
          itemCount: DataSource.questionAnswers.length,
          itemBuilder: (context, index) {
            return ExpansionTile(
              title: Text(
                DataSource.questionAnswers[index]['question'],
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: primaryblack,
                ),
              ),
              children: <Widget>[
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 17, vertical: 8),
                  child: Text(DataSource.questionAnswers[index]['answer']),
                ),
              ],
            );
          }),
    );
  }
}

import 'package:flutter/material.dart';
import '../data/zodiac_data.dart';
import '../models/zodiac.dart';
import 'detail_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Burçlar")),
      body: ListView.builder(
        itemCount: zodiacList.length,
        itemBuilder: (context, index) {
          final zodiac = zodiacList[index];

          return ListTile(
            leading: Image.asset(zodiac.image, width: 40),
            title: Text(zodiac.name),
            subtitle: Text(zodiac.date),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => DetailScreen(zodiac: zodiac),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

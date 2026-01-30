import 'package:flutter/material.dart';
import '../models/zodiac.dart';

class DetailScreen extends StatelessWidget {
  final Zodiac zodiac;

  DetailScreen({required this.zodiac});

  @override
  Widget build(BuildContext context) {
    final features = zodiac.description
        .split("\n")
        .where((e) => e.trim().isNotEmpty)
        .toList();

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 300,
            pinned: true,
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () => Navigator.pop(context),
            ),
            flexibleSpace: FlexibleSpaceBar(
              title: Text(zodiac.name),
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset(
                    zodiac.image,
                    fit: BoxFit.cover,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.black.withOpacity(0.7),
                          Colors.transparent,
                        ],
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    zodiac.date,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(height: 16),

                  Text(
                    "Özellikler",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 12),

                  ...features.map((feature) {
                    return Card(
                      elevation: 4,
                      margin: EdgeInsets.symmetric(vertical: 6),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: ListTile(
                        leading: Icon(
                          Icons.star,
                          color: Colors.orange,
                        ),
                        title: Text(
                          feature.replaceAll(RegExp(r'^\d+\.\s*'), ''),
                        ),
                      ),
                    );
                  }).toList(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

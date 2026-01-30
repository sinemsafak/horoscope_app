import 'package:flutter/material.dart';
import 'dart:ui';
import '../models/zodiac.dart';

class DetailScreen extends StatelessWidget {
  final Zodiac zodiac;

  DetailScreen({required this.zodiac});

  @override
  Widget build(BuildContext context) {
    final features = zodiac.description
        .split("\n")
        .where((e) =>
            e.trim().isNotEmpty &&
            !e.contains("Özellikleri") &&
            !e.contains("burcu"))
        .toList();

    return Scaffold(
      body: Stack(
        children: [
          // BACKGROUND IMAGE
          SizedBox(
            height: 420,
            width: double.infinity,
            child: Image.asset(
              zodiac.image,
              fit: BoxFit.cover,
            ),
          ),

          // DARK OVERLAY
          Container(
            height: 420,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.black.withOpacity(0.6),
                  Colors.black.withOpacity(0.2),
                  Colors.transparent,
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),

          // BACK BUTTON
          SafeArea(
            child: Padding(
              padding: EdgeInsets.all(12),
              child: CircleAvatar(
                backgroundColor: Colors.black54,
                child: IconButton(
                  icon: Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
            ),
          ),

          // CONTENT
          DraggableScrollableSheet(
            initialChildSize: 0.55,
            minChildSize: 0.55,
            maxChildSize: 0.9,
            builder: (context, scrollController) {
              return ClipRRect(
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(28),
                ),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                  child: Container(
                    color: Colors.white.withOpacity(0.85),
                    child: SingleChildScrollView(
                      controller: scrollController,
                      padding: EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: Container(
                              width: 40,
                              height: 4,
                              decoration: BoxDecoration(
                                color: Colors.grey[400],
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                          SizedBox(height: 16),

                          Text(
                            zodiac.name,
                            style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            zodiac.date,
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey[600],
                            ),
                          ),
                          SizedBox(height: 24),

                          Text(
                            "Özellikler",
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 16),

                          Wrap(
                            spacing: 12,
                            runSpacing: 12,
                            children: features.map((feature) {
                              return Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 12),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black12,
                                      blurRadius: 8,
                                      offset: Offset(0, 4),
                                    ),
                                  ],
                                ),
                                child: Text(
                                  feature.replaceAll(
                                      RegExp(r'^\d+\.\s*'), ''),
                                  style: TextStyle(fontSize: 15),
                                ),
                              );
                            }).toList(),
                          ),

                          SizedBox(height: 40),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'dart:ui';
import '../models/zodiac.dart';

class DetailScreen extends StatelessWidget {
  final Zodiac zodiac;

  DetailScreen({required this.zodiac});

  Color getZodiacColor(String name) {
    switch (name) {
      case "Koç":
        return Colors.redAccent;
      case "Boğa":
        return Colors.green;
      case "İkizler":
        return Colors.amber;
      case "Yengeç":
        return Colors.blue;
      case "Aslan":
        return Colors.orange;
      case "Başak":
        return Colors.brown;
      case "Terazi":
        return Colors.pink;
      case "Akrep":
        return Colors.deepPurple;
      case "Yay":
        return Colors.indigo;
      case "Oğlak":
        return Colors.grey;
      case "Kova":
        return Colors.cyan;
      case "Balık":
        return Colors.teal;
      default:
        return Colors.deepPurple;
    }
  }

  @override
  Widget build(BuildContext context) {
    final color = getZodiacColor(zodiac.name);

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
          // BACKGROUND POSTER
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
                  Colors.black.withOpacity(0.65),
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

          // GLASS CONTENT PANEL
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
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.white.withOpacity(0.95),
                          Colors.grey.shade100.withOpacity(0.95),
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                    child: SingleChildScrollView(
                      controller: scrollController,
                      padding: EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // DRAG INDICATOR
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

                          // TITLE
                          Text(
                            zodiac.name,
                            style: TextStyle(
                              fontSize: 34,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
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
                              color: Colors.black87,
                            ),
                          ),
                          SizedBox(height: 16),

                          // MODERN FEATURE CARDS
                          Wrap(
                            spacing: 12,
                            runSpacing: 12,
                            children: features.map((feature) {
                              return Container(
                                width:
                                    MediaQuery.of(context).size.width * 0.42,
                                padding: EdgeInsets.all(14),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(14),
                                  border: Border.all(
                                    color: Colors.grey.shade300,
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black12,
                                      blurRadius: 6,
                                      offset: Offset(0, 4),
                                    ),
                                  ],
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: 8,
                                      height: 8,
                                      margin: EdgeInsets.only(top: 6),
                                      decoration: BoxDecoration(
                                        color: color,
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                    SizedBox(width: 10),
                                    Expanded(
                                      child: Text(
                                        feature.replaceAll(
                                            RegExp(r'^\d+\.\s*'), ''),
                                        style: TextStyle(
                                          fontSize: 14,
                                          height: 1.4,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black87,
                                        ),
                                      ),
                                    ),
                                  ],
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

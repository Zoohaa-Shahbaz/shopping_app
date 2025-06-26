import 'package:flutter/material.dart';

class AppTextStyles {
  // Headline (e.g., Titles, Page Headers)
  static TextStyle headline({Color color = Colors.black}) {
    return TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.bold,
      color: color,
    );
  }



  // Subheading
  static const TextStyle subheading = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: Colors.black87,
  );

  static const TextStyle priceStyle = TextStyle(
    color: Colors.red,
    fontWeight: FontWeight.bold,
    fontSize: 16,
  );
  // Body text
  static const TextStyle body = TextStyle(
    fontSize: 16,
    color: Colors.black,
  );

  // Bold Body text
  static const TextStyle boldBody = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: Colors.black,
  );

  // Small Text
  static const TextStyle small = TextStyle(
    fontSize: 12,
    color: Colors.grey,
  );
}

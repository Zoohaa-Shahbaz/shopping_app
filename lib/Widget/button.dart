import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final Color color;
  final VoidCallback onPressed;
  final double? width; // ✅ Add width parameter
  final double? font; // ✅ Add width parameter


  const CustomButton({
    super.key,
    required this.text,
    required this.color,
    required this.onPressed,
    this.width, this.font, // ✅ Include in constructor
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Get.height / 14,
      width: width ?? Get.width / 2.5, // ✅ Use custom width if provided
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          elevation: 0,
        ),
        child: Align(
          alignment: Alignment.center,
          child: Text(
            text,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: font ?? 15,
            ),
          ),
        ),
      ),
    );
  }
}

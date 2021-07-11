import 'package:flutter/material.dart';

class ImageButton extends StatelessWidget {
  final String image;
  final VoidCallback onTap;

  const ImageButton({required this.image, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        height: 50,
        width: 50,
        child: Image.asset(image),
      ),
    );
  }
}

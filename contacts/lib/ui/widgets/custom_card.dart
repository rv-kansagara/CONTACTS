import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  final Widget child;
  final double radius;
  final double padding;

  const CustomCard({required this.child, this.radius = 20, this.padding = 2});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      padding: EdgeInsets.all(padding),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.circular(radius),
        boxShadow: [
          BoxShadow(
            color: Colors.grey[700]!.withOpacity(0.1),
            offset: const Offset(-2, -2),
            blurRadius: 2,
            spreadRadius: 1,
          ),
          BoxShadow(
            color: Colors.black.withOpacity(0.7),
            offset: const Offset(2, 2),
            blurRadius: 2,
            spreadRadius: 1,
          ),
        ],
      ),
      child: child,
    );
  }
}

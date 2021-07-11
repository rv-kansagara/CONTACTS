import 'package:flutter/material.dart';

class ContactDetails extends StatefulWidget {
  final String label;
  final String value;

  const ContactDetails({required this.label, required this.value});

  @override
  _ContactDetailsState createState() => _ContactDetailsState();
}

class _ContactDetailsState extends State<ContactDetails>
    with TickerProviderStateMixin {
  late final _controller = AnimationController(
    vsync: this,
    duration: Duration(seconds: 1),
  )..forward();

  late final _animation = CurvedAnimation(
    parent: _controller,
    curve: Curves.easeInCubic,
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: FadeTransition(
        opacity: _animation,
        child: ListTile(
          leading: Text(
            widget.label,
            style: const TextStyle(
              fontSize: 16.5,
              letterSpacing: 1,
              color: Colors.white,
            ),
          ),
          trailing: Text(
            widget.value,
            style: const TextStyle(
              fontSize: 16.5,
              letterSpacing: 1,
              color: Colors.white70,
            ),
          ),
        ),
      ),
    );
  }
}

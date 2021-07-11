import 'package:flutter/material.dart';

import 'custom_card.dart';

class ContactImage extends StatefulWidget {
  final String image;

  const ContactImage({required this.image});

  @override
  _ContactImageState createState() => _ContactImageState();
}

class _ContactImageState extends State<ContactImage>
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
      padding: const EdgeInsets.all(10),
      child: FadeTransition(
        opacity: _animation,
        child: CustomCard(
          radius: 100,
          padding: 10,
          child: CircleAvatar(
            radius: 60,
            backgroundColor: Colors.transparent,
            backgroundImage: AssetImage(widget.image),
          ),
        ),
      ),
    );
  }
}

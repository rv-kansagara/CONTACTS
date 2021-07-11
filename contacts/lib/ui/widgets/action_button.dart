import 'package:flutter/material.dart';

class ActionButton extends StatefulWidget {
  final IconData icon;
  final double iconSize;
  final Color? color;
  final Color? background;
  final VoidCallback onTap;

  const ActionButton({
    required this.icon,
    this.iconSize = 26.5,
    this.color = Colors.white,
    this.background = Colors.transparent,
    required this.onTap,
  });

  @override
  _ActionButtonState createState() => _ActionButtonState();
}

class _ActionButtonState extends State<ActionButton>
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
    return FadeTransition(
      opacity: _animation,
      child: GestureDetector(
        onTap: widget.onTap,
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration:
              BoxDecoration(color: widget.background, shape: BoxShape.circle),
          child: Icon(widget.icon, size: widget.iconSize, color: widget.color),
        ),
      ),
    );
  }
}

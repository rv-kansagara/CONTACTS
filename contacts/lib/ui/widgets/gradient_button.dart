import 'package:flutter/material.dart';

class GradientButton extends StatefulWidget {
  final String text;
  final IconData? icon;
  final bool isLoading;
  final VoidCallback onTap;

  const GradientButton({
    required this.text,
    this.icon,
    this.isLoading = false,
    required this.onTap,
  });

  @override
  _GradientButtonState createState() => _GradientButtonState();
}

class _GradientButtonState extends State<GradientButton>
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
          height: 50,
          width: double.infinity,
          margin: const EdgeInsets.symmetric(horizontal: 40, vertical: 30),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [
                Theme.of(context).accentColor,
                Colors.pink,
              ],
            ),
          ),
          child: widget.isLoading
              ? Center(
                  child: const CircularProgressIndicator(
                    backgroundColor: Colors.black,
                    color: Colors.white,
                    strokeWidth: 4.5,
                  ),
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    widget.icon != null
                        ? Icon(widget.icon, size: 30)
                        : SizedBox.shrink(),
                    const SizedBox(width: 10),
                    Text(
                      widget.text,
                      style: TextStyle(
                        fontSize: 16.5,
                        letterSpacing: 1,
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../../data/providers/contacts_provider.dart';

class FavouriteButton extends StatefulWidget {
  final int index;

  const FavouriteButton({required this.index});

  @override
  _FavouriteButtonState createState() => _FavouriteButtonState();
}

class _FavouriteButtonState extends State<FavouriteButton>
    with TickerProviderStateMixin {
  late final _controller = AnimationController(
    vsync: this,
    duration: Duration(seconds: 1),
  );

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
    return Consumer<ContactsProvider>(
      builder: (context, data, _) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: IconButton(
            splashRadius: 24,
            icon: Icon(data.contacts[widget.index].isFavourite
                ? Icons.favorite_rounded
                : Icons.favorite_border_rounded),
            onPressed: () {
              data.toggleFavourite(index: widget.index);
            },
          ),
        );
      },
    );
  }
}

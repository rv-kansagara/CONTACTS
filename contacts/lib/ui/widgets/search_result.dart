import 'package:flutter/material.dart';

import 'package:url_launcher/url_launcher.dart';

import '../../data/models/contact.dart';

import '../screens/screens.dart';
import '../widgets/widgets.dart';

class SearchResult extends StatefulWidget {
  final List<Contact> result;
  final int index;

  const SearchResult({required this.result, required this.index});

  @override
  _SearchResultState createState() => _SearchResultState();
}

class _SearchResultState extends State<SearchResult>
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
    return GestureDetector(
      onTap: () => Navigator.pushNamed(
        context,
        ContactScreen.route,
        arguments: widget.index,
      ),
      child: FadeTransition(
        opacity: _animation,
        child: ListTile(
          leading: CircleAvatar(
            radius: 28,
            backgroundColor: Colors.transparent,
            backgroundImage: AssetImage(widget.result[widget.index].avatar),
          ),
          title: Padding(
            padding: const EdgeInsets.only(bottom: 4),
            child: Text(
              '${widget.result[widget.index].firstName} ${widget.result[widget.index].lastName}',
              style: const TextStyle(fontSize: 17, letterSpacing: 1),
            ),
          ),
          subtitle: Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Text(
              widget.result[widget.index].occupation,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 14.8, letterSpacing: 1),
            ),
          ),
          trailing: ButtonBar(
            mainAxisSize: MainAxisSize.min,
            alignment: MainAxisAlignment.spaceEvenly,
            buttonPadding: const EdgeInsets.all(0),
            children: [
              ActionButton(
                icon: Icons.call_outlined,
                color: Colors.lightBlue,
                onTap: () {
                  launch('tel: ${widget.result[widget.index].phone}');
                },
              ),
              ActionButton(
                icon: Icons.sms_outlined,
                color: Colors.orange,
                onTap: () {
                  launch('sms: ${widget.result[widget.index].phone}');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

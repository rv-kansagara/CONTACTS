import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:url_launcher/url_launcher.dart';

import '../../data/providers/contacts_provider.dart';

import '../widgets/widgets.dart';
import '../screens/screens.dart';

class ContactTile extends StatefulWidget {
  final int index;

  ContactTile({required this.index});

  @override
  _ContactTileState createState() => _ContactTileState();
}

class _ContactTileState extends State<ContactTile>
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
    return Consumer<ContactsProvider>(
      builder: (context, data, _) {
        return Dismissible(
          key: UniqueKey(),
          direction: DismissDirection.endToStart,
          background: Container(
            padding: EdgeInsets.symmetric(horizontal: 30),
            alignment: Alignment.centerRight,
            child: Icon(
              Icons.delete_forever_rounded,
              size: 30,
              color: Colors.deepOrange,
            ),
          ),
          confirmDismiss: (direction) async {
            return await showDialog(
              barrierDismissible: false,
              context: context,
              builder: (context) {
                return AlertDialog(
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  backgroundColor:
                      Theme.of(context).primaryColor.withOpacity(0.95),
                  title: Text(
                    'Are you sure?',
                    style: const TextStyle(letterSpacing: 1),
                  ),
                  content: Text(
                    'This action can\'t be undone!',
                    style: const TextStyle(letterSpacing: 1),
                  ),
                  actions: [
                    TextButton.icon(
                      icon: const Icon(Icons.done_all_rounded),
                      label: const Text('OKAY'),
                      style: TextButton.styleFrom(
                        primary: Theme.of(context).accentColor,
                      ),
                      onPressed: () {
                        data.deleteContact(index: widget.index);
                        Navigator.pop(context);
                      },
                    ),
                    TextButton.icon(
                      icon: const Icon(Icons.cancel_rounded),
                      label: const Text('CANCEL'),
                      style: TextButton.styleFrom(
                        primary: Theme.of(context).accentColor,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ],
                );
              },
            );
          },
          child: GestureDetector(
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
                  backgroundImage:
                      AssetImage(data.contacts[widget.index].avatar),
                ),
                title: Padding(
                  padding: const EdgeInsets.only(bottom: 4),
                  child: Text(
                    '${data.contacts[widget.index].firstName} ${data.contacts[widget.index].lastName}',
                    style: const TextStyle(fontSize: 17, letterSpacing: 1),
                  ),
                ),
                subtitle: Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Text(
                    data.contacts[widget.index].occupation,
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
                        launch('tel: ${data.contacts[widget.index].phone}');
                      },
                    ),
                    ActionButton(
                      icon: Icons.sms_outlined,
                      color: Colors.orange,
                      onTap: () {
                        launch('sms: ${data.contacts[widget.index].phone}');
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:url_launcher/url_launcher.dart';

import '../../data/providers/contacts_provider.dart';

import '../widgets/widgets.dart';

class FavouriteContact extends StatefulWidget {
  final int index;

  const FavouriteContact({required this.index});

  @override
  _FavouriteContactState createState() => _FavouriteContactState();
}

class _FavouriteContactState extends State<FavouriteContact>
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
        return FadeTransition(
          opacity: _animation,
          child: SizedBox(
            width: 165,
            child: Stack(
              children: [
                Positioned(
                  top: 22,
                  child: CustomCard(
                    child: Container(
                      padding: const EdgeInsets.only(top: 28),
                      child: Column(
                        children: [
                          Text(
                            '${data.favouritesContacts[widget.index].firstName}',
                            style: const TextStyle(
                              fontSize: 20,
                              letterSpacing: 1,
                              height: 2,
                            ),
                          ),
                          Text(
                            data.favouritesContacts[widget.index].country,
                            style: const TextStyle(
                              fontSize: 16,
                              letterSpacing: 1,
                              height: 1.5,
                              color: Colors.grey,
                            ),
                          ),
                          SizedBox(
                            height: 60,
                            child: ButtonBar(
                              alignment: MainAxisAlignment.spaceEvenly,
                              buttonPadding: const EdgeInsets.all(0),
                              children: [
                                ActionButton(
                                  icon: Icons.call_outlined,
                                  color: Colors.lightBlue,
                                  onTap: () {
                                    launch(
                                      'tel: ${data.favouritesContacts[widget.index].phone}',
                                    );
                                  },
                                ),
                                ActionButton(
                                  icon: Icons.sms_outlined,
                                  color: Colors.orange,
                                  onTap: () {
                                    launch(
                                      'sms: ${data.favouritesContacts[widget.index].phone}',
                                    );
                                  },
                                ),
                                ActionButton(
                                  icon: Icons.alternate_email_outlined,
                                  color: Colors.pinkAccent,
                                  onTap: () {
                                    launch(
                                      'mailto: ${data.favouritesContacts[widget.index].email}',
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 47,
                  child: CircleAvatar(
                    radius: 34,
                    backgroundColor: Colors.transparent,
                    backgroundImage:
                        AssetImage(data.contacts[widget.index].avatar),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

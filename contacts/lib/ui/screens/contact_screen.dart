import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:url_launcher/url_launcher.dart';

import 'package:line_icons/line_icons.dart';

import '../../data/providers/contacts_provider.dart';

import '../widgets/widgets.dart';
import '../screens/screens.dart';

class ContactScreen extends StatelessWidget {
  static const String route = '/contact-screen';

  @override
  Widget build(BuildContext context) {
    final index = ModalRoute.of(context)!.settings.arguments as int;

    return Consumer<ContactsProvider>(
      builder: (context, data, _) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              '${data.contacts[index].firstName} ${data.contacts[index].lastName}',
              style: const TextStyle(letterSpacing: 2),
            ),
            actions: [FavouriteButton(index: index)],
          ),
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                ContactImage(image: data.contacts[index].avatar),
                ButtonBar(
                  alignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ActionButton(
                      icon: Icons.call_outlined,
                      background: Colors.lightBlue,
                      onTap: () {
                        launch('tel: ${data.contacts[index].phone}');
                      },
                    ),
                    ActionButton(
                      icon: Icons.sms_outlined,
                      background: Colors.orange,
                      onTap: () {
                        launch('sms: ${data.contacts[index].phone}');
                      },
                    ),
                    ActionButton(
                      icon: Icons.alternate_email_rounded,
                      background: Colors.pink,
                      onTap: () {
                        launch('mailto: ${data.contacts[index].email}');
                      },
                    ),
                    ActionButton(
                      icon: LineIcons.whatSApp,
                      iconSize: 28.5,
                      background: Colors.green,
                      onTap: () {
                        launch(
                          'whatsapp://send?phone=${data.contacts[index].phone}',
                        );
                      },
                    ),
                  ],
                ),
                ContactDetails(
                  label: 'Phone',
                  value: data.contacts[index].phone,
                ),
                ContactDetails(
                  label: 'Email',
                  value: data.contacts[index].email!,
                ),
                ContactDetails(
                  label: 'Gender',
                  value: data.contacts[index].gender!,
                ),
                ContactDetails(
                  label: 'Occupation',
                  value: data.contacts[index].occupation,
                ),
                ContactDetails(
                  label: 'Country',
                  value: data.contacts[index].country,
                ),
                GradientButton(
                  text: 'UPDATE',
                  icon: Icons.update_rounded,
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      CreateContact.route,
                      arguments: index,
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

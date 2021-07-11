import 'package:flutter/material.dart';

import 'package:hive/hive.dart';

import 'package:provider/provider.dart';

import 'package:path_provider/path_provider.dart' as path_provider;

import 'data/models/contact.dart';

import 'data/providers/providers.dart';

import 'ui/theme/theme.dart';

import 'ui/screens/screens.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final directory = await path_provider.getApplicationDocumentsDirectory();
  Hive.init('${directory.path}/hive');
  Hive.registerAdapter(ContactAdapter());
  await Hive.boxExists('contacts')
      .then((_) => Hive.openBox<Contact>('contacts'));
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final contactsProvider = ContactsProvider();
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ContactsProvider>.value(
          value: contactsProvider,
        ),
        Provider.value(value: AvatarsProvider())
      ],
      builder: (context, _) {
        return MaterialApp(
          title: 'Contacts',
          theme: theme,
          home: FutureBuilder(
            future: contactsProvider.getContacts(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return SplashScreen();
              } else if (snapshot.connectionState == ConnectionState.done) {
                snapshot.hasError ? SplashScreen() : HomeScreen();
              } else {
                return HomeScreen();
              }
              return HomeScreen();
            },
          ),
          routes: {
            HomeScreen.route: (context) => HomeScreen(),
            ContactScreen.route: (context) => ContactScreen(),
            CreateContact.route: (context) => CreateContact(),
          },
        );
      },
    );
  }
}

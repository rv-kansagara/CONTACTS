import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../../data/models/contact.dart';

import '../../data/providers/contacts_provider.dart';

import '../widgets/widgets.dart';

import 'screens.dart';

class HomeScreen extends StatelessWidget {
  static const String route = '/home-screen';

  @override
  Widget build(BuildContext context) {
    return Consumer<ContactsProvider>(
      builder: (context, data, _) {
        return Scaffold(
          floatingActionButton: FloatingActionButton(
            child: const Icon(Icons.add_rounded, size: 35),
            onPressed: () {
              Navigator.pushNamed(context, CreateContact.route);
            },
          ),
          appBar: AppBar(
            centerTitle: true,
            title: const Text(
              'CONTACTS',
              style: const TextStyle(letterSpacing: 2),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: IconButton(
                  splashRadius: 24,
                  icon: const Icon(Icons.search_rounded, size: 30),
                  onPressed: () async {
                    await showSearch(
                      context: context,
                      delegate: _ContactSearch(contacts: data),
                    );
                  },
                ),
              ),
            ],
          ),
          body: Column(
            children: [
              data.favouritesContacts.isNotEmpty
                  ? SizedBox(
                      height: 205,
                      child: ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        itemCount: data.favouritesContacts.length,
                        itemBuilder: (context, index) =>
                            FavouriteContact(index: index),
                      ),
                    )
                  : SizedBox.shrink(),
              data.contacts.isNotEmpty
                  ? Expanded(
                      child: ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        itemCount: data.contacts.length,
                        itemBuilder: (context, index) => CustomCard(
                          child: ContactTile(index: index),
                        ),
                      ),
                    )
                  : SizedBox.shrink(),
            ],
          ),
        );
      },
    );
  }
}

class _ContactSearch extends SearchDelegate<ContactsProvider> {
  final ContactsProvider contacts;

  _ContactSearch({required this.contacts});

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        splashRadius: 20,
        icon: const Icon(Icons.clear_rounded),
        onPressed: () => query = '',
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      splashRadius: 20,
      icon: const Icon(Icons.arrow_back_rounded),
      onPressed: () => close(context, ContactsProvider()),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return const SizedBox.shrink();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final List<Contact> _result = contacts.contacts
        .where((contact) => contact.firstName.toLowerCase().contains(query))
        .toList();
    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 10),
      itemCount: _result.length,
      itemBuilder: (context, index) => Padding(
        padding: const EdgeInsets.all(10),
        child: SearchResult(result: _result, index: index),
      ),
    );
  }
}

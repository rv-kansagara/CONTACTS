import 'package:flutter/foundation.dart';

import 'package:hive/hive.dart';

import '../models/contact.dart';

import 'package:contacts/data/providers/providers.dart';

class ContactsProvider with ChangeNotifier, AvatarsProvider {
  List<Contact> _contacts = [];

  List<Contact> get contacts => [..._contacts];

  List<Contact> get favouritesContacts =>
      [..._contacts].where((contact) => contact.isFavourite).toList();

  final _contactsBox = Hive.box<Contact>('contacts');

  Future getContacts() async {
    _contacts.clear();
    _contactsBox.values.forEach((contact) {
      final _contact = Contact(
          avatar: contact.avatar,
          firstName: contact.firstName,
          lastName: contact.lastName,
          phone: contact.phone,
          email: contact.email,
          gender: contact.gender,
          occupation: contact.occupation,
          country: contact.country,
          isFavourite: contact.isFavourite);
      _contacts.add(_contact);
    });
    notifyListeners();
  }

  Future<void> toggleFavourite({required int index}) async {
    final isFavourite = !_contacts[index].isFavourite;
    final _contact = Contact(
      avatar: _contacts[index].avatar,
      firstName: _contacts[index].firstName,
      lastName: _contacts[index].lastName,
      phone: _contacts[index].phone,
      email: _contacts[index].email,
      gender: _contacts[index].gender,
      occupation: _contacts[index].occupation,
      country: _contacts[index].country,
      isFavourite: isFavourite,
    );
    await _contactsBox.putAt(index, _contact);
    await getContacts();
  }

  Future<void> createContact({required Contact contact}) async {
    final _contact = Contact(
      avatar: contact.avatar,
      firstName: contact.firstName.trim(),
      lastName: contact.lastName!.trim(),
      phone: contact.phone.trim(),
      email: contact.email!.trim(),
      gender: contact.gender!.trim(),
      occupation: contact.occupation.trim(),
      country: contact.country.trim(),
    );
    await _contactsBox.add(_contact);
    await getContacts();
  }

  Future<void> updateContact({
    required Contact contact,
    required int index,
  }) async {
    final _contact = Contact(
      avatar: contact.avatar,
      firstName: contact.firstName.trim(),
      lastName: contact.lastName!.trim(),
      phone: contact.phone.trim(),
      email: contact.email!.trim(),
      gender: contact.gender!.trim(),
      occupation: contact.occupation.trim(),
      country: contact.country.trim(),
    );
    await _contactsBox.putAt(index, _contact);
    await getContacts();
  }

  Future<void> deleteContact({required int index}) async {
    await _contactsBox.deleteAt(index);
    await getContacts();
  }
}

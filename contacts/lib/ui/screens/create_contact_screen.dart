import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../../data/models/contact.dart';

import '../../data/providers/providers.dart';

import '../widgets/widgets.dart';

class CreateContact extends StatefulWidget {
  static const String route = '/create-contact-screen';

  @override
  _CreateContactState createState() => _CreateContactState();
}

class _CreateContactState extends State<CreateContact>
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

  final _key = GlobalKey<FormState>();
  final _userData = {};

  String? _avatar = 'assets/icons/user.png';

  Future<void> avatarBottomSheet(BuildContext context) async {
    return await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(10),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
              child: Container(
                height: MediaQuery.of(context).size.height - 250,
                child: Column(
                  children: [
                    Consumer<AvatarsProvider>(
                      builder: (context, data, _) {
                        return Expanded(
                          child: GridView.builder(
                            padding: const EdgeInsets.all(20),
                            physics: const BouncingScrollPhysics(),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 4,
                              childAspectRatio: 1 / 1,
                              crossAxisSpacing: 25,
                              mainAxisSpacing: 25,
                            ),
                            itemCount: 70,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _avatar = data.avatars[index].avatar;
                                  });
                                },
                                child: CircleAvatar(
                                  backgroundColor: Colors.transparent,
                                  backgroundImage: AssetImage(
                                    data.avatars[index].avatar,
                                  ),
                                ),
                              );
                            },
                          ),
                        );
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

  @override
  Widget build(BuildContext context) {
    final _index = ModalRoute.of(context)!.settings.arguments as int?;

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            _index == null ? 'NEW CONTACT' : 'UPDATE CONTACT',
            style: const TextStyle(letterSpacing: 2),
          ),
        ),
        body: Consumer<ContactsProvider>(
          builder: (context, data, _) {
            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Form(
                  key: _key,
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () async => await avatarBottomSheet(context),
                        child: FadeTransition(
                          opacity: _animation,
                          child: CustomCard(
                            padding: 4,
                            radius: 100,
                            child: CircleAvatar(
                              radius: 60,
                              backgroundColor: Colors.transparent,
                              backgroundImage: _avatar!.isNotEmpty
                                  ? AssetImage(_avatar!)
                                  : null,
                            ),
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: FadeTransition(
                                opacity: _animation,
                                child: TextFormField(
                                  textCapitalization: TextCapitalization.words,
                                  initialValue: _index != null
                                      ? data.contacts[_index].firstName
                                      : '',
                                  decoration: const InputDecoration(
                                    labelText: 'First name',
                                    prefixIcon: Icon(Icons.person_rounded),
                                  ),
                                  validator: (input) {
                                    if (input!.isEmpty) return '';
                                  },
                                  onSaved: (input) {
                                    _userData['firstName'] = input;
                                  },
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: FadeTransition(
                                opacity: _animation,
                                child: TextFormField(
                                  textCapitalization: TextCapitalization.words,
                                  initialValue: _index != null
                                      ? data.contacts[_index].lastName
                                      : '',
                                  decoration: const InputDecoration(
                                    labelText: 'Last name',
                                    prefixIcon: Icon(Icons.person_rounded),
                                  ),
                                  validator: (input) {
                                    if (input!.isEmpty) return '';
                                  },
                                  onSaved: (input) {
                                    _userData['lastName'] = input;
                                  },
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: FadeTransition(
                          opacity: _animation,
                          child: TextFormField(
                            keyboardType: TextInputType.phone,
                            initialValue: _index != null
                                ? data.contacts[_index].phone
                                : '',
                            decoration: const InputDecoration(
                              labelText: 'Phone',
                              prefixIcon: Icon(Icons.call_rounded),
                            ),
                            validator: (input) {
                              if (input!.isEmpty) return '';
                            },
                            onSaved: (input) {
                              _userData['phone'] = input;
                            },
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: FadeTransition(
                          opacity: _animation,
                          child: TextFormField(
                            keyboardType: TextInputType.emailAddress,
                            initialValue: _index != null
                                ? data.contacts[_index].email
                                : '',
                            decoration: const InputDecoration(
                              labelText: 'Email',
                              prefixIcon: Icon(Icons.alternate_email_rounded),
                            ),
                            onSaved: (input) {
                              _userData['email'] = input;
                            },
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: FadeTransition(
                          opacity: _animation,
                          child: TextFormField(
                            textCapitalization: TextCapitalization.words,
                            initialValue: _index != null
                                ? data.contacts[_index].gender
                                : '',
                            decoration: const InputDecoration(
                              labelText: 'Gender',
                              prefixIcon: Icon(Icons.people_alt_rounded),
                            ),
                            onSaved: (input) {
                              _userData['gender'] = input;
                            },
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: FadeTransition(
                          opacity: _animation,
                          child: TextFormField(
                            textCapitalization: TextCapitalization.words,
                            initialValue: _index != null
                                ? data.contacts[_index].occupation
                                : '',
                            decoration: const InputDecoration(
                              labelText: 'Occupation',
                              prefixIcon: Icon(Icons.work_rounded),
                            ),
                            validator: (input) {
                              if (input!.isEmpty) return '';
                            },
                            onSaved: (input) {
                              _userData['occupation'] = input;
                            },
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: FadeTransition(
                          opacity: _animation,
                          child: TextFormField(
                            textCapitalization: TextCapitalization.words,
                            initialValue: _index != null
                                ? data.contacts[_index].country
                                : '',
                            decoration: const InputDecoration(
                              labelText: 'Country',
                              prefixIcon: Icon(Icons.location_on_rounded),
                            ),
                            validator: (input) {
                              if (input!.isEmpty) return '';
                            },
                            onSaved: (input) {
                              _userData['country'] = input;
                            },
                          ),
                        ),
                      ),
                      GradientButton(
                        text: _index == null ? 'CREATE' : 'UPDATE',
                        icon: _index == null
                            ? Icons.add_rounded
                            : Icons.update_rounded,
                        onTap: () {
                          _key.currentState!.save();
                          if (_key.currentState!.validate()) {
                            final Contact _contact = Contact(
                              avatar: _avatar!,
                              firstName: _userData['firstName'],
                              lastName: _userData['lastName'],
                              phone: _userData['phone'],
                              email: _userData['email'],
                              gender: _userData['gender'],
                              occupation: _userData['occupation'],
                              country: _userData['country'],
                            );
                            _index != null
                                ? data
                                    .updateContact(
                                        contact: _contact, index: _index)
                                    .then((_) => Navigator.pop(context))
                                : data
                                    .createContact(contact: _contact)
                                    .then((_) => Navigator.pop(context));
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

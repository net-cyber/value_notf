// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:value_notf/add_contact_page.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: const HomePage(),
      routes: {
        '/add-contact-page': (context) => const AddContactPage(),
      },
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Material App Bar'),
      ),
      body: ValueListenableBuilder(
        valueListenable: ContactBook(),
        builder: (context, value, child) {
          final contacts = value;
          return ListView.builder(
            itemCount: value.length,
            itemBuilder: (context, index) {
              final contact = contacts[index];
              return Builder(builder: (context) {
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 50,
                    vertical: 10,
                  ),
                  child: Dismissible(
                    onDismissed: (direction) => ContactBook().remove(contact),
                    key: ValueKey(contact.id),
                    child: Material(
                      elevation: 7,
                      child: ListTile(
                        title: Text(contact.name),
                        subtitle: Column(
                          children: [
                            Text(contact.phoneNo),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(contact.id),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              });
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed('/add-contact-page');
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class Contact {
  final String id;
  final String name;
  final String phoneNo;
  Contact({
    required this.name,
    required this.phoneNo,
  }) : id = const Uuid().v4();
}

class ContactBook extends ValueNotifier<List<Contact>> {
  // ContactBook() : super([Contact(name: 'nati', phoneNo: '89908798')]);
  ContactBook._sharedInstance()
      : super([Contact(name: 'nati', phoneNo: '89908798')]);
  static final _shared = ContactBook._sharedInstance();
  factory ContactBook() => _shared;

  void add(Contact contact) {
    // final x = value;
    // x.add(contact);
    value.add(contact);
    value = [...value];
    // notifyListeners();
  }

  void remove(Contact contact) => value.remove(contact);
}

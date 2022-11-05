import 'package:flutter/material.dart';
import 'package:value_notf/main.dart';

class AddContactPage extends StatefulWidget {
  const AddContactPage({super.key});

  @override
  State<AddContactPage> createState() => _AddContactPageState();
}

class _AddContactPageState extends State<AddContactPage> {
  late final TextEditingController _nameController;
  late final TextEditingController _phoneController;
  @override
  void initState() {
    _nameController = TextEditingController();
    _phoneController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Add new contact'),
        ),
        body: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(hintText: 'Enter new Name'),
            ),
            const SizedBox(
              height: 30,
            ),
            TextField(
              controller: _phoneController,
              decoration: const InputDecoration(hintText: 'Enter new Phone'),
            ),
            TextButton(
                onPressed: () {
                  final contact = Contact(
                      name: _nameController.text,
                      phoneNo: _phoneController.text);
                  ContactBook().add(contact);
                  Navigator.of(context).pop();
                },
                child: const Text('Add Contact'))
          ],
        ));
  }
}

import 'package:anjuman_committee/widget/app_bar/custom_gradient_app_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_contact_picker/flutter_native_contact_picker.dart';
import 'package:flutter_native_contact_picker/model/contact.dart';

class Contacts extends StatefulWidget {
  const Contacts({super.key});

  @override
  State<Contacts> createState() => _ContactsState();
}

class _ContactsState extends State<Contacts> {
  final FlutterNativeContactPicker _contactPicker =
      FlutterNativeContactPicker();
  List<Contact>? _contacts;
  String? _selectedPhoneNumber;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customGradientAppBar(title: 'Fetching Contact from Contact List'),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            MaterialButton(
              color: Colors.blue,
              textColor: Colors.white,
              child: const Text("Select Contact"),
              onPressed: () async {
                Contact? contact = await _contactPicker.selectContact();
                setState(() {
                  _contacts = contact == null ? null : [contact];
                  _selectedPhoneNumber = null;
                });
              },
            ),
            MaterialButton(
              color: Colors.green,
              textColor: Colors.white,
              child: const Text("Select Phone Number"),
              onPressed: () async {
                Contact? contact = await _contactPicker.selectPhoneNumber();
                setState(() {
                  _contacts = contact == null ? null : [contact];
                  _selectedPhoneNumber = contact?.selectedPhoneNumber;
                });
              },
            ),
            if (_contacts != null) ...[
              ..._contacts!.map(
                (contact) => Column(
                  children: [
                    Text(contact.fullName ?? 'No name'),
                    if (_selectedPhoneNumber != null)
                      Text('Selected: $_selectedPhoneNumber'),
                    ...?contact.phoneNumbers?.map((number) => Text(number)),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

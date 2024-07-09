import 'package:contacts_service/contacts_service.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ContactService {
  Future<List<Contact>> getContacts() async {
    Iterable<Contact> contacts = await ContactsService.getContacts();
    return contacts.toList();
  }

  Future<void> sendContactsToApi(List<Contact> contacts) async {
    final response = await http.post(
      Uri.parse('https://yourapi.com/contacts'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(contacts
          .map((contact) => {
                'name': contact.displayName,
                'phone': contact.phones?.isNotEmpty == true
                    ? contact.phones!.first.value
                    : '',
              })
          .toList()),
    );

    if (response.statusCode == 200) {
      // Successfully sent contacts
    } else {
      // Error sending contacts
    }
  }
}

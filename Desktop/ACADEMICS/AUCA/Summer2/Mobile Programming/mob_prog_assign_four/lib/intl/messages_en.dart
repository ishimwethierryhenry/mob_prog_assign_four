import 'package:intl/message_lookup_by_library.dart';

final messages = MessageLookup();

final Map<String, dynamic> _notInlinedMessages(_) => <String, dynamic>{
  'title': 'Flutter Demo Home Page',
  'drawerHeader': 'Drawer Header',
  'editProfilePicture': 'Edit Profile Picture',
  'sendContacts': 'Send Contacts to API',
  'selectFromGallery': 'Select from Gallery',
  'takePicture': 'Take a Picture',
  'language': 'Change Language',
};

class MessageLookup extends MessageLookupByLibrary {
  @override
  final localeName = 'en';

  @override
  final messages = _notInlinedMessages(_);
}

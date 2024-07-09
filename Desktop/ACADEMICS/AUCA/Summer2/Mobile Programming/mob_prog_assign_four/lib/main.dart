import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:image_picker/image_picker.dart';
import 'contact_service.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';
import 'intl/messages_all.dart';

void main() async {
  await initializeMessages('en'); // Initialize messages for default locale 'en'
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Locale _locale = Locale('en', '');

  void changeLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        const _AppLocalizationsDelegate(),
      ],
      supportedLocales: [
        const Locale('en', ''),
        const Locale('es', ''),
      ],
      locale: _locale,
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final ContactService _contactService = ContactService();
  String _selectedLanguage = 'en';
  final ImagePicker _picker = ImagePicker();
  XFile? _image;

  void _fetchAndSendContacts() async {
    List<Contact> contacts = await _contactService.getContacts();
    await _contactService.sendContactsToApi(contacts);
  }

  void _selectFromGallery() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = pickedFile;
    });
  }

  void _takePicture() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);
    setState(() {
      _image = pickedFile;
    });
  }

  void _changeLanguage(String languageCode) {
    Locale newLocale = Locale(languageCode);
    MyAppState state = context
        .findAncestorWidgetOfExactType<MyApp>()
        .createState() as MyAppState;
    state.changeLocale(newLocale);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.title),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text(AppLocalizations.of(context)!.drawerHeader),
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
            ),
            ListTile(
              title: Text(AppLocalizations.of(context)!.editProfilePicture),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => EditProfilePage()),
                );
              },
            ),
            ListTile(
              title: Text(AppLocalizations.of(context)!.language),
              onTap: () {
                _changeLanguage(_selectedLanguage == 'en' ? 'es' : 'en');
                setState(() {
                  _selectedLanguage = _selectedLanguage == 'en' ? 'es' : 'en';
                });
              },
            ),
          ],
        ),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: _fetchAndSendContacts,
          child: Text(AppLocalizations.of(context)!.sendContacts),
        ),
      ),
    );
  }
}

class EditProfilePage extends StatelessWidget {
  final ImagePicker _picker = ImagePicker();
  XFile? _image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.editProfilePicture),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          ElevatedButton(
            onPressed: () async {
              final pickedFile =
                  await _picker.pickImage(source: ImageSource.gallery);
              _image = pickedFile;
            },
            child: Text(AppLocalizations.of(context)!.selectFromGallery),
          ),
          ElevatedButton(
            onPressed: () async {
              final pickedFile =
                  await _picker.pickImage(source: ImageSource.camera);
              _image = pickedFile;
            },
            child: Text(AppLocalizations.of(context)!.takePicture),
          ),
        ],
      ),
    );
  }
}

class AppLocalizations {
  static Future<AppLocalizations> load(Locale locale) {
    final String name = locale.languageCode;
    final String localeName = Intl.canonicalizedLocale(name);

    return initializeMessages(localeName).then((bool _) {
      Intl.defaultLocale = localeName;
      return AppLocalizations();
    });
  }

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  String get title {
    return Intl.message(
      'Flutter Demo Home Page',
      name: 'title',
      desc: 'Title for the Demo application',
    );
  }

  String get drawerHeader {
    return Intl.message(
      'Drawer Header',
      name: 'drawerHeader',
      desc: 'Header text for the drawer',
    );
  }

  String get editProfilePicture {
    return Intl.message(
      'Edit Profile Picture',
      name: 'editProfilePicture',
      desc: 'Edit Profile Picture option in the drawer',
    );
  }

  String get sendContacts {
    return Intl.message(
      'Send Contacts to API',
      name: 'sendContacts',
      desc: 'Button text to send contacts to API',
    );
  }

  String get selectFromGallery {
    return Intl.message(
      'Select from Gallery',
      name: 'selectFromGallery',
      desc: 'Button text to select picture from gallery',
    );
  }

  String get takePicture {
    return Intl.message(
      'Take a Picture',
      name: 'takePicture',
      desc: 'Button text to take a picture',
    );
  }

  String get language {
    return Intl.message(
      'Change Language',
      name: 'language',
      desc: 'Option to change language',
    );
  }
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return ['en', 'es'].contains(locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale locale) {
    return AppLocalizations.load(locale);
  }

  @override
  bool shouldReload(_AppLocalizationsDelegate old) {
    return false;
  }
}

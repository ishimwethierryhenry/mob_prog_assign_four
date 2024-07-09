import 'package:intl/message_lookup_by_library.dart';

final messages = MessageLookup();

final Map<String, dynamic> _notInlinedMessages(_) => <String, dynamic>{
  'title': 'Página de demostración de Flutter',
  'drawerHeader': 'Encabezado del cajón',
  'editProfilePicture': 'Editar foto de perfil',
  'sendContacts': 'Enviar contactos a la API',
  'selectFromGallery': 'Seleccionar de la galería',
  'takePicture': 'Tomar una foto',
  'language': 'Cambiar idioma',
};

class MessageLookup extends MessageLookupByLibrary {
  @override
  final localeName = 'es';

  @override
  final messages = _notInlinedMessages(_);
}

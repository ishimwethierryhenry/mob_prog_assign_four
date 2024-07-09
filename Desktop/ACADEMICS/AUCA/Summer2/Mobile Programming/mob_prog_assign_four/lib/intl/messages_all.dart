import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = {
  'en': () => MessageLookupByLibrary.simpleMessage('Flutter Demo Home Page'),
  'es': () =>
      MessageLookupByLibrary.simpleMessage('Página de demostración de Flutter'),
};

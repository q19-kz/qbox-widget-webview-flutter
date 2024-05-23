
import './user.dart';
import './call.dart';
import './device.dart';


enum Language {
  ru('ru'),
  kk('kk'),
  en('en');
  const Language(this.value);
  final String value;
}

class Settings {
  final String url;
  final Language language;
  final Call? call;
  final User? user;
  final Device? device;
  final bool? mobileRequired;

  const Settings({
    required this.url,
    required this.language,
    this.call,
    this.user,
    this.device,
    this.mobileRequired
  });
}

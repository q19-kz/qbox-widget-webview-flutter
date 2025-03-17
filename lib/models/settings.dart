import './call.dart';
import './user.dart';
// import './device.dart';

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

  // final Device? device;
  final bool loggingEnabled;
  final bool? mobileRequired;

  const Settings({
    required this.url,
    required this.language,
    this.call,
    this.user,
    // this.device,
    this.loggingEnabled = false,
    this.mobileRequired,
  });

  Uri getUri() {
    return Uri.parse(url).replace(queryParameters: getUriParams());
  }

  Map<String, String> getUriParams() {
    var params = {'lang': language.value};
    if (call?.type case var type?) {
      params['call_media'] = type.value;
    }
    if (call?.topic case var topic?) {
      params['topic'] = topic;
    }
    if (mobileRequired == true || url.contains('/widget')) {
      params['is_mobile'] = 'True';
    }
    return params;
  }

  Map<String, dynamic> toJson() =>
      {'user': user?.toJson(), 'call': call?.toJson()};
}

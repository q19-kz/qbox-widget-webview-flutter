
enum CallType {
  video('video'),
  audio('audio');
  const CallType(this.value);
  final String value;
}

class Location {
  final double latitude;
  final double longitude;

  const Location({
    required this.latitude,
    required this.longitude
  });
}

class Call {
  final String domain;
  final String topic;
  final CallType type;
  final Location? location;
  final Map<String, String>? dynamicAttrs;

  const Call({
    required this.domain,
    required this.topic,
    this.type = CallType.video,
    this.location,
    this.dynamicAttrs
  });
}

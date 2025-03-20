enum CallType {
  text('text'),
  audio('audio'),
  video('video');

  const CallType(this.value);

  final String value;
}

class Location {
  final double latitude;
  final double longitude;

  const Location({required this.latitude, required this.longitude});

  Map<String, dynamic> toJson() => {
        'latitude': latitude,
        'longitude': longitude,
      };
}

class Call {
  final String domain;
  final String topic;
  final CallType type;
  final Location? location;
  final int? targetOperatorId;
  final Map<String, dynamic> dynamicAttrs;

  const Call({
    required this.domain,
    required this.topic,
    this.type = CallType.video,
    this.location,
    this.targetOperatorId,
    this.dynamicAttrs = const {},
  });

  Map<String, dynamic> toJson() => {
        'domain': domain,
        'topic': topic,
        'type': type.value,
        'target_operator_id': targetOperatorId,
        'location': location?.toJson(),
      }..addAll(dynamicAttrs);
}

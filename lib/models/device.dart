class Battery {
  final int? batteryLevelPercentage;
  final bool? batteryIsCharging;

  const Battery({this.batteryLevelPercentage, this.batteryIsCharging});
}

class Device {
  final String? systemName;
  final String? systemVersion;
  final String? modelName;
  final String? mobileOperator;
  final String? appVersion;
  final Battery? battery;

  const Device(
      {this.systemName,
      this.systemVersion,
      this.modelName,
      this.mobileOperator,
      this.appVersion,
      this.battery});
}

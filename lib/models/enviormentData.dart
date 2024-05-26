class EnviormentData {
  final int id;
  final double internalTemperature;
  final double externalTemperature;
  final int internalHumidity;
  final int externalHumidity;
  final int windSpeed;

  const EnviormentData({
    required this.id,
    required this.internalTemperature,
    required this.externalTemperature,
    required this.internalHumidity,
    required this.externalHumidity,
    required this.windSpeed,
  });
}

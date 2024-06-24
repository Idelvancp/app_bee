class EnvironmentData {
  final int id;
  final double internalTemperature;
  final double externalTemperature;
  final int internalHumidity;
  final int externalHumidity;
  final int windSpeed;

  const EnvironmentData({
    required this.id,
    required this.internalTemperature,
    required this.externalTemperature,
    required this.internalHumidity,
    required this.externalHumidity,
    required this.windSpeed,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'internal_temperature': internalTemperature,
      'external_temperature': externalTemperature,
      'internal_humidity': internalHumidity,
      'external_humidity': externalHumidity,
      'wind_speed': windSpeed,
    };
  }

  // Converte um Map em um objeto Specie
  factory EnvironmentData.fromMap(Map<String, dynamic> map) {
    return EnvironmentData(
      id: map['id'],
      internalTemperature: map['internal_temperature'],
      externalTemperature: map['external_temperature'],
      internalHumidity: map['internal_umidity'],
      externalHumidity: map['externalHumidity'],
      windSpeed: map['wind_speed'],
    );
  }
}

enum State {
  belowNormal,
  aboveNormal,
  normal,
}

class PopulationData {
  final int? id;
  final int numberBees;
  final double ageQueen;
  final String spawningQueen;
  final String larvaePresenceDistribution;
  final String larvaeHealthDevelopment;
  final String pupaPresenceDistribution;
  final String pupaHealthDevelopment;

  const PopulationData({
    this.id,
    required this.numberBees,
    required this.ageQueen,
    required this.spawningQueen,
    required this.larvaePresenceDistribution,
    required this.larvaeHealthDevelopment,
    required this.pupaPresenceDistribution,
    required this.pupaHealthDevelopment,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'number_bees': numberBees,
      'age_queen': ageQueen,
      'spawning_queen': spawningQueen,
      'larvae_presence_distribution': larvaePresenceDistribution,
      'larvae_health_development': larvaeHealthDevelopment,
      'pupa_presence_distribution': pupaPresenceDistribution,
      'pupa_health_development': pupaHealthDevelopment,
    };
  }

  // Converte um Map em um objeto Specie
  factory PopulationData.fromMap(Map<String, dynamic> map) {
    return PopulationData(
      id: map['id'],
      numberBees: map['number_bees'],
      ageQueen: map['age_queen'],
      spawningQueen: map['spawning_queen'],
      larvaePresenceDistribution: map['larvaePresenceDistribution'],
      larvaeHealthDevelopment: map['larvae_health_development'],
      pupaPresenceDistribution: map['pupa_presence_distribution'],
      pupaHealthDevelopment: map['pupa_health_development'],
    );
  }
}

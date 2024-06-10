enum Biome {
  amazonia,
  caatinga,
  cerrado,
  mataAtlantica,
  pantanal,
  pampa,
}

class Apiary {
  final String id;
  final String name;
  final String state;
  final String city;
  // final String biome;

  const Apiary({
    required this.id,
    required this.name,
    required this.state,
    required this.city,
    //required this.biome,
  });
}

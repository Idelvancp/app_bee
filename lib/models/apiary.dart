enum Biome {
  amazonia,
  caatinga,
  cerrado,
  mataAtlantica,
  pantanal,
  pampa,
}

class Apiary {
  final int id;
  final String name;
  final int cityId;
  final Biome biome;

  const Apiary({
    required this.id,
    required this.name,
    required this.cityId,
    required this.biome,
  });
}

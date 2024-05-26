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
  final int cityId;
  final Biome biome;

  const Apiary({
    required this.id,
    required this.cityId,
    required this.biome,
  });
}

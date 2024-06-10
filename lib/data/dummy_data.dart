import 'package:app_bee/models/floralResources.dart';

import '../models/apiary.dart';
import '../models/hive.dart';
import '../models/cite.dart';
import '../models/typesHive.dart';
import '../models/specie.dart';
import '../models/floralResources.dart';

const DUMMY_CITIES = [
  City(id: 1, name: 'Francinópolis'),
  City(id: 2, name: 'Paulistana'),
  City(id: 3, name: 'Acauã'),
  City(id: 4, name: 'Jacobina'),
];
final DUMMY_APIARIES = [
  Apiary(
    id: "1",
    name: "Apiário Campestre",
    state: "Piauí",
    city: "Paulistana",
    // biome: "caatinga",
  ),
  Apiary(
    id: "2",
    name: "Apiário Cocheirinha",
    state: "Piauí",
    city: "Paulistana",
    // biome: "caatinga",
  ),
  Apiary(
    id: "3",
    name: "Apiário Angical",
    state: "Piauí",
    city: "Francinópolis",
    // biome: "cerrado",
  ),
  Apiary(
    id: "4",
    name: "Apiário Baraunas",
    state: "Piauí",
    city: "Acauã",
    //biome: "caatinga",
  ),
  Apiary(
    id: "5",
    name: "Apiário Recanto",
    state: "Piauí",
    city: "Jacobina",
    // biome: "caatinga",
  ),
];
const DUMMY_FLORAL_RESOURCES = [
  FloralResources(id: 1, name: 'Angico'),
  FloralResources(id: 2, name: 'Mameleiro'),
  FloralResources(id: 3, name: 'Faveira'),
];
const DUMMY_TYPE_HIVES = [
  TypesHive(id: 1, name: 'Langstroth'),
  TypesHive(id: 2, name: 'Top Bar'),
  TypesHive(id: 3, name: 'Warre'),
  TypesHive(id: 4, name: 'Flow Hive'),
  TypesHive(id: 5, name: 'Layens'),
];

const DUMMY_SPECIES = [
  Specie(id: 1, name: 'Jataí'),
  Specie(id: 2, name: 'Uruçu'),
  Specie(id: 3, name: 'Manduri'),
  Specie(id: 4, name: 'Bugia'),
  Specie(id: 5, name: 'Mirim'),
  Specie(id: 6, name: 'Abelha Africana'),
];

const DUMMY_HIVES = [
  Hive(id: 1, typeId: 1, apiaryId: 1, speciesId: 6),
  Hive(id: 2, typeId: 1, apiaryId: 1, speciesId: 6),
  Hive(id: 3, typeId: 1, apiaryId: 1, speciesId: 6),
  Hive(id: 4, typeId: 1, apiaryId: 1, speciesId: 6),
  Hive(id: 5, typeId: 1, apiaryId: 1, speciesId: 6),
  Hive(id: 6, typeId: 1, apiaryId: 1, speciesId: 6),
  Hive(id: 1, typeId: 1, apiaryId: 2, speciesId: 6),
  Hive(id: 2, typeId: 1, apiaryId: 2, speciesId: 6),
  Hive(id: 3, typeId: 1, apiaryId: 2, speciesId: 6),
  Hive(id: 4, typeId: 1, apiaryId: 2, speciesId: 6),
  Hive(id: 6, typeId: 1, apiaryId: 2, speciesId: 6),
  Hive(id: 1, typeId: 1, apiaryId: 3, speciesId: 6),
  Hive(id: 2, typeId: 1, apiaryId: 3, speciesId: 6),
  Hive(id: 3, typeId: 1, apiaryId: 3, speciesId: 6),
  Hive(id: 4, typeId: 1, apiaryId: 3, speciesId: 6),
  Hive(id: 5, typeId: 1, apiaryId: 3, speciesId: 6),
  Hive(id: 6, typeId: 1, apiaryId: 3, speciesId: 6),
  Hive(id: 1, typeId: 1, apiaryId: 4, speciesId: 6),
  Hive(id: 2, typeId: 1, apiaryId: 4, speciesId: 6),
  Hive(id: 3, typeId: 1, apiaryId: 4, speciesId: 6),
  Hive(id: 4, typeId: 1, apiaryId: 5, speciesId: 6),
  Hive(id: 5, typeId: 1, apiaryId: 5, speciesId: 6),
  Hive(id: 6, typeId: 1, apiaryId: 4, speciesId: 6),
];

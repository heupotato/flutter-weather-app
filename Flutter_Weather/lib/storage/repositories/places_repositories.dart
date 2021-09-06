import 'package:flutter_weather/models/place.dart';
import 'package:hive/hive.dart';

class PlacesRepositories{
  static Future<Box<Place>> loadBox() => Hive.openBox<Place>("places");

  static Box<Place> getBox() => Hive.box("places");

  static List<Place> getAllPlaces() => getBox().values.toList();

  static Place? getPlaceInfo(int index) => getBox().getAt(index);

  static void savePlace(Place place)
  => getBox().add(place);

  static void removePlace(int index)
  =>getBox().deleteAt(index);
}
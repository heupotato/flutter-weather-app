import 'package:flutter_weather/models/index.dart';

import 'abstract_local_storage.dart';

class PlaceLocalStorage extends AbstractLocalStorage<Place>{

  PlaceLocalStorage() : super.list(
    fileName: 'places',
    fromJsonList: Place.fromJsonList,
    toJson: (place) => place.toJson()
  );
  
  // PlaceLocalStorage() : super.object(
  //   fileName: 'place',
  //   fromJson: (json) => Place.fromJson(json),
  //   toJson: (place) => place.toJson()
  // );

}
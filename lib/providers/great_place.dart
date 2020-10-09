import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter_chat_app/helpers/db_helper.dart';
import 'package:flutter_chat_app/helpers/location_helper.dart';
import '../models/place.dart';

class GreatPlace with ChangeNotifier {
  List<Place> _items = [];

  List<Place> get items {
    return [..._items];
  }

  Place findById (String id) {
    return _items.firstWhere((element) => element.id == id);
  }

  Future<void> addPlace(
      String pickTitle, File pickImage, PlaceLocation pickLocation) async {
    final address = await LocationHeper.getPlaceAddress(
        pickLocation.latitude, pickLocation.longitude);
    final updateLocation = PlaceLocation(
        latitude: pickLocation.latitude,
        longitude: pickLocation.longitude,
        address: address);
    Place newItem = Place(
      id: DateTime.now().toString(),
      title: pickTitle,
      location: updateLocation,
      image: pickImage,
    );
    _items.add(newItem);
    notifyListeners();
    DBHelper.insert('user_places', {
      'id': newItem.id,
      'title': newItem.title,
      'image': newItem.image,
      'loc_lot': newItem.location.latitude,
      'loc_log': newItem.location.longitude,
      'address': newItem.location.address,
    });
  }

  Future<void> fetchAndSetPlaces() async {
    final dataList = await DBHelper.getData('user_places');
    _items = dataList
        .map(
          (e) => Place(
            id: e['id'],
            title: e['title'],
            location: PlaceLocation(
              latitude: e['loc_lat'],
              longitude: e['loc_log'],
              address: e['address'],
            ),
            image: File(e['image']),
          ),
        )
        .toList();
    notifyListeners();
  }
}

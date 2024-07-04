import 'package:get/get.dart';

import '../model/attraction_model.dart';
import '../model/place_model.dart';
import '../util/auth_utils.dart';

class FavoriteController extends GetxController {
  List _displayList = [];

  List get displayList => _displayList;

  void updateList() {
    List mergedList = [];

    mergedList.addAll(placesList);
    mergedList.addAll(internationalTripList);

    for (var place in placesList) {
      if (place.thingsTodo != null) {
        for (var item in place.thingsTodo!) {
          mergedList.add(item);
        }
      }
      if (place.restaurants != null) {
        for (var item in place.restaurants!) {
          mergedList.add(item);
        }
      }
      if (place.hotels != null) {
        for (var item in place.hotels!) {
          mergedList.add(item);
        }
      }
      if (place.craftstores != null) {
        for (var item in place.craftstores!) {
          mergedList.add(item);
        }
      }
    }

    for (var place in internationalTripList) {
      if (place.thingsTodo != null) {
        for (var item in place.thingsTodo!) {
          mergedList.add(item);
        }
      }
      if (place.restaurants != null) {
        for (var item in place.restaurants!) {
          mergedList.add(item);
        }
      }
      if (place.hotels != null) {
        for (var item in place.hotels!) {
          mergedList.add(item);
        }
      }
      if (place.craftstores != null) {
        for (var item in place.craftstores!) {
          mergedList.add(item);
        }
      }
    }

    _displayList =
        mergedList.where((place) => place.isFavourite == true).toList();

    update();
  }

  Future<void> toggleFavouritePlace(PlaceModel place) async {
    bool isUserAuth = await AuthUtils.redirectTo();
    if (!isUserAuth) return;
    place.isFavourite = !place.isFavourite;
    update();
  }

  Future<void> toggleFavouriteAttraction(Attraction place) async {
    bool isUserAuth = await AuthUtils.redirectTo();
    if (!isUserAuth) return;
    place.isFavourite = !place.isFavourite;
    update();
  }
}

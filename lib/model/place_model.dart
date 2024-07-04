import 'package:catalog_city_project/model/craftstores_model.dart';
import 'package:catalog_city_project/model/hotel_model.dart';
import 'package:catalog_city_project/model/restaurants_model.dart';
import 'package:catalog_city_project/util/asset_image_paths.dart';
import 'dart:convert';
import 'package:get/get.dart';

import 'package:catalog_city_project/model/things_todo.dart';

List<PlaceModel> placeModelFromJson(String str) =>
    List<PlaceModel>.from(json.decode(str).map((x) => PlaceModel.fromJson(x)));

Map placeToJson(PlaceModel place) => place.toJson();

class PlaceModel {
  final int? id;
  final Map<String, dynamic> title;
  final Map<String, dynamic> country;
  final Map<String, dynamic> address;
  final Map<String, dynamic> description;
  final List<String> images;
  final String? video;
  final double latitude;
  final double longitude;
  bool isFavourite;
  final List<ThingsTodo>? thingsTodo;
  final List<Restaurants>? restaurants;
  final List<Hotel>? hotels;
  final List<Craftstores>? craftstores;

  PlaceModel(
      {required this.id,
      required this.title,
      required this.country,
      required this.address,
      required this.description,
      required this.images,
      this.video,
      required this.latitude,
      required this.longitude,
      required this.isFavourite,
      this.thingsTodo,
      this.restaurants,
      this.hotels,
      this.craftstores});

  factory PlaceModel.fromJson(Map<String, dynamic> json) => PlaceModel(
        id: json['id'],
        title: json['title'],
        country: json['country'],
        address: json['address'],
        description: json['description'],
        images: json['images'].isEmpty
            ? [AssetImagePaths.placeHolderFromNetwork]
            : List<String>.from(json['images']),
        video: json['video'] == null ? null : (json['video']),
        latitude: json['coordinates']['lat'] * 1.0,
        longitude: json['coordinates']['lon'] * 1.0,
        isFavourite: json['isFavourite'],
        thingsTodo: json['thingstodo'] == null
            ? null
            : (json['thingstodo'] as List)
                .map((i) => ThingsTodo.fromJson(i))
                .toList(),
        restaurants: json['restaurants'] == null
            ? null
            : (json['restaurants'] as List)
                .map((i) => Restaurants.fromJson(i))
                .toList(),
        hotels: json['hotels'] == null
            ? null
            : (json['hotels'] as List).map((i) => Hotel.fromJson(i)).toList(),
        craftstores: json['craftstores'] == null
            ? null
            : (json['craftstores'] as List)
                .map((i) => Craftstores.fromJson(i))
                .toList(),
      );

  Map<String, dynamic> toJsonTest() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id.toString();
    data['title'] = title;
    data['country'] = country;
    data['description'] = description;
    data['address'] = address;
    data['isFavourite'] = isFavourite;
    data['images'] = images;
    data['coordinates'] = {
      "lat": latitude,
      "lon": longitude,
    };
    data["status"] = "ACTIVE";
    data["searchkey"] = ["country", "City", "category"];

    return data;
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'country': country,
        'description': description,
        'address': address,
        'isFavourite': isFavourite,
        'images': images,
        'coordinates': {
          "lat": latitude,
          "lon": longitude,
        },
        "status": "ACTIVE",
        "searchkey": ["country", "City", "category"],
      };
}

RxList<PlaceModel> placesList = RxList<PlaceModel>([]);
RxList<PlaceModel> internationalTripList = RxList<PlaceModel>([]);

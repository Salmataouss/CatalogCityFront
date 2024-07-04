import 'package:catalog_city_project/model/attraction_model.dart';

class ThingsTodo extends Attraction {
  ThingsTodo({
    id,
    title,
    country,
    address,
    description,
    images,
    video,
    latitude,
    longitude,
    isFavourite,
  }) : super(
          id: id,
          title: title,
          country: country,
          address: address,
          description: description,
          images: images,
          video: video,
          latitude: latitude,
          longitude: longitude,
          isFavourite: isFavourite,
        );

  factory ThingsTodo.fromJson(Map<String, dynamic> json) => ThingsTodo(
        id: json['id'],
        title: json['title'],
        country: json['country'],
        address: json['address'],
        description: json['description'],
        images: List<String>.from(json['images']),
        video: json['video'] == null ? null : (json['video']),
        latitude: json['coordinates']['lat'],
        longitude: json['coordinates']['lon'],
        isFavourite: json['isFavourite'],
      );
}

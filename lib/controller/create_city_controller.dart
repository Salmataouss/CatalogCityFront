import 'dart:io';

import 'package:catalog_city_project/model/place_model.dart';
import 'package:cloudinary/cloudinary.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../services/api.dart';
import '../util/string_config.dart';
import '../view/common/app_snakbar.dart';

class CreateCityController extends GetxController {
  File? image;
  String? imageUrl;
  List<String> imageUrlList = [];
  final ImagePicker imagePicker = ImagePicker();
  final cloudinary = Cloudinary.unsignedConfig(
    cloudName: 'dnoux1v8i',
  );

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController countryNameCtr = TextEditingController();
  final TextEditingController cityNameCtr = TextEditingController();
  final TextEditingController cityDescCtr = TextEditingController();
  final TextEditingController cityAddresseCtr = TextEditingController();
  final TextEditingController latCtr = TextEditingController();
  final TextEditingController logCtr = TextEditingController();

  bool isLoading = false;
  RxBool isSubmited = false.obs;

  Future<void> uploadImage() async {
    XFile? pickedImage =
        await imagePicker.pickImage(source: ImageSource.gallery);
    isLoading = true;
    update();

    if (pickedImage != null) {
      image = File(pickedImage.path);
      imageUrl = await getImageUrlFromCloudinary();
      if (imageUrl != null) {
        addImage(imageUrl!);
      }
    }
    isLoading = false;
    update();
  }

  void addImage(String imageUrl) {
    imageUrlList.add(imageUrl);
  }

  Future getImageUrlFromCloudinary() async {
    final response = await cloudinary.unsignedUpload(
        file: image?.path,
        uploadPreset: 'o7kuna4x',
        fileBytes: image?.readAsBytesSync(),
        resourceType: CloudinaryResourceType.image,
        progressCallback: (count, total) {
          debugPrint('Uploading image from file with progress: $count/$total');
        });

    if (response.isSuccessful) {
      debugPrint('Get your image from with ${response.secureUrl}');
      return response.secureUrl;
    }
  }

  String? validator(value) {
    if (value!.isEmpty) {
      return "\u24D8 ${StringConfig.thisFieldIsRequired}";
    }
    return null;
  }

  String? validateNumber(value) {
    if (value!.isEmpty) {
      return "\u24D8 ${StringConfig.thisFieldIsRequired}";
    } else if (!isNumeric(value)) {
      return "\u24D8 Should be a number";
    }
    return null;
  }

  bool isNumeric(String? s) {
    if (s == null) {
      return false;
    }
    return double.tryParse(s) != null;
  }

  void onSubmit() async {
    if (formKey.currentState!.validate()) {
      try {
        isSubmited(true);
        update();
        PlaceModel city = PlaceModel(
          id: 99,
          title: {
            'en': cityNameCtr.text,
            'arSA': cityNameCtr.text,
            'fr': cityNameCtr.text,
          },
          country: {
            'en': countryNameCtr.text,
            'arSA': countryNameCtr.text,
            'fr': countryNameCtr.text,
          },
          address: {
            'en': cityAddresseCtr.text,
            'arSA': cityAddresseCtr.text,
            'fr': cityAddresseCtr.text,
          },
          description: {
            'en': cityDescCtr.text,
            'arSA': cityDescCtr.text,
            'fr': cityDescCtr.text,
          },
          images: imageUrlList,
          latitude: double.parse(latCtr.text),
          longitude: double.parse(logCtr.text),
          isFavourite: false,
        );

        await Api.createNewCity(city);

        AppSnakBar.showSuccess(
            title: 'Success',
            message: 'City ${cityNameCtr.text} saved successfully');
      } catch (e) {
        AppSnakBar.showError(title: 'Error', message: e.toString());
      } finally {
        clearAllField();
        isSubmited(false);
      }
    }
  }

  void clearAllField() {
    formKey.currentState!.reset();
  }
}

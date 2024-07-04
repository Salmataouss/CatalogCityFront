import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';

// VIEWS IMPORTS
// CONTROLLERS IMPORTS
import 'package:catalog_city_project/controller/home_controller.dart';
import '../../../controller/language_controller.dart';

// MODELS IMPORTS
import 'package:catalog_city_project/model/category_model.dart';

// UTILS IMPORTS
import 'package:catalog_city_project/util/asset_image_paths.dart';
import 'package:catalog_city_project/util/colors.dart';
import 'package:catalog_city_project/util/font_family.dart';
import 'package:catalog_city_project/util/size_config.dart';

class CategoryCard extends StatelessWidget {
  const CategoryCard({
    super.key,
    required this.index,
  });

  final int index;

  @override
  Widget build(BuildContext context) {
    // DEPENDECIES INJECTION
    final HomeController homeController = Get.find();
    final LanguageController languageController = Get.find();

    CategoryModel category = homeController.categoriesList[index];

    return GestureDetector(
      // DEPENDECIES INJECTION
      onTap: () => homeController.updateSelectedActivity(index),
      child: Obx(
        () => Container(
          height: SizeFile.height36,
          alignment: Alignment.center,
          margin: const EdgeInsets.only(
            right: SizeFile.height16,
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: SizeFile.height8,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(SizeFile.height8),
            border: Border.all(
              width: 1,
              color: homeController.selectedActivity.value == index
                  ? ColorFile.whiteColor
                  : ColorFile.borderColor,
            ),
            color: homeController.selectedActivity.value == index
                ? ColorFile.appColor
                : ColorFile.whiteColor,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(
                  SizeFile.height4,
                ),
                child: CachedNetworkImage(
                  height: SizeFile.height20,
                  width: SizeFile.height20,
                  fit: BoxFit.cover,
                  imageUrl: category.media,
                  placeholder: (context, url) => Image.asset(
                    AssetImagePaths.placeholder,
                    height: SizeFile.height20,
                    width: SizeFile.height20,
                    fit: BoxFit.cover,
                  ),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
              const SizedBox(width: SizeFile.height8),
              Text(
                category.name[languageController.language.value] ??
                    category.name['en'],
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: SizeFile.height14,
                  color: homeController.selectedActivity.value == index
                      ? ColorFile.whiteColor
                      : ColorFile.onBordingColor,
                  fontFamily: satoshiRegular,
                  fontWeight: FontWeight.w500,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

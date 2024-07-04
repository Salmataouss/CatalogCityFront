import 'package:catalog_city_project/controller/video_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// VIEWS IMPORTS
import 'package:catalog_city_project/view/home_screen/widgets/category_card.dart';
import '../international_trip/international_trip_screen.dart';
import '../popular_place_package/popular_place_package_screen.dart';
import '../popular_places/popular_places_screen.dart';
import 'search_screen.dart';
import 'widgets/category_shimmer.dart';
import 'widgets/place_card.dart';
import 'widgets/placecard_shimmer.dart';

// CONTROLLERS IMPORTS
import '../../controller/home_controller.dart';
import '../../controller/language_controller.dart';

// MODELS IMPORTS
import '../../model/place_model.dart';
import '../../model/test_model.dart';

// UTILS IMPORTS
import '../../util/asset_image_paths.dart';
import '../../util/colors.dart';
import '../../util/font_family.dart';
import '../../util/size_config.dart';
import '../../util/string_config.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // DEPENDECIES INJECTION
    final HomeController homeController = Get.put(HomeController());
    final LanguageController _ = Get.put(LanguageController());
    Get.create(() => VideoController());

    return Scaffold(
      backgroundColor: ColorFile.whiteColor,
      body: RefreshIndicator(
        onRefresh: () async => homeController.fetchAll(),
        child: SingleChildScrollView(
          child: Column(children: [
            const SizedBox(height: SizeFile.height10),

            // ---- --------- ----- SEARCH FIELD: ---- --------- -----
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: SizeFile.height20,
                vertical: 0,
              ),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Get.to(() => const SearchScreen());
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width / 1.33,
                      height: SizeFile.height38,
                      padding: const EdgeInsets.symmetric(
                        horizontal: SizeFile.height10,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(SizeFile.height10),
                        border: Border.all(
                          width: SizeFile.height1,
                          color: ColorFile.borderColor,
                        ),
                        color: ColorFile.whiteColor,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Image.asset(
                            AssetImagePaths.searchIcon,
                            height: SizeFile.height14,
                            width: SizeFile.height14,
                            color: ColorFile.onBording2Color,
                          ),
                          const SizedBox(width: SizeFile.height10),
                          Text(
                            StringConfig.searchPlaces.tr,
                            style: TextStyle(
                              color: ColorFile.onBording2Color,
                              fontFamily: satoshiRegular,
                              fontWeight: FontWeight.w400,
                              fontSize: SizeFile.height13,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: (() {
                      debugPrint('[INFO] voice icon clicked');
                    }),
                    child: Container(
                      width: SizeFile.height42,
                      height: SizeFile.height38,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(SizeFile.height10),
                          border: Border.all(
                            width: 1,
                            color: ColorFile.borderColor,
                          ),
                          color: ColorFile.whiteColor),
                      child: Image.asset(
                        AssetImagePaths.voiceIcon,
                        color: ColorFile.blackColor,
                        height: SizeFile.height18,
                        width: SizeFile.height18,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: SizeFile.height20),

            // ---- --------- ----- ACTIVITIES LISTE: ---- --------- -----
            SizedBox(
              height: SizeFile.height36,
              child: Column(
                children: [
                  Obx(
                    () => SizedBox(
                      height: SizeFile.height36,
                      child: ListView.separated(
                        padding: const EdgeInsets.only(
                          left: SizeFile.height20,
                        ),
                        scrollDirection: Axis.horizontal,
                        separatorBuilder: (context, index) => Divider(),
                        itemCount: homeController.isLoading.value
                            ? 5
                            : homeController.categoriesList.length,
                        itemBuilder: (_, index) {
                          if (homeController.isLoading.value) {
                            // LOADING SHIMMER
                            return CategoryShimmer();
                          } else {
                            return CategoryCard(index: index);
                          }
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: SizeFile.height24),

            // ---- --------- ----- CITIES LIST : ---- --------- -----
            SizedBox(
              height: SizeFile.height190,
              child: Obx(
                () => ListView.builder(
                  padding: const EdgeInsets.only(left: SizeFile.height20),
                  scrollDirection: Axis.horizontal,
                  itemCount:
                      homeController.isLoading.value ? 4 : placesList.length,
                  shrinkWrap: false,
                  itemBuilder: (_, index) {
                    if (homeController.isLoading.value) {
                      // LOAD CITIES SHIMMER
                      return PlaceCardShimmer();
                    } else {
                      return PlaceCard(placeDetails: placesList[index]);
                    }
                  },
                ),
              ),
            ),
            const SizedBox(height: SizeFile.height24),

            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: SizeFile.height20,
                vertical: 0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(StringConfig.internationalTrip.tr,
                      style: TextStyle(
                          color: ColorFile.onBordingColor,
                          fontFamily: satoshiBold,
                          fontWeight: FontWeight.w400,
                          fontSize: SizeFile.height16)),
                  GestureDetector(
                    onTap: () {
                      Get.to(const InterNationalTripScreen());
                    },
                    child: Text(
                      StringConfig.seeMore.tr,
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                        decorationColor: ColorFile.appColor,
                        color: ColorFile.appColor,
                        fontFamily: satoshiBold,
                        fontWeight: FontWeight.w400,
                        fontSize: SizeFile.height12,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: SizeFile.height16),

            // ---- --------- ----- INTERNATIONAL TRIP LIST : ---- --------- -----
            SizedBox(
              height: SizeFile.height190,
              child: Obx(
                () => ListView.builder(
                  padding: const EdgeInsets.only(left: SizeFile.height20),
                  scrollDirection: Axis.horizontal,
                  itemCount: homeController.isLoading.value
                      ? 5
                      : internationalTripList.length,
                  shrinkWrap: false,
                  itemBuilder: (_, index) {
                    if (homeController.isLoading.value) {
                      // LOAD SHIMMER
                      return PlaceCardShimmer();
                    } else {
                      return PlaceCard(
                        placeDetails: internationalTripList[index],
                      );
                    }
                  },
                ),
              ),
            ),
            const SizedBox(height: SizeFile.height24),

            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: SizeFile.height20,
                vertical: 0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    StringConfig.popularPlaces.tr,
                    style: TextStyle(
                      color: ColorFile.onBordingColor,
                      fontFamily: satoshiBold,
                      fontWeight: FontWeight.w400,
                      fontSize: SizeFile.height16,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.to(PopularPlacesScreen());
                    },
                    child: Text(
                      StringConfig.seeMore.tr,
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                        decorationColor: ColorFile.appColor,
                        color: ColorFile.appColor,
                        fontFamily: satoshiBold,
                        fontWeight: FontWeight.w400,
                        fontSize: SizeFile.height12,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: SizeFile.height10),

            // ---- --------- ----- POPULAR PLACES LIST : ---- --------- -----
            SizedBox(
              height: MediaQuery.of(context).size.height / 4.7,
              child: ListView.builder(
                padding: const EdgeInsets.only(left: SizeFile.height20),
                scrollDirection: Axis.horizontal,
                itemCount: homeController.popularPlacesList.length,
                shrinkWrap: false,
                itemBuilder: (_, index) {
                  PlaceModelTest place =
                      homeController.popularPlacesList[index];
                  return GestureDetector(
                    onTap: () {
                      Get.to(const PopularPlacePackageScreen());
                    },
                    child: Stack(alignment: Alignment.topRight, children: [
                      Padding(
                        padding:
                            const EdgeInsets.only(right: SizeFile.height20),
                        child: Image.asset(
                          place.icon!,
                          height: SizeFile.height172,
                          width: SizeFile.height148,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            right: SizeFile.height28, top: SizeFile.height12),
                        child: Obx(
                          () => GestureDetector(
                            onTap: () {
                              homeController.selectPopularItems[index] =
                                  !homeController.selectPopularItems[index];
                            },
                            child: Image.asset(
                              homeController.selectPopularItems[index]
                                  ? AssetImagePaths.redHeard
                                  : AssetImagePaths.heartCircle,
                              height: SizeFile.height18,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: MediaQuery.of(context).size.height / 30,
                        left: SizeFile.height5,
                        child: Padding(
                          padding:
                              const EdgeInsets.only(left: SizeFile.height10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(place.text!,
                                  style: const TextStyle(
                                      color: ColorFile.whiteColor,
                                      fontFamily: satoshiMedium,
                                      fontWeight: FontWeight.w500,
                                      fontSize: SizeFile.height14)),
                              const Text(StringConfig.loremIpsumDolorSitAmet,
                                  style: TextStyle(
                                      color: ColorFile.whiteColor,
                                      fontFamily: satoshiLight,
                                      fontWeight: FontWeight.w300,
                                      fontSize: SizeFile.height10)),
                              const SizedBox(height: SizeFile.height6),
                              Row(
                                children: [
                                  Image.asset(
                                    AssetImagePaths.starYellow,
                                    height: SizeFile.height9,
                                    width: SizeFile.height9,
                                  ),
                                  const SizedBox(width: SizeFile.height4),
                                  Image.asset(
                                    AssetImagePaths.starYellow,
                                    height: SizeFile.height9,
                                  ),
                                  const SizedBox(width: SizeFile.height4),
                                  Image.asset(
                                    AssetImagePaths.starYellow,
                                    height: SizeFile.height9,
                                  ),
                                  const SizedBox(width: SizeFile.height4),
                                  Image.asset(
                                    AssetImagePaths.starYellow,
                                    height: SizeFile.height9,
                                  ),
                                  const SizedBox(width: SizeFile.height4),
                                  Image.asset(
                                    AssetImagePaths.starYellow,
                                    height: SizeFile.height9,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ]),
                  );
                },
              ),
            ),
            const SizedBox(height: SizeFile.height15),
          ]),
        ),
      ),
    );
  }
}

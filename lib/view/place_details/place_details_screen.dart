import 'package:catalog_city_project/controller/share_controller.dart';
import 'package:catalog_city_project/view/common/loading_icon_button.dart';
import 'package:catalog_city_project/view/widgets/media_displayer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:map_launcher/map_launcher.dart';
import 'package:readmore/readmore.dart';

// VIEWS IMPORTS
import 'package:catalog_city_project/view/attractions/attraction_list.dart';
import 'package:catalog_city_project/view/home_screen/widgets/attraction_card.dart';
import 'package:catalog_city_project/view/popular_place_package/popular_place_package_screen.dart';
import '../../controller/language_controller.dart';

// MODELS IMPORTS
import 'package:catalog_city_project/model/attraction_model.dart';
import 'package:catalog_city_project/model/place_model.dart';

// CONTROLLER IMPORTS
import 'package:catalog_city_project/controller/favorite_controller.dart';
import 'package:catalog_city_project/controller/video_controller.dart';
import '../../controller/place_details_controller.dart';
import '../../controller/home_controller.dart';

// UTILS IMPORTS
import 'package:catalog_city_project/util/asset_image_paths.dart';
import 'package:catalog_city_project/util/colors.dart';
import 'package:catalog_city_project/util/size_config.dart';
import 'package:catalog_city_project/util/string_config.dart';
import '../../util/auth_utils.dart';
import '../../util/font_family.dart';

var width = Get.width;
var height = Get.height;

class PlaceDetailsScreen1 extends StatefulWidget {
  final PlaceModel placeDetails;
  const PlaceDetailsScreen1({Key? key, required this.placeDetails})
      : super(key: key);

  @override
  State<PlaceDetailsScreen1> createState() => _PlaceDetailsScreen1State();
}

class _PlaceDetailsScreen1State extends State<PlaceDetailsScreen1> {
  // DEPENDECIES INJECTION
  PlaceDetailsController placeDetailsController =
      Get.put(PlaceDetailsController());
  ShareController shareController = Get.put(ShareController());
  VideoController videoController =
      Get.put(VideoController(), tag: "controller1");

  FavoriteController favoriteController = Get.find();
  LanguageController languageController = Get.find();
  HomeController homeController = Get.find();

  @override
  void initState() {
    // videoController = Get.put(VideoController(), tag: "controller1");
    // videoController = Get.put(placeDetailsController.vdCtr);

    placeDetailsController.setImages(widget.placeDetails);

    if (widget.placeDetails.video != null) {
      videoController.initVideoController(widget.placeDetails.video!);
      super.initState();
    }
  }

  @override
  void dispose() {
    videoController.videoPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: ColorFile.whiteColor,
          body: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  alignment: Alignment.topRight,
                  children: [
                    GetBuilder<PlaceDetailsController>(
                      builder: (c) => SizedBox(
                        height: 500,
                        child: MediaDisplayer(
                          mediaPath: c.mediaList[c.selectedImage],
                          tag: "controller1",
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: SizeFile.height20,
                          right: SizeFile.height20,
                          top: SizeFile.height20,
                          bottom: SizeFile.height30),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            onPressed: () {
                              Get.back();
                              // videoController.stopVideo();
                            },
                            icon: Image.asset(
                              AssetImagePaths.backArrow2,
                              height: SizeFile.height18,
                              width: SizeFile.height18,
                              color: ColorFile.whiteColor,
                            ),
                          ),
                          Obx(
                            () => LoadingIconButton(
                              iconPath: AssetImagePaths.circleShareIcon,
                              onPressed: () => shareController.sharePlace(
                                widget.placeDetails.images[0],
                                widget.placeDetails.title[
                                        languageController.language.value] ??
                                    widget.placeDetails.title['en'],
                              ),
                              isLoading: shareController.isLoading.value,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: SizeFile.height200),
                        ListView.builder(
                            itemCount: placeDetailsController.mediaList.length,
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            scrollDirection: Axis.vertical,
                            itemBuilder: (BuildContext context, int index) {
                              return GetBuilder<PlaceDetailsController>(
                                builder: (c) => Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: c.selectedImage == index
                                        ? SizeFile.height20
                                        : SizeFile.height26,
                                  ),
                                  child: Align(
                                    alignment: Alignment.topLeft,
                                    child: GestureDetector(
                                      onTap: () {
                                        c.updateSelectedImage(index);
                                        videoController.videoPlayerController
                                            .pause();
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                          bottom: SizeFile.height7,
                                        ),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                              color: Colors.white,
                                              width: 1.5,
                                            ),
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(SizeFile.height6),
                                            ),
                                          ),
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(SizeFile.height6),
                                            ),
                                            child: CachedNetworkImage(
                                              fit: BoxFit.cover,
                                              imageUrl: c.mediaList[index]
                                                      .endsWith('.mp4')
                                                  ? AssetImagePaths.playbutton
                                                  : c.mediaList[index],
                                              width: c.selectedImage == index
                                                  ? SizeFile.height60
                                                  : SizeFile.height40,
                                              height: c.selectedImage == index
                                                  ? SizeFile.height45
                                                  : SizeFile.height30,
                                              placeholder: (context, url) =>
                                                  Image.asset(
                                                AssetImagePaths.placeholder,
                                                fit: BoxFit.scaleDown,
                                              ),
                                              errorWidget:
                                                  (context, url, error) =>
                                                      Icon(Icons.error),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }),
                      ],
                    )
                  ],
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: SizeFile.height20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: SizeFile.height16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                              widget.placeDetails.title[
                                      languageController.language.value] ??
                                  widget.placeDetails.title['en'],
                              style: TextStyle(
                                  color: ColorFile.onBordingColor,
                                  fontFamily: satoshiMedium,
                                  fontWeight: FontWeight.w500,
                                  fontSize: SizeFile.height26)),
                          GetBuilder<FavoriteController>(
                            builder: (controller) {
                              return GestureDetector(
                                onTap: () async {
                                  await favoriteController.toggleFavouritePlace(
                                      widget.placeDetails);
                                  favoriteController.updateList();
                                },
                                child: Image.asset(
                                  widget.placeDetails.isFavourite
                                      ? AssetImagePaths.redHeard
                                      : AssetImagePaths.heartCircle,
                                  height: SizeFile.height26,
                                  width: SizeFile.height26,
                                ),
                              );
                            },
                          )
                        ],
                      ),
                      const SizedBox(height: SizeFile.height16),
                      ReadMoreText(
                        widget.placeDetails.description[
                                languageController.language.value] ??
                            widget.placeDetails.description['en'],
                        trimLines: 2,
                        colorClickableText: Colors.pink,
                        trimMode: TrimMode.Line,
                        trimCollapsedText: StringConfig.showMore.tr,
                        trimExpandedText: StringConfig.showLess.tr,
                        style: TextStyle(
                            color: ColorFile.onBordingColor,
                            fontFamily: satoshiRegular,
                            fontWeight: FontWeight.w500,
                            fontSize: SizeFile.height13),
                        moreStyle: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: SizeFile.height16),
                      Container(
                          width: Get.width,
                          padding: EdgeInsets.all(SizeFile.height8),
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.circular(SizeFile.height6),
                              color: ColorFile.whiteColor,
                              boxShadow: const [
                                BoxShadow(
                                    offset: Offset(0, 0),
                                    blurStyle: BlurStyle.outer,
                                    blurRadius: SizeFile.height2,
                                    spreadRadius: SizeFile.height2,
                                    color: ColorFile.appSubText)
                              ]),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Image.asset(
                                        AssetImagePaths.mapImage,
                                        height: SizeFile.height56,
                                        width: SizeFile.height56,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            right: SizeFile.height8,
                                            left: SizeFile.height8),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                                widget.placeDetails.address[
                                                        languageController
                                                            .language.value] ??
                                                    widget.placeDetails
                                                        .address['en'],
                                                style: TextStyle(
                                                    color: ColorFile
                                                        .onBording2Color,
                                                    fontFamily: satoshiRegular,
                                                    fontWeight: FontWeight.w400,
                                                    fontSize:
                                                        SizeFile.height14)),
                                            GestureDetector(
                                              onTap: () async {
                                                bool isUserAuth =
                                                    await AuthUtils
                                                        .redirectTo();
                                                if (!isUserAuth) return;
                                                final availableMaps =
                                                    await MapLauncher
                                                        .installedMaps;
                                                availableMaps[0].showMarker(
                                                  coords: Coords(
                                                    widget
                                                        .placeDetails.latitude,
                                                    widget
                                                        .placeDetails.longitude,
                                                  ),
                                                  title: StringConfig.google,
                                                  description:
                                                      StringConfig.googlePlex,
                                                );
                                              },
                                              child: Text(
                                                  StringConfig.viewOnMap.tr,
                                                  style: TextStyle(
                                                      color: ColorFile.appColor,
                                                      decoration: TextDecoration
                                                          .underline,
                                                      fontFamily: satoshiBold,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      fontSize:
                                                          SizeFile.height13)),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          )),
                      const SizedBox(height: SizeFile.height22),
                      const SizedBox(height: SizeFile.height10),
                    ],
                  ),
                ),
                _buildAttraction(
                    widget.placeDetails,
                    homeController.selectedActivity.value,
                    videoController,
                    languageController)
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget _buildAttraction(PlaceModel place, int i,
    VideoController videoController, LanguageController languageController) {
  List<Attraction>? data;

  String categoryName = homeController
          .categoriesList[i].name[languageController.language.value] ??
      homeController.categoriesList[i].name['en'];
  switch (i) {
    case 0:
      data = place.restaurants;
      break;
    case 1:
      data = place.craftstores;
      break;
    case 2:
      data = place.hotels;
      break;
    case 3:
      data = place.thingsTodo;
      break;
  }

  if (data == null || data.isEmpty) {
    return SizedBox();
  } else {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: SizeFile.height20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                categoryName,
                style: TextStyle(
                  color: ColorFile.onBordingColor,
                  fontFamily: satoshiBold,
                  fontWeight: FontWeight.w400,
                  fontSize: SizeFile.height16,
                ),
              ),
              GestureDetector(
                onTap: () {
                  Get.to(() => AttractionList(attraction: data!));
                  videoController.stopVideo();
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
        SizedBox(
          height: Get.height / 4.7,
          child: ListView.builder(
            padding: const EdgeInsets.only(
                top: SizeFile.height10, left: SizeFile.height20),
            scrollDirection: Axis.horizontal,
            itemCount: data.length,
            shrinkWrap: false,
            itemBuilder: (BuildContext context, int index) {
              return AttractionCard(attraction: data![index]);
            },
          ),
        ),
      ],
    );
  }
}

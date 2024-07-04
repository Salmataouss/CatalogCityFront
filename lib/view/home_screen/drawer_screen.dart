import 'package:catalog_city_project/controller/storage_controller.dart';
import 'package:catalog_city_project/model/person_details.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:catalog_city_project/view/upcoming_trip/upcoming_trip_screen.dart';
import 'package:catalog_city_project/controller/drawer_controller.dart';
import 'package:catalog_city_project/util/colors.dart';
import 'package:catalog_city_project/util/font_family.dart';
import 'package:catalog_city_project/util/size_config.dart';
import '../../controller/login_controller.dart';
import '../../util/asset_image_paths.dart';
import '../../util/auth_utils.dart';
import '../../util/string_config.dart';
import '../login_screem/login_screen.dart';
import '../login_screem/my_booking_screen/my_booking_screen.dart';
import '../my_favorite_screen/my_favorite_screen.dart';
import '../my_reviews_screen/my_reviews_screen.dart';
import '../offers_screen/offers_screen.dart';
import '../settings_screen/settings_screen.dart';
import 'home_screen.dart';

class DrawerScreen extends StatefulWidget {
  const DrawerScreen({Key? key}) : super(key: key);

  @override
  State<DrawerScreen> createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  @override
  void initState() {
    super.initState();
    getUserCredential();
  }

  PersonDetails user = PersonDetails(email: '');
  Future getUserCredential() async {
    user = await AuthUtils.getConnectedUser();
    setState(() {});
  }

  List<Map<String, dynamic>> drawerList = [
    {"title": StringConfig.home.tr, "Icon": AssetImagePaths.homeIcon},
    {"title": StringConfig.myTrip.tr, "Icon": AssetImagePaths.myTripIcon2},
    {"title": StringConfig.myBooking.tr, "Icon": AssetImagePaths.myBookingIcon},
    {"title": StringConfig.myReviews.tr, "Icon": AssetImagePaths.myReviewsIcon},
    {
      "title": StringConfig.myFavorite.tr,
      "Icon": AssetImagePaths.myFavoriteHeartIcon
    },
    {"title": StringConfig.offers.tr, "Icon": AssetImagePaths.offersIcon},
    {"title": StringConfig.settings.tr, "Icon": AssetImagePaths.settingsIcon},
  ];

  final drawerListController = Get.put(DrawerListController());

  final GlobalKey _globalKey = GlobalKey();

  final loginController = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
          horizontal: SizeFile.height20, vertical: SizeFile.height20),
      width: SizeFile.height250,
      height: double.infinity,
      decoration: const BoxDecoration(
        color: ColorFile.whiteColor,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(height: SizeFile.height40),
          user.email.isEmpty
              ? const SizedBox()
              : Padding(
                  padding: const EdgeInsets.only(right: SizeFile.height08),
                  child: Row(
                    children: [
                      Image.network(
                        user.imageUrl ?? AssetImagePaths.noProfilePic,
                        height: SizeFile.height70,
                        width: SizeFile.height70,
                      ),
                      const SizedBox(width: 10),
                      SizedBox(
                        width: 120,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              user.name!,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              user.email,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
          const SizedBox(height: SizeFile.height30),
          ...List.generate(
              drawerList.length,
              (index) => GestureDetector(
                    onTap: () {
                      drawerListController.selectedDrawer.value = index;
                      drawerListController.selectedDrawer.value == 0
                          ? Get.to(() => const HomeScreen())
                          : drawerListController.selectedDrawer.value == 1
                              ? Get.to(
                                  () => UpcomingTripScreen(isAppbar: false))
                              : drawerListController.selectedDrawer.value == 2
                                  ? Get.to(() => const MyBookingScreen())
                                  : drawerListController.selectedDrawer.value ==
                                          3
                                      ? Get.to(() => MyReviewsScreen())
                                      : drawerListController
                                                  .selectedDrawer.value ==
                                              4
                                          ? Get.to(() => MyFavoriteScreen())
                                          : drawerListController
                                                      .selectedDrawer.value ==
                                                  5
                                              ? Get.to(
                                                  () => const OffersScreen())
                                              : Get.to(() => SettingScreen());
                    },
                    child: Obx(
                      () => Container(
                        height: SizeFile.height40,
                        margin:
                            const EdgeInsets.only(bottom: SizeFile.height10),
                        padding: const EdgeInsets.symmetric(
                            horizontal: SizeFile.height10),
                        decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(SizeFile.height5),
                            color: drawerListController.selectedDrawer.value ==
                                    index
                                ? ColorFile.appColor
                                : ColorFile.whiteColor),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Image.asset(drawerList[index]["Icon"].toString(),
                                color:
                                    drawerListController.selectedDrawer.value ==
                                            index
                                        ? ColorFile.whiteColor
                                        : ColorFile.onBordingColor,
                                height: SizeFile.height20),
                            const SizedBox(width: SizeFile.height18),
                            Text(
                              drawerList[index]["title"].toString(),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: SizeFile.height18,
                                  color: drawerListController
                                              .selectedDrawer.value ==
                                          index
                                      ? ColorFile.whiteColor
                                      : ColorFile.onBordingColor,
                                  fontFamily: satoshiRegular,
                                  fontWeight: FontWeight.w500),
                            )
                          ],
                        ),
                      ),
                    ),
                  )),
          user.email.isEmpty
              ? const SizedBox()
              : Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: SizeFile.height20),
                    child: GestureDetector(
                      key: _globalKey,
                      onTap: () {
                        Get.back();
                        showDialog(
                          barrierDismissible: false,
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Center(
                                child: Text(
                                  StringConfig.logOut,
                                  style: TextStyle(
                                    color: ColorFile.logOutColor,
                                    fontFamily: satoshiBold,
                                    fontWeight: FontWeight.w700,
                                    fontSize: SizeFile.height18,
                                  ),
                                ),
                              ),
                              actions: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: SizeFile.height16,
                                      right: SizeFile.height16,
                                      bottom: SizeFile.height20),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          Get.back();
                                        },
                                        child: Container(
                                            height: SizeFile.height48,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                3.7,
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                                color: ColorFile.appColor
                                                    .withOpacity(0.15),
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        SizeFile.height8)),
                                            child: const Text(
                                                StringConfig.cancel,
                                                style: TextStyle(
                                                    color: ColorFile
                                                        .onBordingColor,
                                                    fontFamily: satoshiMedium,
                                                    fontWeight: FontWeight.w500,
                                                    fontSize:
                                                        SizeFile.height16))),
                                      ),
                                      const SizedBox(width: 15),
                                      GestureDetector(
                                        onTap: () async {
                                          loginController.passwordController
                                              .clear();
                                          await StorageController.instance
                                              .clearToken();
                                          await StorageController.instance
                                              .clearUser();
                                          Get.offAll(() => const LoginScreen());
                                        },
                                        child: Container(
                                          height: SizeFile.height48,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              3.7,
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                              color: ColorFile.appColor,
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      SizeFile.height8)),
                                          child: const Text(StringConfig.yes,
                                              style: TextStyle(
                                                  color: ColorFile.whiteColor,
                                                  fontFamily: satoshiMedium,
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: SizeFile.height16)),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                              titleTextStyle: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: ColorFile.blackColor,
                                  fontSize: SizeFile.height20),
                              backgroundColor: ColorFile.whiteColor,
                              shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(SizeFile.height28))),
                              content: const Text(
                                  StringConfig.areYouSureYouWantToLogOut,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: ColorFile.onBordingColor,
                                      fontFamily: satoshiMedium,
                                      fontWeight: FontWeight.w500,
                                      fontSize: SizeFile.height14)),
                            );
                          },
                        );
                      },
                      child: Row(
                        children: [
                          Image.asset(AssetImagePaths.logoutIcon,
                              height: SizeFile.height22),
                          const SizedBox(width: SizeFile.height20),
                          Text(
                            StringConfig.logOut.tr,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: SizeFile.height16,
                                color: ColorFile.onBordingColor,
                                fontFamily: satoshiMedium,
                                fontWeight: FontWeight.w500),
                          )
                        ],
                      ),
                    ),
                  ),
                )
        ],
      ),
    );
  }
}

import 'package:get/get.dart';

// MODELS IMPORTS
import '../model/category_model.dart';
import '../model/place_model.dart';
import '../model/test_model.dart';

// SERVICES IMPORTS
import 'package:catalog_city_project/services/api.dart';

// UTILS IMPORTS
import '../util/asset_image_paths.dart';
import '../util/string_config.dart';

class HomeController extends GetxController {
  RxString appbarTitle = "".obs;
  RxBool isLoading = true.obs;
  RxInt selectedActivity = 0.obs;
  RxList<CategoryModel> categoriesList = RxList<CategoryModel>();
  RxList<bool> selectPopularItems = List.generate(5, (index) => false).obs;

  @override
  void onInit() {
    super.onInit();
    fetchAll();
  }

  void updateSelectedActivity(int index) {
    selectedActivity.value = index;
  }

  Future<void> fetchCategories() async {
    // await Future.delayed(Duration(seconds: 3));
    try {
      var categories = await Api.getCategories();
      selectedActivity(0);
      if (categories != null) {
        categoriesList.value = categories;
      }
    } finally {}
  }

  Future<void> fetchCities() async {
    isLoading(true);
    // await Future.delayed(Duration(seconds: 3));
    try {
      var places = await Api.getCities();
      if (places != null) {
        placesList.value = places;
      }
    } finally {}
  }

  Future<void> fetchInternationalTrips() async {
    isLoading(true);
    // await Future.delayed(Duration(seconds: 3));
    try {
      var trips = await Api.getInternationalTrips();
      if (trips != null) {
        internationalTripList.value = trips;
      }
    } finally {}
  }

  void fetchAll() async {
    isLoading(true);
    try {
      await fetchCategories();
      await fetchCities();
      await fetchInternationalTrips();
    } finally {
      isLoading(false);
    }
  }

  RxList<PlaceModelTest> popularPlacesList = [
    PlaceModelTest(
      text: StringConfig.srinagar,
      icon: AssetImagePaths.srinagarImage,
    ),
    PlaceModelTest(
      text: StringConfig.manali,
      icon: AssetImagePaths.manaliImage,
    ),
    PlaceModelTest(
      text: StringConfig.darjeeling,
      icon: AssetImagePaths.darjeeling,
    ),
    PlaceModelTest(
      text: StringConfig.rishikesh,
      icon: AssetImagePaths.rishikeshImage,
    ),
    PlaceModelTest(
      text: StringConfig.srinagar,
      icon: AssetImagePaths.srinagarImage,
    ),
  ].obs;
}

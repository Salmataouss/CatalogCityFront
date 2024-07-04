import 'package:get/get.dart';
import 'package:catalog_city_project/view/login_screem/login_screen.dart';
import 'package:catalog_city_project/view/splash_screen/splash_screen.dart';
import '../controller/storage_controller.dart';
import '../view/home_screen/home_screen.dart';

class AppRoutes {
  static const String splashScreen = '/SplashScreen';
  static const String homeScreen = '/HomeScreen';
  static const String loginScreen = '/Loginscreen';
  // static const String _onBoardingScreen = '/Onloadingscreen';
  // static const String _otpVerificationScreen = '/otpVerificationScreen';
  // static const String _resetPasswordScreen = '/resetPasswordScreen';
  // static const String _createPasswordScreen = '/createPasswordScreen';
  // static const String _signInScreen = '/signInScreen';
  // static const String _categorieScreen = '/categorieScreen';
  // static const String _productListScreen = '/ProductListScreen';
  // static const String _aseelCapitalscreen = '/AseelCapitalscreen';
  // static const String _aseelMapscreen = '/AseelMapscreen';
  // static const String _appNavigationScreen = '/app_navigation_screen';
  // static const String _myOrderScreen = '/myOrderScreen';
  // static const String _myPaymentsAScreen = '/MyPaymentsAScreen';
  // static const String _shoppingScreen = '/ShoppingScreen';
  // static const String _couponApplyScreen = '/CouponApplyScreen';
  // static const String _couponSuccsessSCreen = '/CouponSuccsessSCreen';
  // static const String _emptyShoppingScreen = '/EmptyShoppingScreen';
  // static const String _addressScreen = '/AddressScreen';
  // static const String _newAddressScreen = '/NewAddressScreen';
  // static const String _checkoutScreen = '/CheckoutScreen';
  // static const String _profileScreen = '/ProfileScreen';
  // static const String _settingScreen = '/SettingScreen';
  // static const String _editProfileScreen = '/EditProfileScreen';
  // static const String _productDetailScreen = '/ProductDetailScreen';
  // static const String _favouriteScreen = '/FavouriteScreen';
  // static const String _paymentScreen = '/PaymentScreen';
  // static const String _changePasswordScreen = '/ChangePasswordScreen';
  // static const String _deleteAccountScreen = '/DeleteAccountScreen';
  // static const String _searchScreen = '/SearchScreen';
  // static const String _forgotVerification = '/ForgotVerification';

  // INITIAL ROUTE
  static Future<String> get initial async {
    bool isUserLoggedIn = await StorageController.instance.isUserAuth();
    bool isFirstTime = await StorageController.instance.isAppOpened();

    return isFirstTime
        ? splashScreen
        : isUserLoggedIn
            ? homeScreen
            : loginScreen;
  }

  // APP ROUTES
  static final routes = [
    GetPage(name: homeScreen, page: () => HomeScreen()),
    GetPage(name: splashScreen, page: () => SplashScreen()),
    GetPage(name: loginScreen, page: () => LoginScreen()),
  ];
}

import 'dart:io';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

import '../util/auth_utils.dart';

class ShareController extends GetxController {
  RxBool isLoading = false.obs;

  void sharePlace(String img, String title) async {
    bool isUserAuth = await AuthUtils.redirectTo();
    if (!isUserAuth) return;

    isLoading(true);
    final dir = await getTemporaryDirectory();
    http.Response response = await http.get(
      Uri.parse(img),
    );
    final file = File("${dir.path}/image.jpg");
    await file.writeAsBytes(response.bodyBytes);
    isLoading(false);
    await Share.shareXFiles(
      [XFile(file.path)],
      text: 'Hi look at this cool attraction in $title',
    );
  }
}

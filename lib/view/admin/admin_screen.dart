import 'package:cached_network_image/cached_network_image.dart';
import 'package:catalog_city_project/controller/create_city_controller.dart';
import 'package:catalog_city_project/util/asset_image_paths.dart';
import 'package:catalog_city_project/util/colors.dart';
import 'package:catalog_city_project/view/common/common_button.dart';
import 'package:catalog_city_project/view/sign_up_screen/sign_up_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../common/common_text_field.dart';

class AdminScreen extends StatelessWidget {
  const AdminScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final CreateCityController createCityCtr = Get.put(CreateCityController());

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Create new City',
        ),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () => Get.to(() => SignUpScreen()),
              icon: Icon(Icons.logout)),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Form(
              key: createCityCtr.formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20),
                  Text(
                    'Choose city image',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      GetBuilder<CreateCityController>(
                        builder: (ctr) => ctr.isLoading
                            ? Row(
                                children: [
                                  const SizedBox(
                                    width: 60,
                                    height: 60,
                                    child: CircularProgressIndicator(),
                                  ),
                                  const SizedBox(width: 5),
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: IconButton(
                                      color: Colors.white,
                                      style: IconButton.styleFrom(
                                        padding: const EdgeInsets.all(20),
                                        backgroundColor:
                                            ColorFile.appColor.withOpacity(0.5),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                      ),
                                      splashColor: Colors.white,
                                      onPressed: null,
                                      icon: Icon(
                                        Icons.camera_alt_rounded,
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            : Expanded(
                                child: SizedBox(
                                  width: Get.width,
                                  height: 60,
                                  child: ListView.builder(
                                      physics: AlwaysScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      scrollDirection: Axis.horizontal,
                                      itemCount: ctr.imageUrlList.length + 1,
                                      itemBuilder: (context, index) {
                                        if (index < ctr.imageUrlList.length) {
                                          return Padding(
                                            padding: const EdgeInsets.only(
                                                right: 8.0),
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              child: CachedNetworkImage(
                                                imageUrl:
                                                    ctr.imageUrlList[index],
                                                width: 60,
                                                height: 60,
                                                fit: BoxFit.cover,
                                                placeholder: (c, _) =>
                                                    Image.asset(
                                                  AssetImagePaths.placeholder,
                                                  width: 60,
                                                  height: 60,
                                                  fit: BoxFit.cover,
                                                ),
                                                errorWidget:
                                                    (context, url, error) =>
                                                        Icon(Icons.error),
                                              ),
                                            ),
                                          );
                                        } else {
                                          return GetBuilder<
                                                  CreateCityController>(
                                              builder: (ctr) {
                                            return Container(
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              child: IconButton(
                                                color: Colors.white,
                                                style: IconButton.styleFrom(
                                                  padding:
                                                      const EdgeInsets.all(20),
                                                  backgroundColor: ColorFile
                                                      .appColor
                                                      .withOpacity(0.5),
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                  ),
                                                ),
                                                splashColor: Colors.white,
                                                onPressed: () =>
                                                    createCityCtr.uploadImage(),
                                                icon: Icon(
                                                  Icons.camera_alt_rounded,
                                                ),
                                              ),
                                            );
                                          });
                                        }
                                      }),
                                ),
                              ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Country Name',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 10),
                  editFieldText(
                    controller: createCityCtr.countryNameCtr,
                    validator: (value) => createCityCtr.validator(value),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'City Name',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 10),
                  editFieldText(
                    controller: createCityCtr.cityNameCtr,
                    validator: (value) => createCityCtr.validator(value),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Description',
                    style: TextStyle(fontSize: 16),
                  ),
                  editFieldText(
                    controller: createCityCtr.cityDescCtr,
                    validator: (value) => createCityCtr.validator(value),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Address',
                    style: TextStyle(fontSize: 16),
                  ),
                  editFieldText(
                    controller: createCityCtr.cityAddresseCtr,
                    validator: (value) => createCityCtr.validator(value),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Latitude',
                    style: TextStyle(fontSize: 16),
                  ),
                  editFieldText(
                    keyboardType: TextInputType.numberWithOptions(
                        signed: true, decimal: true),
                    controller: createCityCtr.latCtr,
                    validator: (value) => createCityCtr.validateNumber(value),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Logitude',
                    style: TextStyle(fontSize: 16),
                  ),
                  editFieldText(
                    controller: createCityCtr.logCtr,
                    keyboardType: TextInputType.numberWithOptions(
                        signed: true, decimal: true),
                    validator: (value) => createCityCtr.validateNumber(value),
                  ),
                  SizedBox(height: 20),
                  Obx(
                    () => LoadingButton(
                      isLoading: createCityCtr.isSubmited.value,
                      text: 'Submit',
                      onTap: () => createCityCtr.onSubmit(),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

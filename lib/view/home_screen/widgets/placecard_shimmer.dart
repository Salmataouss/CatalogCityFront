import 'package:flutter/material.dart';

import '../../../util/size_config.dart';
import '../../widgets/shimmer_widget.dart';

class PlaceCardShimmer extends StatelessWidget {
  const PlaceCardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: SizeFile.height8),
      child: Container(
        height: SizeFile.height190,
        width: SizeFile.height148,
        padding: const EdgeInsets.symmetric(horizontal: SizeFile.height8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ShimmerWidget.rectangular(
              height: SizeFile.height104,
              width: SizeFile.height132,
            ),
            SizedBox(height: SizeFile.height15),
            ShimmerWidget.rectangular(
              height: SizeFile.height10,
            ),
            SizedBox(height: SizeFile.height10),
            Align(
              alignment: Alignment.centerLeft,
              child: ShimmerWidget.rectangular(
                height: SizeFile.height10,
                width: MediaQuery.of(context).size.width * .2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

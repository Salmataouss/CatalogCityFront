import 'package:flutter/material.dart';

import '../../../util/size_config.dart';
import '../../widgets/shimmer_widget.dart';

class CategoryShimmer extends StatelessWidget {
  const CategoryShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: SizeFile.height16),
      width: SizeFile.height120,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: const [
          ShimmerWidget.rectangular(
            height: SizeFile.height25,
            width: SizeFile.height25,
            radius: 4,
          ),
          ShimmerWidget.rectangular(
            height: SizeFile.height10,
            width: SizeFile.height80,
            radius: 2,
          ),
        ],
      ),
    );
  }
}

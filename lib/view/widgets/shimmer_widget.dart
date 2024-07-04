import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerWidget extends StatelessWidget {
  final double width;
  final double height;
  final BoxShape shape;
  final double radius;

  const ShimmerWidget.rectangular({
    super.key,
    this.width = double.maxFinite,
    this.shape = BoxShape.rectangle,
    this.radius = 6,
    required this.height,
  });

  const ShimmerWidget.circle({
    super.key,
    this.shape = BoxShape.circle,
    this.radius = 0,
    required this.width,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: Colors.grey,
          shape: shape,
          borderRadius: BorderRadius.circular(radius),
        ),
      ),
    );
  }
}

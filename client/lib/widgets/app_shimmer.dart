import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class AppShimmer extends StatelessWidget {
  final Widget child;
  final Color? baseColor;
  final Color? highlightColor;

  const AppShimmer(
      {super.key, required this.child, this.baseColor, this.highlightColor});

  @override
  Widget build(BuildContext context) {
    final lightShimmer = Colors.grey.withOpacity(0.25);
    return Shimmer.fromColors(
      baseColor:
          context.isDarkMode ? baseColor ?? Colors.grey.shade700 : lightShimmer,
      highlightColor: context.isDarkMode
          ? highlightColor ?? Colors.grey.shade800
          : lightShimmer.withOpacity(0.5),
      period: const Duration(
        milliseconds: 1000,
      ),
      child: child,
    );
  }
}

class ShimmerText extends StatelessWidget {
  final double width;
  final double height;
  const ShimmerText({super.key, required this.width, required this.height});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      color: Colors.white,
      margin: const EdgeInsets.only(top: 10),
    );
  }
}

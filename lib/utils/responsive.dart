import 'package:flutter/material.dart';

class Responsive extends StatelessWidget {
  final Widget mobile;
  final Widget? tablet;
  final Widget desktop;

  const Responsive({
    Key? key,
    required this.mobile,
    required this.desktop,
    this.tablet,
  }) : super(key: key);

  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < 991;

  static bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.width >= 991 &&
      MediaQuery.of(context).size.width < 1260;

  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= 1260;

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (BuildContext context) {
        return MediaQuery.withClampedTextScaling(
          minScaleFactor: 1,
          maxScaleFactor: 2,
          child: _buildContent(context),
        );
      },
    );
  }

  Widget _buildContent(BuildContext context) {
    if (isDesktop(context)) {
      return desktop;
    } else if (isTablet(context)) {
      return tablet ?? const SizedBox();
    } else {
      return mobile;
    }
  }
}

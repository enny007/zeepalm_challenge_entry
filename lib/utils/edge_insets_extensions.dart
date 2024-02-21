import 'package:flutter/widgets.dart';

//This is to make the paddings alignment responsive with different screen size.
extension EdgeInsetsExtension on EdgeInsets {
  static EdgeInsets fromPercentage({
    required double lefthorizontalPercentage,
    required double righthorizontalPercentage,
    required double topverticalPercentage,
    required double bottomverticalPercentage,
    Size referenceSize = const Size(1440, 1024),
    required BuildContext context,
  }) {
    return EdgeInsets.only(
      left: lefthorizontalPercentage / referenceSize.width * MediaQuery.sizeOf(context).width,
      right: righthorizontalPercentage / referenceSize.height * MediaQuery.sizeOf(context).width,
      top: topverticalPercentage / referenceSize.height * MediaQuery.sizeOf(context).height,
      bottom: bottomverticalPercentage / referenceSize.height * MediaQuery.sizeOf(context).height,
    );
  }
}

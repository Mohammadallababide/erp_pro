import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CorerUtilFunction {
  static String getFormalDate(String date) {
    return DateFormat('yyyy-MM-dd').format(DateTime.parse(date));
  }

  static Widget getShimmer(Widget shimmerChild) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.withOpacity(0.5),
      highlightColor: Colors.grey.withOpacity(0.1),
      enabled: true,
      direction: ShimmerDirection.rtl,
      child: shimmerChild,
    );
  }
}

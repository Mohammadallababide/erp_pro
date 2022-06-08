import 'package:erb_mobo/common/theme_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomAppButton extends StatelessWidget {
  final double? paddingHorizontalValue;
  final String title;
  const CustomAppButton({
    Key? key,
    this.paddingHorizontalValue,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: ScreenUtil().setWidth(paddingHorizontalValue ?? 15),
      ),
      child: Container(
        decoration: ThemeHelper().buttonBoxDecoration(context: context),
        padding: EdgeInsets.symmetric(
          vertical: ScreenUtil().setHeight(9),
        ),
        child: Center(
          child: Text(
            '$title'.toUpperCase(),
            style: GoogleFonts.belleza(
              fontStyle: FontStyle.normal,
              textStyle: TextStyle(
                fontSize: ScreenUtil().setSp(26),
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

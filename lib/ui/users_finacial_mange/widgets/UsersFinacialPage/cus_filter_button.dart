import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class CusFilterButton extends StatelessWidget {
  const CusFilterButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Align(
        alignment: Alignment.topRight,
        child: Container(
          width: ScreenUtil().setWidth(110),
          height: ScreenUtil().setHeight(50),
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.circular(
              ScreenUtil().setSp(15),
            ),
          ),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Filter'.toUpperCase(),
                  style: GoogleFonts.belleza(
                    fontStyle: FontStyle.normal,
                    textStyle: TextStyle(
                      fontSize: ScreenUtil().setSp(20),
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                const Icon(
                  Icons.filter_alt,
                  color: Colors.white,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

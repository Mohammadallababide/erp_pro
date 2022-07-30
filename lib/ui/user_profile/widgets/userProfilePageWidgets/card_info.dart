import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CardInfo extends StatelessWidget {
  final String title;
  final IconData icon;
  const CardInfo({
    Key? key,
    required this.title,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: ScreenUtil().setHeight(20),
      ),
      child: Container(
        height: ScreenUtil().setHeight(55),
        width: ScreenUtil().setWidth(300),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            ScreenUtil().radius(30),
          ),
          color: Colors.white.withOpacity(0.4),
        ),
        child: Container(
          margin: EdgeInsets.symmetric(
            horizontal: ScreenUtil().setWidth(10),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    icon,
                    size: ScreenUtil().setSp(25),
                  ),
                  SizedBox(
                    width: ScreenUtil().setWidth(10),
                  ),
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: ScreenUtil().setSp(16),
                      fontWeight: FontWeight.w700,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ],
              ),
              Icon(
                Icons.arrow_forward_ios,
                color: Theme.of(context).primaryColor,
                size: ScreenUtil().setSp(25),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

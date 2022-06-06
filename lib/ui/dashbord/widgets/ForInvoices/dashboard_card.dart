import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DashBoardCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? otherTitle;
  final String value;
  final Color color;
  final String? otherValue;
  const DashBoardCard({
    Key? key,
    required this.icon,
    required this.title,
    this.otherTitle,
    required this.value,
    required this.color,
    this.otherValue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return buildDashbordCard(context);
  }

  Widget buildDashbordCard(BuildContext context) {
    return Container(
      width: ScreenUtil().setWidth(200),
      height: ScreenUtil().setHeight(50),
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            ScreenUtil().radius(15),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: ScreenUtil().setWidth(10),
            vertical: ScreenUtil().setHeight(10),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                flex: 0,
                child: Container(
                  width: 46,
                  height: 46,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle, color: color.withOpacity(0.6)),
                  child: Center(
                    child: Icon(
                      icon,
                      color: Theme.of(context).primaryColor,
                      size: ScreenUtil().setSp(27),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: ScreenUtil().setWidth(10),
              ),
              Flexible(
                flex: 6,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: TextStyle(
                            fontSize: ScreenUtil().setSp(13),
                            color: Color.fromARGB(255, 113, 111, 111),
                          ),
                        ),
                        SizedBox(
                          height: ScreenUtil().setHeight(5),
                        ),
                        Text(
                          value,
                          style: TextStyle(
                            fontSize: ScreenUtil().setSp(15),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: ScreenUtil().setHeight(10),
                    ),
                    otherTitle != null
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                otherTitle!,
                                style: TextStyle(
                                  fontSize: ScreenUtil().setSp(13),
                                  color: Color.fromARGB(255, 113, 111, 111),
                                ),
                              ),
                              SizedBox(
                                height: ScreenUtil().setHeight(5),
                              ),
                              Text(
                                otherValue!,
                                style: TextStyle(
                                  fontSize: ScreenUtil().setSp(15),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          )
                        : Container(),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:erb_mobo/models/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UserCard extends StatelessWidget {
  final User user;
  const UserCard({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
        ScreenUtil().setWidth(10),
        ScreenUtil().setHeight(5),
        ScreenUtil().setWidth(10),
        ScreenUtil().setHeight(5),
      ),
      child: Material(
        elevation: 0.3,
        borderRadius: BorderRadius.all(
          Radius.circular(
            ScreenUtil().radius(15),
          ),
        ),
        child: Container(
          height: ScreenUtil().setHeight(50),
          padding: EdgeInsets.fromLTRB(
            ScreenUtil().setWidth(15),
            ScreenUtil().setHeight(3),
            ScreenUtil().setWidth(15),
            ScreenUtil().setHeight(3),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    height: ScreenUtil().setSp(30),
                    width: ScreenUtil().setSp(30),
                    decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: AssetImage(
                            'assets/images/useric.png',
                          ),
                          fit: BoxFit.contain,
                        )),
                  ),
                  SizedBox(
                    width: ScreenUtil().setWidth(8),
                  ),
                  Text(
                    user.firstName + ' ' + user.lastName,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: ScreenUtil().setSp(18),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Icon(
                Icons.check_circle,
                color: Theme.of(context).primaryColor,
                size: ScreenUtil().setSp(22),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

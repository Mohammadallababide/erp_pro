import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../models/user.dart';

class UserTileCard extends StatelessWidget {
  final bool isSelected;
  final User user;
  const UserTileCard({
    Key? key,
    required this.isSelected,
    required this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
        ScreenUtil().setWidth(5),
        ScreenUtil().setHeight(0),
        ScreenUtil().setWidth(5),
        ScreenUtil().setHeight(0),
      ),
      child: ListTile(
          title: Text(
            user.firstName + ' ' + user.lastName,
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: ScreenUtil().setSp(14)),
          ),
          subtitle: Text(user.roles != null ? user.roles![0] : ''),
          leading: Container(
            height: ScreenUtil().setSp(35),
            width: ScreenUtil().setSp(35),
            decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                shape: BoxShape.circle,
                image: const DecorationImage(
                  image: AssetImage(
                    'assets/images/useric.png',
                  ),
                  fit: BoxFit.contain,
                )),
          ),
          // Icon(
          //   Icons.account_circle,
          //   color: Theme.of(context).primaryColor,
          //   size: ScreenUtil().setSp(30),
          // ),
          trailing: isSelected
              ? Icon(
                  Icons.check_circle,
                  color: Theme.of(context).primaryColor,
                  size: ScreenUtil().setSp(20),
                )
              : Icon(
                  Icons.check_circle,
                  color: Colors.grey,
                  size: ScreenUtil().setSp(20),
                )),

      // Card(
      //   color: isSelected ? Theme.of(context).primaryColor : Colors.transparent,
      //   elevation: 0.3,
      //   child: Container(
      //     decoration: BoxDecoration(
      //       borderRadius: BorderRadius.all(
      //         Radius.circular(
      //           ScreenUtil().radius(20),
      //         ),
      //       ),
      //     ),
      //     height: ScreenUtil().setHeight(50),
      //     padding: EdgeInsets.fromLTRB(
      //       ScreenUtil().setWidth(15),
      //       ScreenUtil().setHeight(3),
      //       ScreenUtil().setWidth(15),
      //       ScreenUtil().setHeight(3),
      //     ),
      //     child: Row(
      //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //       children: [
      //         Row(
      //           children: [
      //             Container(
      //               height: ScreenUtil().setSp(35),
      //               width: ScreenUtil().setSp(35),
      //               decoration: BoxDecoration(
      //                   color: Theme.of(context).primaryColor,
      //                   shape: BoxShape.circle,
      //                   image: const DecorationImage(
      //                     image: AssetImage(
      //                       'assets/images/useric.png',
      //                     ),
      //                     fit: BoxFit.contain,
      //                   )),
      //             ),
      //             SizedBox(
      //               width: ScreenUtil().setWidth(8),
      //             ),
      //             Column(
      //               crossAxisAlignment: CrossAxisAlignment.start,
      //               children: [
      //                 Text(
      //                   user.firstName + ' ' + user.lastName,
      //                   style: TextStyle(
      //                     color: isSelected ? Colors.white : Colors.black,
      //                     fontSize: ScreenUtil().setSp(16),
      //                     fontWeight: FontWeight.bold,
      //                   ),
      //                 ),
      //                 Text(
      //                   user.roles![0],
      //                   style: TextStyle(
      //                     color: isSelected ? Colors.white : Colors.black,
      //                     fontSize: ScreenUtil().setSp(13),
      //                     fontWeight: FontWeight.w300,
      //                   ),
      //                 ),
      //               ],
      //             ),
      //           ],
      //         ),
      //         isSelected
      //             ? Icon(
      //                 Icons.check_circle,
      //                 color: Colors.white,
      //                 size: ScreenUtil().setSp(22),
      //               )
      //             : Container(),
      //       ],
      //     ),
      //   ),
      // ),
    );
  }
}

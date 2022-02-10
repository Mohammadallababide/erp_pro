import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HeaderWidget extends StatefulWidget {
  final double _height;
  final bool _showIcon;
  final IconData _icon;
  const HeaderWidget(this._height, this._showIcon, this._icon, );

  @override
  _HeaderWidgetState createState() => _HeaderWidgetState();
}

class _HeaderWidgetState extends State<HeaderWidget> {

  
  @override
  Widget build(BuildContext context) {
        double width = MediaQuery
        .of(context)
        .size
        .width;

    return Stack(
      children: [
        ClipPath(
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [
                    Theme.of(context).primaryColor.withOpacity(0.4),
                    Theme.of(context).colorScheme.secondary.withOpacity(0.7),
                  ],
                  begin: const FractionalOffset(0.0, 0.0),
                  end: const FractionalOffset(1.0, 0.0),
                  stops: const [0.0, 1.0],
                  tileMode: TileMode.clamp),
            ),
          ),
          clipper: ShapeClipper([
            Offset(width / 5, widget._height),
            Offset(width / 10 * 5, widget._height - 60),
            Offset(width / 5 * 4, widget._height + 20),
            Offset(width, widget._height - 18)
          ]),
        ),
        ClipPath(
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [
                    Theme.of(context).primaryColor.withOpacity(0.4),
                    Theme.of(context).colorScheme.secondary.withOpacity(0.4),
                  ],
                  begin: const FractionalOffset(0.0, 0.0),
                  end: const FractionalOffset(1.0, 0.0),
                  stops: const [0.0, 1.0],
                  tileMode: TileMode.clamp),
            ),
          ),
          clipper: ShapeClipper([
            Offset(width / 3, widget._height + 20),
            Offset(width / 10 * 8, widget._height - 60),
            Offset(width / 5 * 4, widget._height - 60),
            Offset(width, widget._height - 20)
          ]),
        ),
        ClipPath(
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [
                    Theme.of(context).primaryColor,
                    Theme.of(context).colorScheme.secondary,
                  ],
                  begin: const FractionalOffset(0.0, 0.0),
                  end: const FractionalOffset(1.0, 0.0),
                  stops: const [0.0, 1.0],
                  tileMode: TileMode.clamp),
            ),
          ),
          clipper: ShapeClipper([
            Offset(width / 5, widget._height),
            Offset(width / 2, widget._height - 40),
            Offset(width / 5 * 4, widget._height - 80),
            Offset(width, widget._height - 20)
          ]),
        ),
        Visibility(
          visible: widget._showIcon,
          child: SizedBox(
            height: widget._height - ScreenUtil().setWidth(35),
            child: Center(
              child: Container(
                // margin: const EdgeInsets.all(20),
                padding: const EdgeInsets.only(
                  left: 5.0,
                  top: 20.0,
                  right: 5.0,
                  bottom: 20.0,
                ),
                decoration: BoxDecoration(
                  borderRadius:  BorderRadius.only(
                    topLeft: Radius.circular(ScreenUtil().radius(120)),
                    topRight:  Radius.circular(ScreenUtil().radius(120)),
                    bottomLeft:  Radius.circular(ScreenUtil().radius(65)),
                    bottomRight: Radius.circular(ScreenUtil().radius(65)),
                  ),
                  border: Border.all(width: 5, color: Colors.white),
                ),
                child: Icon(
                  widget._icon,
                  color: Colors.white,
                  size: ScreenUtil().setSp(40),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class ShapeClipper extends CustomClipper<Path> {
  List<Offset> _offsets = [];
  ShapeClipper(this._offsets);
  @override
  Path getClip(Size size) {
    var path = Path();

    path.lineTo(0.0, size.height - 20);

    // path.quadraticBezierTo(size.width/5, size.height, size.width/2, size.height-40);
    // path.quadraticBezierTo(size.width/5*4, size.height-80, size.width, size.height-20);

    path.quadraticBezierTo(
        _offsets[0].dx, _offsets[0].dy, _offsets[1].dx, _offsets[1].dy);
    path.quadraticBezierTo(
        _offsets[2].dx, _offsets[2].dy, _offsets[3].dx, _offsets[3].dy);

    // path.lineTo(size.width, size.height-20);
    path.lineTo(size.width, 0.0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

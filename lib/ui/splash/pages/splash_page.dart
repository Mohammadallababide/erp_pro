import 'dart:async';

import 'package:erb_mobo/common/generate_screen.dart';
import 'package:flutter/material.dart';

class SplachPage extends StatefulWidget {
  const SplachPage({ Key? key }) : super(key: key);

  @override
  _SplachPageState createState() => _SplachPageState();
}

class _SplachPageState extends State<SplachPage> {
  
    bool _isVisible = false;

  _SplachPageState(){

     Timer(const Duration(milliseconds: 2000), (){
      setState(() {
        Navigator.pushReplacementNamed(context, NameScreen.loginPage);
      });
    });

     Timer(
      const Duration(milliseconds: 10),(){
        setState(() {
          _isVisible = true; // Now it is showing fade effect and navigating to Login page
        });
      }
    );

  }

  @override
  Widget build(BuildContext context) {

    return Container(
      decoration:  BoxDecoration(
        gradient:  LinearGradient(
          colors: [Theme.of(context).colorScheme.secondary, Theme.of(context).primaryColor],
          begin: const FractionalOffset(0, 0),
          end: const FractionalOffset(1.0, 0.0),
          stops: const [0.0, 1.0],
          tileMode: TileMode.clamp,
        ),
      ),
      child: AnimatedOpacity(
        opacity: _isVisible ? 1.0 : 0,
        duration: const Duration(milliseconds: 1200),
        child: Center(
          child: Container(
            height: 140.0,
            width: 140.0,
            child: const Center(
              child: ClipOval(
                child:Image(image: AssetImage('assets/images/brick.png'),
                )
                // //put your logo here
              ),
            ),
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  blurRadius: 2.0,
                  offset: const Offset(5.0, 3.0),
                  spreadRadius: 2.0,
                )
              ]
            ),
          ),
        ),
      ),
    );
  }
}
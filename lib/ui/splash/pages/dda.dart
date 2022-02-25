import 'package:flutter/material.dart';
import 'package:flare_flutter/flare_actor.dart';

class Dd extends StatelessWidget {
  const Dd({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("First App"),
      ),
      body: const Center(
        child: FlareActor("assets/flare/bubble.flr",
        animation: "phone_sway",
        fit: BoxFit.contain)
      )
    );
  }
}
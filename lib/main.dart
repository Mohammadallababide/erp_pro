import 'package:flutter/material.dart';

import 'app/app.dart';
import 'data/local_data_source/shared_pref.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
 await  SharedPref.init();
  runApp(App());
}

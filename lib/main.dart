import 'package:coffee_app/models/user_model.dart';
import 'package:coffee_app/screens/wrapper.dart';
import 'package:coffee_app/services/auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // what kind of data you're listening to <kind of data>
    return StreamProvider<MyUser?>.value(
        // initial data
        initialData: MyUser(uid: null),
        // value: what stream you're going to listen to
        value: AuthService().user,
        child: MaterialApp(
          home: Wrapper(),
        ));
  }
}

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:winch_app/screens/login_screens/file_upload/file_upload.dart';
import 'package:winch_app/screens/onboarding_screens/intro_screens/intro.dart';
import 'package:winch_app/utils/routes.dart';
import 'themes/light_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //Firebase.initializeApp();
  runApp(App());
}

class App extends StatelessWidget {
  // Create the initialization Future outside of `build`:
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Initialize FlutterFire:
      future: _initialization,
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          return Text("SomethingWentWrong");
          //SomethingWentWrong();
        }
        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          return MyApp();
        }
        // Otherwise, show something whilst waiting for initialization to complete
        return CircularProgressIndicator(); //ProgressHUD(child: null, inAsyncCall: null,); //Loading();
      },
    );
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(context) {
    // TODO: implement build
    return new MaterialApp(
        theme: lightTheme(), initialRoute: Intro.routeName, routes: routes);
  }
}

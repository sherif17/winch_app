import 'package:device_preview/device_preview.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:winch_app/local_db/winch_driver_info_db.dart';
import 'package:winch_app/localization/localization_constants.dart';
import 'package:winch_app/provider/maps_prepration/maps_provider.dart';
import 'package:winch_app/provider/maps_prepration/polyLineProvider.dart';
import 'package:winch_app/provider/upcomming_winch_service/winch_request_provider.dart';
import 'package:winch_app/screens/dash_board/dash_board.dart';
import 'package:winch_app/screens/dash_board/home/acceptted_winch_service/accepted_service_map.dart';
import 'package:winch_app/screens/dash_board/home/home_body.dart';
import 'package:winch_app/screens/login_screens/file_upload/main_stepper.dart';
import 'package:winch_app/screens/onboarding_screens/intro_screens/intro.dart';
import 'package:winch_app/shared_prefrences/winch_user_model.dart';
import 'package:winch_app/utils/routes.dart';
import 'localization/demo_localization.dart';
import 'themes/light_theme.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();
  final appDocumentDir = await path_provider.getApplicationDocumentsDirectory();
  Hive.init(appDocumentDir.path);
  await Hive.openBox<String>("winchDriverInfoDBBox"); // for customer info
  bool devicePreview = false;
  if (devicePreview == false)
    return runApp(App());
  else
    runApp(DevicePreview(
      enabled: !kReleaseMode,
      builder: (context) => App(),
    ));
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

class MyApp extends StatefulWidget {
  static void setLocale(BuildContext context, Locale locale) {
    _MyAppState state = context.findAncestorStateOfType<_MyAppState>();
    state.setLocale(locale);
  }

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Locale _locale;
  String TOKEN = loadJwtTokenFromDB();
  String BACKEND_ID = loadBackendIDFromDB();
  String verificationStatus = loadVerificationStateFromDB();

  void setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  void didChangeDependencies() {
    getLocale().then((local) => {
          setState(() {
            _locale = local;
          })
        });
    // getPrefJwtToken().then((value) {
    //   setState(() {
    //     TOKEN = value;
    //   });
    // });
    // getPrefBackendID().then((value) {
    //   setState(() {
    //     BACKEND_ID = value;
    //   });
    // });
    super.didChangeDependencies();
  }

  @override
  Widget build(context) {
    if (_locale == null) {
      return Container(
        child: Center(
          child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.blue[800])),
        ),
      );
    } else {
      // TODO: implement build
      return MultiProvider(
        providers: [
          ChangeNotifierProvider<WinchRequestProvider>(
              create: (_) => WinchRequestProvider()),
          ChangeNotifierProvider<MapsProvider>(create: (_) => MapsProvider()),
          ChangeNotifierProvider<PolyLineProvider>(
              create: (_) => PolyLineProvider()),
        ],
        child: new MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: lightTheme(),
          initialRoute: //MainStepper.routeName,
              // TOKEN == "" || BACKEND_ID == ""
              verificationStatus == "true"
                  ? DashBoard.routeName
                  : Intro.routeName,
          routes: routes,
          locale: _locale,
          supportedLocales: [
            Locale("en", "US"),
            Locale("ar", "EG"),
          ],
          localizationsDelegates: [
            DemoLocalization.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          localeResolutionCallback: (deviceLocal, supportedLocales) {
            for (var local in supportedLocales) {
              if (local.languageCode == deviceLocal.languageCode &&
                  local.countryCode == deviceLocal.countryCode) {
                return deviceLocal;
              }
            }
            return supportedLocales.first;
          },
        ),
      );
    }
  }
}

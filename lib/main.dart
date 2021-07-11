import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:redeinfo/bindings/feed_binding.dart';
import 'package:redeinfo/ui/feed/feed_screen.dart';
import 'package:flutter/services.dart';

import 'routes/app_pages.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp,
    ]);
    if (Firebase.apps.length == 0) {
      final Future<FirebaseApp> _initialization = Firebase.initializeApp();

      return FutureBuilder(
        future: _initialization,
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasError) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              home: Scaffold(
                body: Container(
                  color: Colors.black,
                  child: Column(
                    children: [
                      Text('Ah, não! Aconteceu um erro!'),
                    ],
                  ),
                ),
              ),
            );
          }

          // Once complete, show your application
          if (snapshot.connectionState == ConnectionState.done) {
            print('rodou future');
            return GetMaterialApp(
              debugShowCheckedModeBanner: false,
              theme: buildTheme(),
              home: FeedScreen(),
              getPages: AppPages.values,
            );
          }

          // Otherwise, show something whilst waiting for initialization to complete
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            home: Scaffold(
              body: Container(
                color: Colors.black,
                child: Column(
                  children: [
                    Text('Carregando...'),
                  ],
                ),
              ),
            ),
          );
        },
      );
    }
    print('rodou');
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: buildTheme(),
      home: FeedScreen(),
      initialBinding: FeedBinding(),
      getPages: AppPages.values,
    );
  }
}

//Essa função retorna o tema dessa aplicação
ThemeData buildTheme() {
  return ThemeData.from(
    colorScheme: ColorScheme(
      primary: Color(0xff92baba),
      primaryVariant: Color(0xff4c8f8d),
      secondary: Color(0xffec6e8b),
      secondaryVariant: Color(0xffe33f5d),
      surface: Colors.white,
      background: Colors.white, //
      error: Color(0xffb00020),
      onPrimary: Colors.white,
      onSecondary: Colors.white,
      onSurface: Colors.black,
      onBackground: Colors.white,
      onError: Colors.white,
      brightness: Brightness.light,
    ),
    textTheme: TextTheme(
      headline1:
          GoogleFonts.openSans(fontWeight: FontWeight.w300, fontSize: 96),
      headline2:
          GoogleFonts.openSans(fontWeight: FontWeight.w300, fontSize: 60),
      headline3:
          GoogleFonts.openSans(fontWeight: FontWeight.w400, fontSize: 48),
      headline4:
          GoogleFonts.openSans(fontWeight: FontWeight.w400, fontSize: 34),
      headline5:
          GoogleFonts.openSans(fontWeight: FontWeight.w400, fontSize: 24),
      headline6:
          GoogleFonts.openSans(fontSize: 18, fontWeight: FontWeight.w600),
      subtitle1:
          GoogleFonts.openSans(fontWeight: FontWeight.w400, fontSize: 16),
      subtitle2:
          GoogleFonts.openSans(fontWeight: FontWeight.w600, fontSize: 14),
      bodyText1:
          GoogleFonts.openSans(fontWeight: FontWeight.w400, fontSize: 16),
      bodyText2:
          GoogleFonts.openSans(fontWeight: FontWeight.w400, fontSize: 14),
      button: GoogleFonts.openSans(
          fontWeight: FontWeight.w500,
          fontSize: 14,
          color: Colors.black,
          letterSpacing: 2),
      caption: GoogleFonts.openSans(fontWeight: FontWeight.w400, fontSize: 12),
      overline: GoogleFonts.openSans(fontWeight: FontWeight.w400, fontSize: 10),
    ),
  ).copyWith(
    inputDecorationTheme: InputDecorationTheme(
      labelStyle: TextStyle(),
      border: OutlineInputBorder(),
      //alignLabelWithHint: true,
    ),
    buttonColor: Color(0xffec6e8b),
    buttonTheme: ButtonThemeData(
      textTheme: ButtonTextTheme.primary,
      buttonColor: Color(0xffec6e8b),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(5),
        ),
      ),
    ),
    appBarTheme: AppBarTheme(
      iconTheme: IconThemeData(color: Colors.white),
      elevation: 5,
      centerTitle: true,
      // brightness: Brightness.dark,
    ),
  );
}

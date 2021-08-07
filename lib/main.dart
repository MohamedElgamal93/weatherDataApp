import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mohamedElgamalWeatherTask/scr/ui/weather.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:page_transition/page_transition.dart';




void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await runZoned<Future<void>>(() async {
    runApp(MyApp(
    ));
  }, onError: (error, stackTrace) {
    print("=================== CAUGHT FLUTTER ERROR\n");
    print('Caught error: $error');
    if (isInDebugMode) {
      print(stackTrace);
    }
  });
}

bool get isInDebugMode {
  bool inDebugMode = false;
  assert(inDebugMode = true);
  return inDebugMode;
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  
 
  @override
  void initState() {
    super.initState();
       FlutterError.onError = (FlutterErrorDetails details) async {
         if (isInDebugMode) {
           print("=================== CAUGHT FLUTTER ERROR\n");
           FlutterError.dumpErrorToConsole(details);
         }
       };
     }
   
     @override
     Widget build(BuildContext context) {
       SystemChrome.setPreferredOrientations([
         DeviceOrientation.portraitUp,
         DeviceOrientation.portraitDown,
       ]);
       return
              MaterialApp(
            
          
               debugShowCheckedModeBanner: false,
       
                             home: AnimatedSplashScreen(
            backgroundColor: Colors.blue,
            splash: Image.asset('assets/weather.PNG'),
            splashTransition: SplashTransition.rotationTransition,
            duration: 3000,
            pageTransitionType: PageTransitionType.scale,
            nextScreen: CurrentWeather()
            
           )
     
                  );
         
     }

}
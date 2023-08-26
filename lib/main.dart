import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_app/ui/pages/navigation/index.dart';

import 'bloc_observer/index.dart';

void main() async {
  Bloc.observer = SimpleBlocObserver();
  WidgetsFlutterBinding.ensureInitialized();
  await ScreenUtil.ensureScreenSize();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(390, 669),
      builder: (context, child) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'themoviedb',
        theme: ThemeData(
          splashColor: Colors.transparent,
          splashFactory: NoSplash.splashFactory,
        ),
        home: const NavigationPage(),
      ),
    );
  }
}

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import 'bloc_observer/bloc_observer.dart';
import 'ui/navigation/navigation_page.dart';

void main() async {
  Bloc.observer = SimpleBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(),
      home: const NavigationPage(),
    );
  }
}

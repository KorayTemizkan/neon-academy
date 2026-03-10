import 'package:_auto_route/HomePage.dart';
import 'package:_auto_route/routes/app_router.dart';
import 'package:flutter/material.dart';

final _appRouter = AppRouter();

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _appRouter.config(),
    );
  }
}
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
    // Normalde MaterialApp içinde açardın ama router tanımlamak istersen bu şekilde MaterialApp.router ile açıyorsun
    return MaterialApp.router(
      // router ayarını yukarıda oluşturduğumuz router nesnesinden çağırıyoruz
      routerConfig: _appRouter.config(),
    );
  }
}
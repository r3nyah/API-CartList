import 'package:flutter/material.dart';
import 'package:memes_api/common/providers/api_cart_provider.dart';
import 'package:memes_api/common/providers/cart_counter_provider.dart';
import 'package:memes_api/presentation/screen/splash_screen.dart';
import 'package:provider/provider.dart';

void main(){
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MemeCartProvider()),
        ChangeNotifierProvider(create: (_) => CartCounterProvider())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: 'SpaceMono',
          useMaterial3: true,
          colorSchemeSeed: const Color(0xFF323030),
        ),
        home: const SplashScreen(),
      ),
    );
  }
}
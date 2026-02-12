import 'package:biblia/biblia.dart';
import 'package:biblia/config.dart';
import 'package:biblia/provider.dart';
import 'package:biblia/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Global navigator key
GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

// Main entry point
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => BibliaProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: showDebugBanner,
      title: appName,
      theme: Provider.of<ThemeProvider>(context).theme,
      home: const BibliaScreen(),
    );
  }
}

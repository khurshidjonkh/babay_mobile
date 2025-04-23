import 'package:babay_mobile/core/providers/profile_provider.dart';
import 'package:babay_mobile/presentation/screens/auth/splash_screen.dart';
import 'package:babay_mobile/presentation/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'core/service_locator.dart';
import 'core/providers/auth_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupServiceLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => locator<AuthProvider>()),
        ChangeNotifierProvider(create: (_) => locator<ProfileProvider>()),
      ],
      child: MaterialApp(
        title: 'BaBay',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.purple,
          scaffoldBackgroundColor: Colors.white,
          useMaterial3: true,
        ),
        home: const HomeScreen(),
      ),
    );
  }
}

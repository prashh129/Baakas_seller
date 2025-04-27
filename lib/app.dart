import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'navigation/navigation_menu.dart';
import 'data/repositories/authentication/authentication_repository.dart';
import 'features/authentication/screens/login/login.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Baakas Seller',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF1E88E5),
          brightness: Brightness.light,
        ),
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF1E88E5),
          brightness: Brightness.dark,
        ),
      ),
      themeMode: ThemeMode.system,
      home: Obx(() {
        final authRepo = AuthenticationRepository.instance;
        if (authRepo.firebaseUser == null) {
          return const LoginScreen();
        }
        return const NavigationMenu();
      }),
    );
  }
}

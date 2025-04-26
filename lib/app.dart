import 'package:baakas_seller/features/shop/screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'bindings/general_bindings.dart';
import 'routes/app_routes.dart';
import 'utils/theme/theme.dart';
import 'features/settings/controllers/language_controller.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Baakas Seller',
      debugShowCheckedModeBanner: false,
      theme: BaakasAppTheme.lightTheme,
      darkTheme: BaakasAppTheme.darkTheme,
      themeMode: ThemeMode.system,
      // Force dark mode to follow system theme
      builder: (context, child) {
        final brightness = MediaQuery.of(context).platformBrightness;
        final isDarkMode = brightness == Brightness.dark;
        return Theme(
          data:
              isDarkMode ? BaakasAppTheme.darkTheme : BaakasAppTheme.lightTheme,
          child: child!,
        );
      },
      initialBinding: GeneralBindings(),
      getPages: AppRoutes.pages,
      translations: Messages(),
      locale: const Locale('en', 'US'),
      fallbackLocale: const Locale('en', 'US'),

      /// Seller app starts directly on SellerDashboard.
      home: const HomeScreen(),
    );
  }
}

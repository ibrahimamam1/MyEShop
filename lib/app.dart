import 'package:e_shop/features/authentication/view/onboarding/onboarding.dart';
import 'package:e_shop/utils/constants/colors.dart';
import 'package:e_shop/utils/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        themeMode: ThemeMode.system,
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        home: const Scaffold(
            backgroundColor: AppColors.primary,
            body:
                Center(child: CircularProgressIndicator(color: Colors.white))));
  }
}

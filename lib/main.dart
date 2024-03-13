import 'package:admin_panel/constants/color.dart';
import 'package:admin_panel/pages/routing/routes.dart';
import 'package:admin_panel/pages/widgets/side_bar_nav.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: "Niradei",
        scaffoldBackgroundColor: const Color(0xFFF2F3F7),
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: AppColor.primary)
            .copyWith(secondary: AppColor.secondary),
        pageTransitionsTheme: const PageTransitionsTheme(builders: {
          TargetPlatform.iOS: FadeUpwardsPageTransitionsBuilder(),
          TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
        }),
      ),
      onGenerateRoute: (settings) => generateRoute(settings),
      home: const SideBar(),
    );
  }
}

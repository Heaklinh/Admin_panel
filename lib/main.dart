import 'package:admin_panel/pages/routing/routes.dart';
import 'package:admin_panel/pages/widgets/side_bar_nav.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      
      onGenerateRoute: (settings) => generateRoute(settings),
      home: const SideBar(),
    );
  }
}

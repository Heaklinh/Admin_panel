
import 'package:admin_panel/common/widgets/loader.dart';
import 'package:admin_panel/pages/auth/authenthication.dart';
import 'package:admin_panel/pages/auth/services/auth_services.dart';
import 'package:admin_panel/routes.dart';
import 'package:admin_panel/pages/widgets/side_bar_nav.dart';
import 'package:admin_panel/providers/user_provider.dart';
import 'package:admin_panel/services/admin_services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => UserProvider(),
        ),
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

class _MyAppState extends State<MyApp>{
  final AdminServices adminServices = AdminServices();
  final AuthServices authServices = AuthServices();

  @override
  void initState() {
    super.initState(); 
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _getUserData(context), 
      builder: (context, snapshot){
        if (snapshot.connectionState == ConnectionState.done) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Robot Cafe Admin Panel',
            theme: ThemeData(
              fontFamily: "Niradei",
              scaffoldBackgroundColor: const Color(0xFFF2F3F7),
              useMaterial3: true,
            ),
            onGenerateRoute: (settings) { 
              return generateRoute(context,settings);
            },
            home: Provider.of<UserProvider>(context).user.loginToken.isNotEmpty 
              && Provider.of<UserProvider>(context).user.type == 'admin'
                ? const SideBar()
                : const AuthenticationPage()
          );
        } else {
          return const Loader(); // Show a loading spinner while waiting
        }
      }
    );
  }

  Future<void> _getUserData(BuildContext context) async {
    final authServices = AuthServices();
    await authServices.getUserData(context: context);
  }
}

import 'package:admin_panel/common/widgets/side_bar_nav.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Row(
        children: [
          // Side Navigation View
          const Expanded(
            child: SideBar(),
          ),
          // Main body
          Expanded(
            flex: 4,
            child: Container(),
          ),
        ],
      )),
    );
  }
}

import 'package:admin_panel/pages/dashboard/dashboard.dart';
import 'package:admin_panel/pages/widgets/side_bar.dart';
import 'package:flutter/material.dart';

class LargeScreen extends StatelessWidget {
  const LargeScreen({super.key});
  
  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Expanded(
          child: SideBar(),
        ),
        Expanded(
          flex: 5,
          child: Dashboard(),
        ),
      ],
    );
  }
}

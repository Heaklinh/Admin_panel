import 'package:admin_panel/pages/dashboard/widgets/card_small_screen.dart';
import 'package:flutter/material.dart';

class SmallScreen extends StatelessWidget {
  const SmallScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      //constraints: const BoxConstraints.expand(),
      child: const CardSmallScreen(),
    );
  }
}

import 'package:admin_panel/common/widgets/loader.dart';
import 'package:admin_panel/constants/waiting_dialog.dart';
import 'package:admin_panel/models/maintain_toggle.dart';
import 'package:admin_panel/pages/helpers/responsiveness.dart';
import 'package:admin_panel/pages/widgets/custom_text.dart';
import 'package:admin_panel/services/admin_services.dart';
import 'package:flutter/material.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  AdminServices adminServices = AdminServices();
  MaintainToggle? maintainToggle;
  bool isSwitch = false;

  @override
  void initState() {
    super.initState();
    fetchMaintainToggle();
  }

  fetchMaintainToggle() async {
    maintainToggle = await adminServices.fetchMaintainToggle(context: context, toggle: isSwitch);
    setState(() {
      isSwitch = maintainToggle!.toggle;
    });
  }

  Future<void> updateMaintainToggle() async {
    await adminServices.updateMaintainToggle(
      context: context,
      toggle: isSwitch,
    );
    setState(() {});
  }
  
  @override
  Widget build(BuildContext context) {
    return maintainToggle == null
    ? const Loader()
    : Column (
      children: [
        Row(
          children: [
            Container(
              margin: EdgeInsets.only(
                  top: ResponsiveWidget.isSmallScreen(context) ? 56 : 6),
            )
          ],
        ),
        const SizedBox(
          height: 24,
        ),
        // const Expanded(
        //   child: CardLargeScreen(),
        // )
        SizedBox(
          child: isSwitch == true
          ? Container(
              color: Colors.red,
              child: const CustomText(
                text: "The server is currently under maintenance.",
                size: 24,
                color: Colors.white,
                weight: FontWeight.bold,
              ),
            )
          : const CustomText(
            text: "",
            size: 1,
            color: Colors.white,
            weight: FontWeight.bold,
          )
        ),
        const Text("Maintain the app"),
        Expanded(
          child: Switch(
            value: isSwitch, 
            onChanged: (value){
              setState(() {
                isSwitch = value;
              });
              waitingDialog(context, updateMaintainToggle, "Saving Changes...");
            }
          )
        )
      ],
    );
  }
}

import 'package:admin_panel/common/widgets/loader.dart';
import 'package:admin_panel/constants/color.dart';
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
    setState(() {
      fetchMaintainToggle();
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return maintainToggle == null
    ? const Loader()
    : Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column (
        children: [
          Row(
            children: [
              Container(
                margin: EdgeInsets.only(
                    top: ResponsiveWidget.isSmallScreen(context) ? 56 : 6
                ),
                child: const CustomText(
                  text: "Setting",
                  size: 24,
                  color: AppColor.secondary,
                  weight: FontWeight.bold,
                ),
              )
            ],
          ),
          SizedBox(
            child: maintainToggle!.toggle == true
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
          const SizedBox(height: 20,),
          Expanded(
            child: ListView(
              primary: true,
              padding: const EdgeInsets.all(0),
              children: [
                Row(
                  children: [
                    const CustomText(
                      text: "Maintain the app", 
                      size: 16, 
                      color: Colors.black, 
                      weight: FontWeight.normal
                    ),
                    Switch(
                      activeColor: AppColor.primary,
                      value: isSwitch, 
                      onChanged: (value){
                        setState(() {
                          isSwitch = value;
                        });
                        waitingDialog(context, updateMaintainToggle, "Saving Changes...");
                      }
                    )
                  ],
                )
              ]
            )
          ),
        ],
      ),
    );
  }
}

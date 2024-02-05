import 'package:admin_panel/constants/color.dart';
import 'package:admin_panel/pages/helpers/responsiveness.dart';
import 'package:admin_panel/pages/widgets/custom_text.dart';
import 'package:flutter/material.dart';

AppBar topNavigationBar(BuildContext context, GlobalKey<ScaffoldState> key) =>
    AppBar(
      leading: !ResponsiveWidget.isSmallScreen(context)
          ? Row(
              children: [
                Container(
                  padding: const EdgeInsets.only(left: 14),
                  child: const Icon(Icons.abc),
                )
              ],
            )
          : IconButton(
              onPressed: () {
                key.currentState?.openDrawer();
              },
              icon: const Icon(Icons.menu),
            ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      title: Row(
        children: [
          Visibility(
            child: CustomText(
              text: "Robot cafe",
              size: 16,
              color: AppColor.primary,
              weight: FontWeight.bold,
            ),
          ),
          Expanded(child: Container()),
          Stack(
            children: [
              IconButton(
                icon: Icon(
                  Icons.notifications,
                  color: AppColor.secondary,
                ),
                onPressed: () {},
              ),
              Positioned(
                top: 7,
                right: 7,
                child: Container(
                  width: 12,
                  height: 12,
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: AppColor.primary,
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(color: AppColor.white, width: 2),
                  ),
                ),
              ),
            ],
          ),
          IconButton(
            icon: Icon(
              Icons.settings,
              color: AppColor.secondary,
            ),
            onPressed: () {},
          ),
          Container(
            width: 1,
            height: 22,
            color: Colors.grey,
          ),
          const SizedBox(
            width: 24,
          ),
          CustomText(
            text: "Admin",
            size: 12,
            color: AppColor.secondary,
            weight: FontWeight.bold,
          ),
          const SizedBox(
            width: 16,
          ),
          Container(
            decoration: BoxDecoration(
              color: AppColor.white,
              borderRadius: BorderRadius.circular(30),
            ),
            child: Container(
              padding: const EdgeInsets.all(2),
              margin: const EdgeInsets.all(2),
              child: CircleAvatar(
                backgroundColor: AppColor.secondary.withOpacity(0.4),
                child: Icon(
                  Icons.person,
                  color: AppColor.secondary,
                ),
              ),
            ),
          ),
        ],
      ),
    );

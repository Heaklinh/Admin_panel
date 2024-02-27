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
          const Visibility(
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
                icon: const Icon(
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
            icon: const Icon(
              Icons.settings,
              color: AppColor.secondary,
            ),
            onPressed: () {},
          ),
          const SizedBox(
            width: 24,
          ),
          SizedBox(
            height: 36,
            child: Row(
              children: [
                CircleAvatar(
                  backgroundColor: AppColor.secondary.withOpacity(0.1),
                  child: const Icon(
                    Icons.person,
                    color: AppColor.secondary,
                    size: 24,
                  ),
                ),
                const CustomText(
                  text: "Admin",
                  size: 12,
                  color: AppColor.secondary,
                  weight: FontWeight.bold,
                ),
              ],
            ),
          ),
        ],
      ),
    );


import 'package:admin_panel/common/widgets/loader.dart';
import 'package:admin_panel/constants/color.dart';
import 'package:admin_panel/constants/show_snack_bar.dart';
import 'package:admin_panel/constants/waiting_dialog.dart';
import 'package:admin_panel/models/maintain_toggle.dart';
import 'package:admin_panel/models/user.dart';
import 'package:admin_panel/pages/helpers/responsiveness.dart';
import 'package:admin_panel/pages/orders/services/order_services.dart';
import 'package:admin_panel/pages/setting/services/setting_services.dart';
import 'package:admin_panel/pages/user/services/user_services.dart';
import 'package:admin_panel/pages/widgets/custom_text.dart';
import 'package:confirm_dialog/confirm_dialog.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';

class ManageUserPage extends StatefulWidget {
  const ManageUserPage({super.key});

  @override
  State<ManageUserPage> createState() => _ManageUserPageState();
}

class _ManageUserPageState extends State<ManageUserPage> {
  final TextEditingController textController = TextEditingController();

  List<User>? userList;
  MaintainToggle? maintainToggle;
  late User userData;

  final OrderServices orderServices = OrderServices();
  final SettingServices settingServices = SettingServices();
  final UserServices userServices = UserServices();
  
  fetchMaintainToggle() async {
    maintainToggle = await settingServices.fetchMaintainToggle(context: context, toggle: false);
    if(context.mounted){
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    fetchAllUsers();
    fetchMaintainToggle();
  }

  fetchAllUsers() async {
    userList = await userServices.fetchAllUsers(context);
    if(context.mounted){
      setState(() {});
    }
  }

  Future<void> deleteUser()async{
    await userServices.deleteUser(
      context: context,
      user: userData,
      onSuccess: handleUserChanges,
    );
    if(mounted){  
      Navigator.pop(context);
      showSnackBar(context, "User deleted successfully");
    }
  }

  void handleUserChanges() {
    fetchAllUsers();
  }

  // Future<void> deleteUser()async{
  //   await adminServices.deleteUser(
  //     context: context,
  //     user: user,
  //     onSuccess: handleUserDeleted,
  //   );
  //   if(!context.mounted) return;
  //   Navigator.pop(context);
  //   showSnackBar(context, "User deleted successfully");
  // }

  @override
  Widget build(BuildContext context) {

    DataRow buildDataRow(User user) {
      return DataRow(
        cells: [
          DataCell(
            user.profile == ""
              ? Icon(
                  Icons.person,
                  size: 40,
                  color: Colors.grey[500],
                )
              : Image.network(
                user.profile!,
                width: 38,
                fit: BoxFit.cover,
              ),
          ),
          DataCell(
            Text(
              user.name,
              style: const TextStyle(
                fontSize: 14,
              ),
            ),
          ),
          DataCell(
            Text(
              user.email,
              style: const TextStyle(
                  fontSize: 14),
            ),
          ),
          DataCell(
            Text(
              user.verified == true 
                ? "Verified" 
                : "Not Verified",
              style: const TextStyle(
                fontSize: 14,
              ),
            ),
          ),
          DataCell(
            Row(
              children: [
                IconButton(
                  onPressed: () async {
                    bool confirmLogout = await confirm(
                      context, 
                      title: const Text('Delete'), 
                      content:const Text('Are you sure you want to delete this user?')
                    );
                    if (confirmLogout) {
                      userData = user;
                      if(!context.mounted) return;
                      waitingDialog(context, deleteUser, "Deleting user");
                    }
                  },
                  icon: const Icon(
                    Icons.delete_outline,
                  ),
                ),
              ],
            )
            
          ),
        ],
      );
    }

    if(maintainToggle == null || userList == null){
      return const Loader();
    }else{
      
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  margin: EdgeInsets.only(
                      top: ResponsiveWidget.isSmallScreen(context) ? 56 : 6),
                  child: const CustomText(
                    text: "Manage User",
                    size: 24,
                    color: AppColor.secondary,
                    weight: FontWeight.bold,
                  ),
                ),
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
                size: 0,
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
                  ResponsiveWidget.isSmallScreen(context) 
                  ? Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SizedBox(
                        width: 150,
                        child: TextFormField(
                          onFieldSubmitted: (value) async {
                            if(value.trim().isNotEmpty){
                              waitingDialog(context, ()async{
                                userList = await userServices.fetchSearchUser(context: context, searchQuery: value);
                                if (userList != null && userList!.isNotEmpty) {
                                  setState(() {});
                                }
                                if(!context.mounted) return;
                                Navigator.pop(context);
                              }
                              , "Searching User...");
                            }else{     
                              waitingDialog(context, () async {
                                userList = await userServices.fetchAllUsers(context);
                                if(context.mounted){
                                  setState(() {});
                                }
                                if(!context.mounted) return;
                                Navigator.pop(context);
                              }, "Searching User...");
                            }
                          },
                          decoration: InputDecoration(
                              hintText: "Search user",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(4),
                              ),
                              suffixIcon: const Icon(Icons.search)),
                        ),
                      ),
                    ]
                  )
                  : Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SizedBox(
                        width: 300,
                        child: TextFormField(
                          onFieldSubmitted: (value) async {
                            if(value.trim().isNotEmpty){
                              waitingDialog(context, ()async{
                                userList = await userServices.fetchSearchUser(context: context, searchQuery: value);
                                if (userList != null && userList!.isNotEmpty) {
                                  setState(() {});
                                }
                                if(!context.mounted) return;
                                Navigator.pop(context);
                              }
                              , "Searching User...");
                            }else{     
                              waitingDialog(context, () async {
                                userList = await userServices.fetchAllUsers(context);
                                if(context.mounted){
                                  setState(() {});
                                }
                                if(!context.mounted) return;
                                Navigator.pop(context);
                              }, "Searching User...");
                            }
                          },
                          decoration: InputDecoration(
                              hintText: "Search user",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(4),
                              ),
                              suffixIcon: const Icon(Icons.search)),
                        ),
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: 20),
                  
                  Container(
                    padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
                    margin: const EdgeInsets.only(bottom: 30),
                    decoration: BoxDecoration(
                      color: AppColor.white,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          offset: const Offset(0, 6),
                          color: AppColor.disable.withOpacity(.1),
                          blurRadius: 12,
                        )
                      ],
                      border: Border.all(
                        color: AppColor.disable,
                        width: .5,
                      ),
                    ),
                    child: Column(
                      children: [
                        SizedBox(
                          height: ResponsiveWidget.isSmallScreen(context) ? (56 * 5) + 100 : (56 * 7) + 40 ,
                          child: DataTable2(
                            columnSpacing: 20,
                            horizontalMargin: 12,
                            minWidth: 900,
                            dataRowHeight: 70,
                            columns: const [
                              DataColumn2(
                                label: Text(
                                  'Profile',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                size: ColumnSize.S,
                              ),
                              DataColumn2(
                                label: Text(
                                  'Name',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                size: ColumnSize.S,
                              ),
                              DataColumn2(
                                label: Text(
                                  'Email',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                size: ColumnSize.L,
                              ),
                              DataColumn2(
                                label: Text(
                                  'Verification',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                size: ColumnSize.S,
                              ),
                              DataColumn2(
                                label: Text(
                                  'Action',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                            // rows: userList!.map((user) => buildDataRow(user)).toList(),
                            rows: userList!.where((user) => user.type != "admin").map((filteredUser) => buildDataRow(filteredUser)).toList(),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              )
            ),
          ],
        ),
      );
    }
  }
}

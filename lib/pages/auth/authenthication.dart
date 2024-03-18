import 'package:admin_panel/constants/color.dart';
import 'package:admin_panel/pages/drink/widgets/custom_text_input.dart';
import 'package:admin_panel/services/admin_services.dart';
import 'package:flutter/material.dart';

class AuthenticationPage extends StatefulWidget {
  static const routeName = "/authentication";
  const AuthenticationPage({super.key});

  @override
  State<AuthenticationPage> createState() => _AuthenticationPageState();
}

class _AuthenticationPageState extends State<AuthenticationPage> {
  final _formKey = GlobalKey<FormState>();
  // final TextEditingController textController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  bool _isSubmitted = false;
  final AdminServices authService = AdminServices();

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _nameController.dispose();
  }

  void signInUser() {
    authService.signInUser(
      context: context,
      email: _emailController.text,
      password: _passwordController.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            color: AppColor.white,
            constraints: const BoxConstraints(maxWidth: 400),
            padding: const EdgeInsets.all(24),
            margin: EdgeInsets.symmetric(vertical: height / 5),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 12),
                        child: Image.asset(
                          "assets/images/Robot Cafe Logo.png",
                        ),
                      ),
                      Expanded(
                        child: Row(
                          children: [
                            RichText(
                              text: const TextSpan(
                                children: [
                                  TextSpan(
                                    text: "ROBOT",
                                    style: TextStyle(
                                      color: AppColor.secondary,
                                      fontFamily: 'CADTMonoDisplay',
                                      fontSize: 32,
                                    ),
                                  ),
                                  TextSpan(
                                    text: "CAFE",
                                    style: TextStyle(
                                      color: AppColor.primary,
                                      fontFamily: 'CADTMonoDisplay',
                                      fontSize: 32,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 14,
                  ),
                  // const Row(
                  //   crossAxisAlignment: CrossAxisAlignment.start,
                  //   children: [
                  //     CustomText(
                  //         text: "Welcome back to the admin panel",
                  //         size: 16,
                  //         color: AppColor.secondary,
                  //         weight: FontWeight.normal)
                  //   ],
                  // ),
                  const SizedBox(
                    height: 8,
                  ),
                  CustomTextInput(
                    controller: _emailController,
                    hintText: "Email",
                    icon: Icons.email,
                    isSubmitted: _isSubmitted,
                    label: "Email Address",
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  CustomTextInput(
                    controller: _passwordController,
                    hintText: "Password",
                    icon: Icons.password,
                    isSubmitted: _isSubmitted,
                    label: "Password",
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size.fromHeight(50),
                      backgroundColor: AppColor.primary,
                      shape: const BeveledRectangleBorder(
                          // side: BorderSide(color: Colors.blue), if you need
                          borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(10.0))),
                    ),
                    onPressed: () {
                      setState(() {
                        _isSubmitted = true;
                      });
                      if (_formKey.currentState!.validate()) {
                        signInUser();
                      }
                    },
                    child: const Text(
                      "Sign In",
                      style: TextStyle(color: AppColor.white),
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  const Text(
                    "Don't have an account? Request Credential Here",
                    style: TextStyle(
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

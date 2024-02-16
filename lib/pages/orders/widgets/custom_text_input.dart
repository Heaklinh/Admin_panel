import 'package:admin_panel/constants/color.dart';
import 'package:flutter/material.dart';

class CustomTextInput extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final int maxLines;

  const CustomTextInput({
    super.key,
    required this.controller,
    required this.hintText,
    this.maxLines = 1,
  });

  @override
  State<CustomTextInput> createState() => _CustomTextInputState();
}

class _CustomTextInputState extends State<CustomTextInput> {
  //bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: AppColor.secondary,
            width: 1.0,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            controller: widget.controller,
            // obscureText: widget.hintText.toLowerCase().contains('password')
            //     ? _obscureText
            //     : false,
            validator: (value) {
              if (widget.hintText.toLowerCase().contains('username')) {
                if (value!.isEmpty) {
                  return "Please enter a username";
                }
                if (value.length < 3) {
                  return "Username must contain at least 3 character";
                }
                if (RegExp(r'[^\w\s]').hasMatch(value)) {
                  return "Username must not contain any special character";
                }
              }
              if (widget.hintText.toLowerCase().contains('email')) {
                if (value!.isEmpty) {
                  return "Please enter an email";
                }
                if (!RegExp(
                        r'^(([^<>()[\]\.,;:\s@\"]+(\.[^<>()[\]\.,;:\s@\"]+)*)|(\".+\"))@(([^<>()[\]\.,;:\s@\"]+\.)+[^<>()[\]\.,;:\s@\"]{2,})$',
                        caseSensitive: false)
                    .hasMatch(value)) {
                  return "Please enter a valid email";
                }
              }
              if (widget.hintText.toLowerCase().contains('password')) {
                if (value == null || value.isEmpty) {
                  return "Please enter a password";
                }
                if (value.length < 8) {
                  return "Password must be at least 8 characters";
                }
                if (!RegExp(r'[a-z]').hasMatch(value)) {
                  return "Password should contain at least one lowercase letter";
                }

                if (!RegExp(r'[A-Z]').hasMatch(value)) {
                  return "Password should contain at least one uppercase letter";
                }
                if (!RegExp(r'[^\w\s]').hasMatch(value)) {
                  return "Password should contain at least one special character (!@#\$%^&*)";
                }
              }

              return null;
            },
            autovalidateMode: AutovalidateMode.onUserInteraction,
            decoration: InputDecoration(
              hintText: widget.hintText,
              hintStyle: TextStyle(color: Colors.grey[400]),
              border: InputBorder.none,
              // prefixIcon: Container(
              //   padding: const EdgeInsets.all(4.0),
              //   margin: const EdgeInsets.only(left: 4.0, right: 12.0),
              //   decoration: BoxDecoration(
              //     shape: BoxShape.circle,
              //     color:
              //         const Color.fromARGB(255, 30, 30, 30).withOpacity(0.08),
              //   ),
              //   child: Icon(
              //     widget.icon,
              //     color: AppColor.secondary,
              //     size: 20,
              //   ),
              // ),
              // suffixIcon: widget.hintText.toLowerCase().contains('password')
              //     ? IconButton(
              //         icon: Icon(_obscureText
              //             ? Icons.visibility_off
              //             : Icons.visibility),
              //         onPressed: () {
              //           setState(() {
              //             _obscureText = !_obscureText;
              //           });
              //         },
              //       )
              //     : null,
            ),
            maxLines: widget.maxLines,
          ),
        ],
      ),
    );
  }
}

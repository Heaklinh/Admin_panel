import 'package:admin_panel/constants/color.dart';
import 'package:flutter/material.dart';

class CustomTextInput extends StatefulWidget {
  final IconData icon;
  final TextEditingController controller;
  final String hintText;
  final int maxLines;
  final bool isSubmitted;
  final bool isEdit;
  final String existingText;
  final String label;
  const CustomTextInput(
      {super.key,
      required this.controller,
      required this.hintText,
      this.maxLines = 1,
      required this.icon,
      required this.isSubmitted,
      this.isEdit = false,
      this.existingText = "",
      this.label = '',
      });

  @override
  State<CustomTextInput> createState() => _CustomTextInputState();
}

class _CustomTextInputState extends State<CustomTextInput> {
  bool _obscureText = true;
  bool _isClearVisible = false;
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller;
    _controller.text = widget.existingText;
  }

  bool validateEmail(String email) {
    // Use a regular expression to validate the email format
    final RegExp emailRegex = RegExp(
      r'^(([^<>()[\]\.,;:\s@\"]+(\.[^<>()[\]\.,;:\s@\"]+)*)|(\".+\"))@'
      r'(([^<>()[\]\.,;:\s@\"]+\.)+[^<>()[\]\.,;:\s@\"]{2,})$',
      caseSensitive: false,
    );

    return emailRegex.hasMatch(email);
  }

  @override
  Widget build(BuildContext context) {
    double width = 300;
    return SizedBox(
      width: width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            textInputAction: TextInputAction.next,
            controller: widget.isEdit ? _controller : widget.controller,
            obscureText: widget.hintText.toLowerCase().contains('password')
                ? _obscureText
                : false,
            onChanged: (value) {
              setState(() {
                _isClearVisible = value.trim().isNotEmpty;
              });
            },
            onEditingComplete: () {
              FocusScope.of(context)
                  .nextFocus(); // Move focus to the next field
            },
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
                if (!validateEmail(value?.trim() ?? '')) {
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
                  return "Password should contain at least one uppercase";
                }
                if (!RegExp(r'[^\w\s]').hasMatch(value)) {
                  return "Password should contain at least one special character (!@#\$%^&*)";
                }
              }

              return null;
            },
            style: const TextStyle(color: AppColor.secondary, fontSize: 14),
            cursorColor: AppColor.secondary,
            autovalidateMode: widget.isSubmitted
                ? AutovalidateMode.always
                : AutovalidateMode.disabled,
            decoration: InputDecoration(
              labelText: widget.label,
              labelStyle: const TextStyle(color: AppColor.secondary),
              hintText: widget.hintText,
              border: const OutlineInputBorder(),
              focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(
                    color: AppColor.secondary), // Set your desired color here
              ),
              contentPadding: const EdgeInsets.symmetric(
                vertical: 16.0, // Adjust the vertical padding as needed
                horizontal: 24.0, // Adjust the horizontal padding as needed
              ),
              hintStyle: TextStyle(color: Colors.grey[400]),
              suffixIcon: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (_isClearVisible)
                    IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: () {
                        setState(() {
                          widget.controller.clear();
                          _isClearVisible = false;
                        });
                      },
                    ),
                  if (widget.hintText.toLowerCase().contains('password'))
                    IconButton(
                      icon: Icon(_obscureText
                          ? Icons.visibility_off
                          : Icons.visibility),
                      onPressed: () {
                        setState(() {
                          _obscureText = !_obscureText;
                        });
                      },
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

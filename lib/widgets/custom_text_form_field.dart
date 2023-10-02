import 'package:flutter/material.dart';
import 'package:todo_app/home/my_theme.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    required this.text,
    this.suffixIcon,
    this.prefixIcon,
    this.isNotVisible = false,
    this.validator,
    required this.keyboardType,
    required this.controller,
    this.onSuffixPressed,
    this.onFieldSubmitted,
  });
  final String text;
  final IconData? suffixIcon;
  final IconData? prefixIcon;
  final bool isNotVisible;
  final String? Function(String?)? validator;
  final TextInputType keyboardType;
  final TextEditingController controller;
  final void Function()? onSuffixPressed;
  final void Function(String)? onFieldSubmitted;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: TextFormField(
        controller: controller,
        validator: validator,
        decoration: InputDecoration(
          focusedBorder: createOutlineInputBorder(),
          enabledBorder: createOutlineInputBorder(),
          border: createOutlineInputBorder(),
          labelText: text,
          suffixIcon: IconButton(
            onPressed: onSuffixPressed,
            icon: Icon(suffixIcon),
          ),
          prefixIcon: Icon(prefixIcon),
        ),
        obscureText: isNotVisible,
        keyboardType: keyboardType,
        onFieldSubmitted: onFieldSubmitted,
      ),
    );
  }

  OutlineInputBorder createOutlineInputBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide(
        color: MyTheme.primaryLight,
        width: 4,
      ),
    );
  }
}

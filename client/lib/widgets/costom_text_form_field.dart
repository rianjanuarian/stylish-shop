import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    required this.onTapOutside,
    required this.controller,
    this.keyboardType,
    this.validator,
    this.onChanged,
    this.obscureText = false,
    this.hintText,
    this.prefix,
    this.suffix,
    this.isDense = false,
    this.enabledBorder,
    this.border,
    this.focusedBorder,
    this.contentPadding,
  });

  final TapRegionCallback? onTapOutside;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final ValueChanged<String>? onChanged;
  final bool obscureText;
  final String? hintText;
  final Icon? prefix;
  final IconButton? suffix;
  final bool isDense;
  final InputBorder? enabledBorder;
  final InputBorder? border;
  final InputBorder? focusedBorder;
  final EdgeInsetsGeometry? contentPadding;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTapOutside: onTapOutside,
      controller: controller,
      keyboardType: keyboardType,
      validator: validator,
      onChanged: onChanged,
      decoration: InputDecoration(
        contentPadding: contentPadding ?? EdgeInsets.zero,
        isDense: isDense,
        hintText: hintText,
        prefixIcon: prefix,
        suffixIcon: suffix,
        enabledBorder: enabledBorder,
        border: border,
        focusedBorder: focusedBorder,
      ),
      obscureText: obscureText,
    );
  }
}

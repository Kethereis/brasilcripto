import 'package:brasilcripto/core/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class InputTextWidget extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final double elevation;
  final FocusNode? focusNode;
  final TextEditingController? controller;
  final void Function()? onTap;
  final void Function(String)? onChanged;

  const InputTextWidget({
    super.key,
    required this.hintText,
    required this.icon,
    required this.elevation,
    this.focusNode,
    this.controller,
    this.onTap,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: ColorsConstants.primaryColor,
        surfaceTintColor: ColorsConstants.primaryColor,
        elevation: elevation,
        child: TextField(
          onTap: onTap,
          controller: controller,
          onChanged: onChanged,
          focusNode: focusNode,
          decoration: InputDecoration(
            prefixIcon: Icon(icon, color: Colors.grey,),
            hintText: hintText,
            labelText: hintText,
            border: InputBorder.none,
            contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 5),
      ),
    ));
  }
}

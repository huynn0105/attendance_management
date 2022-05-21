import 'package:attendance_management/utils/style_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyTextFormField extends StatelessWidget {
  final String? lable;
  final TextEditingController? controller;
  final TextInputType? textInputType;
  final List<TextInputFormatter>? inputFormatters;
  final bool obscureText;
  final FormFieldValidator<String>? validator;
  final double? width;
  final bool readOnly;
  final Widget? suffixIcon;
  final VoidCallback? onTap;
  const MyTextFormField({
    Key? key,
    this.lable,
    this.controller,
    this.textInputType,
    this.inputFormatters,
    this.obscureText = false,
    this.validator,
    this.width,
    this.readOnly = false,
    this.suffixIcon,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (lable != null)
          Text(
            lable!,
            style: TextStyleUtils.regular(22).copyWith(color: Colors.black),
          ),
        const SizedBox(height: 7),
        SizedBox(
          width: width ?? 450,
          child: TextFormField(
            readOnly: readOnly,
            keyboardType: textInputType,
            onTap: onTap,
            controller: controller,
            validator: validator,
            style: TextStyleUtils.regular(22),
            obscureText: obscureText,
            decoration: InputDecoration(
              hintText: lable,
              suffixIcon: suffixIcon,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
              ),
            ),
            inputFormatters: inputFormatters,
          ),
        ),
      ],
    );
  }
}

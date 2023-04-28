import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../constants/color_constants.dart';

import '../utils/math_utils.dart';

class InputTextField extends StatelessWidget {
  final bool? enable;
  final String? initialValue;
  final String? labelText;
  final String? hintText;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final String? Function(String?)? validator;
  final Function(String)? onFieldSubmitted;
  final Color? textColor;
  final TextEditingController controller;
  final TextInputType? textInputType;
  final int? errorMaxLines;
  final int maxLines;
  final int? minLines;
  final EdgeInsets? contentPadding;
  final Function()? onTap;
  final TextInputAction textInputAction;
  final String? errorText;
  final bool isSecure;
  final Function(String)? onChanged;
  final List<TextInputFormatter>? inputFormatters;
  final TextCapitalization? textCapitalization;
  final String? prefixText;
  final int? maxLength;
  final bool readOnly;
  final bool? enableInteractiveSelection;
  final Function(String?)? onSaved;

  const InputTextField({
    Key? key,
    this.initialValue,
    this.labelText,
    this.hintText,
    this.prefixIcon,
    this.suffixIcon,
    this.validator,
    this.textColor,
    required this.controller,
    this.textInputType,
    this.errorMaxLines,
    this.maxLines = 1,
    this.contentPadding,
    this.onTap,
    this.textInputAction = TextInputAction.next,
    this.errorText,
    this.isSecure = false,
    this.enable = true,
    this.readOnly = false,
    this.onChanged,
    this.inputFormatters,
    this.prefixText,
    this.maxLength,
    this.minLines,
    this.onFieldSubmitted,
    this.textCapitalization,
    this.enableInteractiveSelection,
    this.onSaved,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _buildStackContainer();
  }

  _buildStackContainer() {
    return Stack(
      children: [
        TextFormField(
          enableInteractiveSelection: enableInteractiveSelection,
          inputFormatters: inputFormatters,
          enabled: enable,
          initialValue: initialValue,
          maxLength: maxLength,
          controller: controller,
          onTap: onTap,
          cursorColor: ColorConstants.white.withOpacity(0.6),
          textAlignVertical: TextAlignVertical.center,
          keyboardType: textInputType ?? TextInputType.text,
          maxLines: maxLines,
          minLines: minLines ?? 1,
          obscureText: isSecure,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          textInputAction: textInputAction,
          onChanged: onChanged,
          readOnly: readOnly,
          style: TextStyle(
            debugLabel: labelText,
            color: Colors.white,
            fontSize: getFontSize(14),
            fontWeight: FontWeight.w500,
            fontFamily: "Inter",
          ),
          decoration: InputDecoration(
            //  alignLabelWithHint: true,
            labelText: labelText,
            errorText: errorText,
            counterText: "",
            focusColor: ColorConstants.white,
            isDense: true,
            contentPadding: contentPadding ??
                EdgeInsets.symmetric(
                  vertical: getSize(18),
                  horizontal: getSize(16),
                ),
            hintText: hintText,
            fillColor: ColorConstants.white.withOpacity(0.1),
            errorMaxLines: errorMaxLines ?? 1,
            filled: true,
            prefixIconConstraints: BoxConstraints(maxHeight: getSize(50)),
            suffixIconConstraints: BoxConstraints(maxHeight: getSize(50)),
            labelStyle: TextStyle(
                fontSize: getFontSize(14),
                fontWeight: FontWeight.w400,
                letterSpacing: 0.5,
                fontFamily: "Inter",
                color: textColor ?? ColorConstants.white),
            hintStyle: TextStyle(
              fontFamily: "Inter",
              fontSize: getFontSize(12),
              fontWeight: FontWeight.w400,
              letterSpacing: 0.5,
              color: ColorConstants.white.withOpacity(0.6),
            ),
            prefixIcon: Padding(
              padding: EdgeInsets.symmetric(horizontal: getSize(16)),
              child: prefixIcon,
            ),
            suffixIcon: suffixIcon,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(
                getSize(50),
              ),
              borderSide: BorderSide(
                color: Colors.transparent,
              ),
            ),
            enabled: true,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(
                getSize(50),
              ),
              borderSide: BorderSide(
                color: Colors.transparent,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(
                getSize(50),
              ),
              borderSide: BorderSide(
                color: Colors.transparent,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(
                getSize(50),
              ),
              borderSide: BorderSide(
                color: Colors.transparent,
              ),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(
                getSize(50),
              ),
              borderSide: BorderSide(
                color: Colors.transparent,
              ),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(
                getSize(50),
              ),
              borderSide: BorderSide(
                color: Colors.transparent,
              ),
            ),
          ),
          onFieldSubmitted: onFieldSubmitted,
          onSaved: onSaved,
          validator: validator,
          textCapitalization: textCapitalization ?? TextCapitalization.none,
        ),
      ],
    );
  }
}

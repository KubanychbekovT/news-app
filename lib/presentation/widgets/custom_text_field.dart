import 'package:flutter/material.dart';
import 'package:news_app/infrastructure/configs/app_dimensions.dart';
import 'package:news_app/infrastructure/configs/app_theme.dart';

import '../../infrastructure/configs/app_typography.dart';
import '../../infrastructure/configs/space.dart';

class CustomTextField extends StatefulWidget {
  final TextInputType? textInputType;
  final TextInputAction? textInputAction;
  final TextEditingController? controller;
  final bool? enabled;
  final FocusNode? node;
  final String? hint;
  final double? width;
  final bool? isPass;
  final Widget? prefixIcon;
  final String? initialValue;

  final FormFieldValidator? validatorFtn;
  final Function? onEditComplete;
  final Function(String)? onFieldSubmit;
  final String? errorText;
  final String? Function(String?)? onChangedFtn;

  const CustomTextField(
      {Key? key,
      required this.textInputType,
      this.textInputAction = TextInputAction.done,
      this.controller,
      this.enabled,
      this.node,
      required this.hint,
      this.width = double.infinity,
      this.prefixIcon,
      this.initialValue,
      this.validatorFtn,
      this.onEditComplete,
      this.onFieldSubmit,
      this.errorText,
      this.onChangedFtn,
      this.isPass = false})
      : super(key: key);

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: AppDimensions.normalize(250),
      child: TextFormField(
        enabled: widget.enabled ?? true,
        initialValue: widget.initialValue,
        controller: widget.controller,
        autofocus: false,
        textInputAction: widget.textInputAction,
        keyboardType: widget.textInputType,
        focusNode: widget.node,
        decoration: InputDecoration(
          errorText: widget.errorText,
          prefixIcon: widget.prefixIcon,
          filled: true,
          contentPadding: Space.all(0.75, 0.9),
          hintText: widget.hint,
          hintStyle: AppText.b2!.copyWith(
            color: AppTheme.c!.textSub,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide(
              width: AppDimensions.normalize(0.75),
              color: AppTheme.c!.textSub!.withAlpha(100),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide(
              color: AppTheme.c!.textSub!,
              width: AppDimensions.normalize(0.75),
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide(
              width: AppDimensions.normalize(0.75),
              color: Colors.red.withAlpha(200),
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide(
              width: AppDimensions.normalize(0.75),
              color: AppTheme.c!.textSub!.withAlpha(100),
            ),
          ),
        ),
        validator: widget.validatorFtn,
        onChanged: widget.onChangedFtn,
      ),
    );
  }
}

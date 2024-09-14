import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField({
    super.key,
    this.controller,
    this.errorMessage,
    this.keyboardType,
    this.obscureText,
    this.textCapitalization,
    this.onTap,
    this.readOnly,
    this.maxLines,
    this.textInputAction,
    this.hint,
    this.autoFocus,
    this.enabled,
    this.maxLength,
    this.passwordField = false,
    this.suffix,
    this.prefix,
    this.validator,
    this.style,
    this.focusNode,
    this.onFieldSubmitted,
    this.inputFormatter,
    this.onChanged,
    this.autoFillHints,
    this.errorStyle,
    this.suffixIcon,
    this.prefixIcon,
  });
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final bool? obscureText;
  final String? errorMessage;
  final TextCapitalization? textCapitalization;
  final bool? readOnly;
  final Function? onTap;
  final int? maxLines;
  final bool? autoFocus;
  final String? hint;
  final TextInputAction? textInputAction;
  final bool? enabled;
  final int? maxLength;
  final Widget? suffix;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final Widget? prefix;
  final TextStyle? style;
  final bool passwordField;
  final Function(String)? onChanged;
  final Function(String)? onFieldSubmitted;
  final FocusNode? focusNode;
  final List<TextInputFormatter>? inputFormatter;
  final Iterable<String>? autoFillHints;
  final TextStyle? errorStyle;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  String errorText = '';

  @override
  Widget build(BuildContext context) {
    final kSize = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.only(bottom: kSize.height * 0.02),
      child: TextFormField(
        validator: widget.validator,
        obscureText: widget.obscureText ?? false,
        obscuringCharacter: "*",
        autovalidateMode: AutovalidateMode.onUserInteraction,
        style: const TextStyle(color: Colors.black, fontSize: 14),
        onChanged: widget.onChanged,
        textInputAction: widget.textInputAction,
        onFieldSubmitted: widget.onFieldSubmitted,
        decoration: InputDecoration(
            suffix: widget.suffix,
            suffixIcon: widget.suffixIcon,
            prefix: widget.prefix,
            prefixIcon: widget.prefixIcon,
            focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0), borderSide: const BorderSide(color: Colors.red)),
            errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0), borderSide: const BorderSide(color: Colors.red)),
            disabledBorder:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10.0), borderSide: BorderSide.none),
            helperText: widget.errorMessage ?? '',
            hintText: widget.hint,
            hintStyle: TextStyle(color: Theme.of(context).primaryColor),
            errorText: widget.errorMessage,
            enabledBorder:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10.0), borderSide: BorderSide.none),
            errorStyle: const TextStyle(color: Colors.red),
            isDense: true,
            counterText: "",
            counter: const SizedBox(),
            contentPadding: const EdgeInsets.all(16.0),
            filled: true,
            fillColor: Colors.white,
            focusedBorder:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10.0), borderSide: BorderSide.none),
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10.0), borderSide: BorderSide.none)),
        maxLines: widget.maxLines ?? 1,
        maxLength: widget.maxLength,
        controller: widget.controller,
      ),
    );
  }
}

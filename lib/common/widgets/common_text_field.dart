import 'package:coonch/utils/constants/colors.dart';
import 'package:coonch/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../utils/constants/theme_constants.dart';

class CommonTextField extends StatefulWidget {
  const CommonTextField({
    required this.controller,
    this.textInputAction = TextInputAction.next,
    this.hint,
    this.isObscureText = false,
    this.keyboardType = TextInputType.text,
    this.icon,
    this.onTap,
    this.onChanges,
    this.suffixIcon,
    this.fillColor,
    this.textInputFormatter,
    this.maxLines = 1,
    super.key,
  });

  final TextEditingController controller;
  final TextInputAction? textInputAction;
  final String? hint;
  final bool isObscureText;
  final IconData? icon;
  final Function()? onTap;
  final Function(String)? onChanges;
  final TextInputType? keyboardType;
  final String? suffixIcon;
  final Color? fillColor;
  final List<TextInputFormatter>? textInputFormatter;
  final int? maxLines;

  @override
  State<CommonTextField> createState() => _CommonTextFieldState();
}

class _CommonTextFieldState extends State<CommonTextField> {
  final FocusNode _focus = FocusNode();

  @override
  void initState() {
    super.initState();
    _focus.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      maxLines: widget.maxLines,
      scrollPadding: const EdgeInsets.only(bottom: 40),
      textCapitalization: TextCapitalization.sentences,
      inputFormatters: widget.textInputFormatter,
      obscureText: widget.isObscureText,
      focusNode: _focus,
      style: TextStyle(
        color: (Theme.of(context).brightness == Brightness.dark
            ? ThemeColors.clrWhite
            : ThemeColors.clrBlack),
        // fontWeight: FontWeight.w400,
        // fontSize: MSizes.md,
      ),

      cursorColor: (Theme.of(context).brightness == Brightness.dark
          ? ThemeColors.clrWhite
          : ThemeColors.clrBlack),
      textInputAction: widget.textInputAction,
      keyboardType: widget.keyboardType,
      onChanged: widget.onChanges,
      decoration: InputDecoration(
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(MSizes.borderRadiusLg),
          ),
          borderSide: BorderSide(width: 1,
            color: MColors.textFieldBorder,
          ),
        ),
        // border: InputBorder.none,
        // filled: true,
        // fillColor: widget.fillColor ?? ThemeColors.clrWhite.withOpacity(0.15),
        // focusedBorder: OutlineInputBorder(
        //   borderSide: const BorderSide(color: MColors.black),
        //   borderRadius: BorderRadius.circular(MSizes.borderRadiusLg),
        // ),
        // enabledBorder: OutlineInputBorder(
        //   borderSide: const BorderSide(color: MColors.textFieldBorder),
        //   borderRadius: BorderRadius.circular(MSizes.borderRadiusLg),
        // ),
        suffixIcon: widget.suffixIcon != null || widget.icon != null
            ? UnconstrainedBox(
                child: InkWell(
                  onTap: widget.onTap,
                  child: widget.icon != null
                      ? Icon(
                          widget.icon,
                          size: 24,
                          color: _focus.hasFocus
                              ? MColors.black
                              : MColors.darkGrey,
                        )
                      : Image.asset(
                          widget.suffixIcon!,
                          height: 24,
                          width: 24,
                          color: _focus.hasFocus
                              ? MColors.black
                              : MColors.darkGrey,
                        ),
                ),
              )
            : null,
        // contentPadding:
        //     const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        // isDense: true,
        hintText: widget.hint,
        // hintStyle: TextStyle(
        //   fontWeight: FontWeight.w400,
        //   fontSize: MSizes.md,
        //   color: (
        //     Theme.of(context).brightness == Brightness.dark
        //         ? ThemeColors.clrWhite
        //         : ThemeColors.clrGrey
        //   ),
        // ),
      ),
    );
  }
}

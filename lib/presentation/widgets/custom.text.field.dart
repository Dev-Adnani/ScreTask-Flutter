import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scretask/core/util/obscure.text.util.dart';
import 'package:scretask/presentation/widgets/custom.styles.dart';

class CustomTextField {
  static customTextField({
    required hintText,
    TextEditingController? textEditingController,
    TextInputType? inputType,
    bool? enabled,
    int? maxLength,
    int? minLines,
    int? maxLines,
    String? initialValue,
    String? Function(String?)? validator,
    Function(String)? onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextFormField(
        enabled: enabled,
        onChanged: onChanged,
        maxLength: maxLength,
        minLines: minLines,
        maxLines: maxLines,
        controller: textEditingController,
        validator: validator,
        initialValue: initialValue,
        style: kBodyText.copyWith(color: Colors.black),
        keyboardType: inputType,
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(20),
          hintText: hintText,
          hintStyle: kBodyText,
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Colors.grey,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(18),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Colors.black,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(18),
          ),
        ),
      ),
    );
  }

  static customPasswordField({
    required BuildContext context,
    required onTap,
    required TextEditingController textEditingController,
    String? Function(String?)? validator,
    Function(String)? onChanged,
  }) {
    final bool isPasswordVisible =
        Provider.of<ObscureTextUtil>(context, listen: true).isTrue;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextFormField(
        controller: textEditingController,
        validator: validator,
        onChanged: onChanged,
        style: kBodyText.copyWith(
          color: Colors.black,
        ),
        obscureText: isPasswordVisible,
        keyboardType: TextInputType.text,
        textInputAction: TextInputAction.done,
        decoration: InputDecoration(
          suffixIcon: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: IconButton(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onPressed: onTap,
              icon: Icon(
                isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                color: Colors.grey,
              ),
            ),
          ),
          contentPadding: const EdgeInsets.all(20),
          hintText: 'Password',
          hintStyle: kBodyText,
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Colors.grey,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(18),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Colors.black,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(18),
          ),
        ),
      ),
    );
  }
}

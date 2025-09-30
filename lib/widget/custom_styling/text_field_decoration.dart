// Reusable InputDecoration for consistent styling
import 'package:flutter/material.dart';

import '../../core/theme/colours/app_colors.dart';
import 'm_text_style.dart';

InputDecoration buildInputDecoration(String label, IconData icon) {
  return InputDecoration(
    label: Text(label, style: mTextStyle12()),
    filled: true,
    fillColor: AppColors.white,
    prefixIcon: Icon(icon, size: 20,),
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.0)),
    contentPadding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
  );
}

/*Padding buildInputDecoration({
  required TextEditingController controller,
  required String label,
  required String? error,
  required IconData icon,
  bool isPassword = false,
  bool obscureText = false,
  TextInputType keyboardType = TextInputType.text,
  VoidCallback? toggleVisibility,
  VoidCallback? onChanged,
}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 6),
    child: TextField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      onChanged: (_) => onChanged?.call(),
      decoration: InputDecoration(
        labelText: label,
        hintText: label,
        errorText: error,
        prefixIcon: Icon(icon),
        suffixIcon:
            isPassword
                ? IconButton(
                  icon: Icon(
                    obscureText ? Icons.visibility_off : Icons.visibility,
                  ),
                  onPressed: toggleVisibility,
                )
                : null,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
      ),
    ),
  );
}*/

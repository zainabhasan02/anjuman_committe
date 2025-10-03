import 'package:flutter/material.dart';

import '../../core/theme/colours/app_colors.dart';
import 'm_text_style.dart';

class MRoundedButton extends StatelessWidget {
  final String btnName;
  final VoidCallback onPressed;
  final double fontSize;
  final EdgeInsetsGeometry padding;
  final bool isLoading;
  final Color bgColor;
  final Color fgColor;
  final double height, width;

  const MRoundedButton({
    super.key,
    required this.btnName,
    required this.onPressed,
    this.bgColor = AppColors.limeStoned,
    this.fgColor = Colors.black, // Yellow.shade100
    this.fontSize = 18,
    this.padding = const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
    this.isLoading = false,
    this.height = 45,
    this.width = double.infinity
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.0),
          gradient: LinearGradient(
            colors: [AppColors.pastelYellow, AppColors.limeStoned],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(child: Text(btnName, style: mTextStyle18(mFontWeight: FontWeight.bold)),),
      ),
    );
    /*return ElevatedButton(
      onPressed: isLoading ? null : onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: bgColor,
        foregroundColor: fgColor,
        padding: padding,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        textStyle: mTextStyle18(mFontWeight: FontWeight.bold),
      ),
      child:
          isLoading
              ? const SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(
                  strokeWidth: 2.5,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              )
              : Text(btnName),
    );*/
  }
}

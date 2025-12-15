import 'package:flutter/material.dart';

/// Custom button widget with consistent styling
class CustomButton extends StatelessWidget {
  const CustomButton({
    required this.onPressed,
    required this.text,
    this.isLoading = false,
    this.isOutlined = false,
    this.icon,
    this.width,
    this.height,
    super.key,
  });

  final VoidCallback? onPressed;
  final String text;
  final bool isLoading;
  final bool isOutlined;
  final IconData? icon;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    final buttonContent = Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (icon != null && !isLoading) ...[
          Icon(icon, size: 20),
          const SizedBox(width: 8),
        ],
        if (isLoading)
          const SizedBox(
            width: 20,
            height: 20,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            ),
          )
        else
          Text(text),
      ],
    );

    return SizedBox(
      width: width ?? double.infinity,
      height: height ?? 56,
      child: isOutlined
          ? OutlinedButton(
              onPressed: isLoading ? null : onPressed,
              child: buttonContent,
            )
          : ElevatedButton(
              onPressed: isLoading ? null : onPressed,
              child: buttonContent,
            ),
    );
  }
}

import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';

class AppButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final bool isLoading;
  final bool isOutlined;
  final Color? color;
  final IconData? icon;
  final double? width;

  const AppButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.isLoading = false,
    this.isOutlined = false,
    this.color,
    this.icon,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    final buttonColor = color ?? AppColors.primary;

    if (isOutlined) {
      return SizedBox(
        width: width ?? double.infinity,
        height: 54,
        child: OutlinedButton(
          onPressed: isLoading ? null : onPressed,
          style: OutlinedButton.styleFrom(
            foregroundColor: buttonColor,
            side: BorderSide(color: buttonColor, width: 1.5),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
          ),
          child: _ButtonContent(label: label, icon: icon, isLoading: isLoading, color: buttonColor),
        ),
      );
    }

    return SizedBox(
      width: width ?? double.infinity,
      height: 54,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: buttonColor,
          foregroundColor: Colors.white,
          disabledBackgroundColor: buttonColor.withOpacity(0.5),
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        ),
        child: _ButtonContent(label: label, icon: icon, isLoading: isLoading, color: Colors.white),
      ),
    );
  }
}

class _ButtonContent extends StatelessWidget {
  final String label;
  final IconData? icon;
  final bool isLoading;
  final Color color;

  const _ButtonContent({
    required this.label,
    required this.isLoading,
    required this.color,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return SizedBox(
        width: 20,
        height: 20,
        child: CircularProgressIndicator(
          strokeWidth: 2,
          valueColor: AlwaysStoppedAnimation<Color>(color),
        ),
      );
    }

    if (icon != null) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 20),
          const SizedBox(width: 8),
          Text(label, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
        ],
      );
    }

    return Text(label, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600));
  }
}

class AppSmallButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final Color? color;
  final bool isOutlined;

  const AppSmallButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.color,
    this.isOutlined = false,
  });

  @override
  Widget build(BuildContext context) {
    final buttonColor = color ?? AppColors.primary;

    if (isOutlined) {
      return OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          foregroundColor: buttonColor,
          side: BorderSide(color: buttonColor, width: 1.5),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          minimumSize: Size.zero,
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
        child: Text(label, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
      );
    }

    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: buttonColor,
        foregroundColor: Colors.white,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        minimumSize: Size.zero,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
      child: Text(label, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
    );
  }
}

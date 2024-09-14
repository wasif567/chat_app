import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  final Function() onPressed;
  final Widget? child;
  final String label;
  const PrimaryButton({super.key, required this.onPressed, this.child, required this.label});

  @override
  Widget build(BuildContext context) {
    return TextButton(
        style: TextButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            backgroundColor: Theme.of(context).primaryColor),
        onPressed: onPressed,
        child: child ??
            Text(
              label,
              style: const TextStyle(
                color: Colors.white,
              ),
            ));
  }
}

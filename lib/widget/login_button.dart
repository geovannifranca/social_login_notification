import 'package:flutter/material.dart';

class LoginButton extends StatelessWidget {
  final bool isLoading;
  final String? pathImage;
  final IconData? icon;
  final String text;
  final void Function() onPressed;
  const LoginButton({
    this.isLoading = false,
    super.key,
    this.pathImage,
    this.icon,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: isLoading ? null : onPressed,
      borderRadius: BorderRadius.circular(55),
      child: Ink(
        height: 60,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(55),
        ),
        child: isLoading
            ? const Center(
                child: CircularProgressIndicator(color: Colors.green),
              )
            : Row(
                children: [
                  if (pathImage != null) Image.asset(pathImage!, width: 18),
                  if (icon != null) Icon(icon),
                  const SizedBox(height: 15),
                  Expanded(
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        text,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: Colors.green[800],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import '../constants/colors.dart';

class BrandedButton extends StatefulWidget {

  final String label;
  final VoidCallback onPressed;
  final bool isLoading;
  final bool enabled;

  const BrandedButton({
    super.key,
    required this.label,
    required this.onPressed,
    required this.isLoading,
    required this.enabled,
  });

  @override
  State<BrandedButton> createState() => _BrandedButtonState();
}

class _BrandedButtonState extends State<BrandedButton> {

  double scale = 1;

  @override
  Widget build(BuildContext context) {

    return GestureDetector(

      onTapDown: (_) {
        setState(() => scale = 0.98);
      },

      onTapUp: (_) {
        setState(() => scale = 1);
      },

      onTapCancel: () {
        setState(() => scale = 1);
      },

      child: AnimatedScale(
        scale: scale,
        duration: const Duration(milliseconds: 100),

        child: SizedBox(
          width: double.infinity,

          child: ElevatedButton(

            onPressed: widget.enabled && !widget.isLoading
                ? widget.onPressed
                : null,

            style: ElevatedButton.styleFrom(
              backgroundColor: primaryGreen,
              disabledBackgroundColor: primaryGreen.withOpacity(0.6),
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),

            child: widget.isLoading
                ? const SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(
                      color: neutralWhite,
                      strokeWidth: 2,
                    ),
                  )
                : const Text(
                    "Login",
                    style: TextStyle(
                      color: neutralWhite,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
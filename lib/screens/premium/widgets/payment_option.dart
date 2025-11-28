import 'package:flutter/material.dart';

class PaymentOption extends StatelessWidget {
  final int index;
  final int selectedIndex;
  final String title;
  final String assetLogo;
  final VoidCallback onTap;
  final bool isAddCard;

  PaymentOption({
    super.key,
    required this.index,
    required this.selectedIndex,
    required this.title,
    required this.assetLogo,
    required this.onTap,
    this.isAddCard = false,
  });

  @override
  Widget build(BuildContext context) {
    final bool isSelected = index == selectedIndex;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 220),
      curve: Curves.easeOut,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(18),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          decoration: BoxDecoration(
            color: isAddCard ? const Color(0xFF202228) : const Color(0xFF1A1C22),
            borderRadius: BorderRadius.circular(18),
            border: Border.all(
              color: isSelected
                  ? const Color(0xFFE21220)
                  : Colors.white.withOpacity(0.18),
              width: isSelected ? 2.4 : 1.4,
            ),
            boxShadow: isSelected
                ? [
                    BoxShadow(
                      color: const Color(0xFFE21220).withOpacity(0.35),
                      blurRadius: 20,
                      spreadRadius: 1,
                    )
                  ]
                : [],
          ),

          child: Row(
            children: [
              Image.asset(
                assetLogo,
                width: 36,
                height: 36,
              ),

              const SizedBox(width: 17),

              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),

              /// RADIO (no radio for Add Card)
              if (!isAddCard)
                AnimatedContainer(
                  duration: const Duration(milliseconds: 220),
                  width: 22,
                  height: 22,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: isSelected
                          ?  Color(0xFFE21220)
                          : Colors.white.withOpacity(0.4),
                      width: 2,
                    ),
                    color: isSelected
                        ? const Color(0xFFE21220)
                        : Colors.transparent,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
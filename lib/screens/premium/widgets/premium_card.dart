import 'package:flutter/material.dart';

class PremiumCard extends StatelessWidget {
  final String price;
  final String type;
  final List<String> features;
  final bool isSelected;
  final VoidCallback onTap;

  const PremiumCard({
    super.key,
    required this.price,
    required this.type,
    required this.features,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    double radius = 28;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 220),
      curve: Curves.easeOut,
      transform: Matrix4.identity()
        ..scale(isSelected ? 1.04 : 1.0),
      child: InkWell(
        borderRadius: BorderRadius.circular(radius),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.fromLTRB(22, 24, 22, 26),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(radius),
            border: Border.all(
              color: isSelected
                  ? const Color(0xFFE21220)
                  : Colors.white.withOpacity(0.12),
              width: isSelected ? 3 : 1.4,
            ),
            gradient: LinearGradient(
              colors: [
                const Color(0xFF1A1B20),
                const Color(0xFF14151A),
                const Color(0xFF111215).withOpacity(0.92),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            boxShadow: isSelected
                ? [
                    BoxShadow(
                      color: const Color(0xFFE21220).withOpacity(0.45),
                      blurRadius: 28,
                      spreadRadius: 1.5,
                      offset: const Offset(0, 8),
                    )
                  ]
                : [],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // GOLD-ish premium icon
              ShaderMask(
                shaderCallback: (rect) => const LinearGradient(
                  colors: [
                    Color(0xFFFF5757),
                    Color(0xFFE21220),
                    Color(0xFF8C0A0A),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ).createShader(rect),
                child: const Icon(
                  Icons.workspace_premium_outlined,
                  size: 45,
                  color: Colors.white,
                ),
              ),

              const SizedBox(height: 16),

              // PRICE SECTION
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "\$$price",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 36,
                      fontWeight: FontWeight.w800,
                      letterSpacing: -1,
                    ),
                  ),
                  const SizedBox(width: 6),
                  Text(
                    '/$type',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.55),
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              Divider(
                color: Colors.white.withOpacity(0.15),
                thickness: 1,
              ),

              const SizedBox(height: 18),

              // FEATURES LIST
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: features.map((f) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(
                          Icons.check_rounded,
                          size: 20,
                          color: Color(0xFFE21220),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            f,
                            style: TextStyle(
                              fontSize: 15.5,
                              height: 1.35,
                              color: Colors.white.withOpacity(0.88),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
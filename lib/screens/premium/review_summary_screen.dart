import 'package:flutter/material.dart';
import 'package:mova_app/screens/premium/premium_screen.dart';
import 'package:mova_app/screens/premium/widgets/premium_card.dart';

class ReviewSummaryScreen extends StatelessWidget {
  final String price;
  final String type;
  final String paymentMethod;
  final String? cardLast4;

  const ReviewSummaryScreen({
    super.key,
    required this.price,
    required this.type,
    required this.paymentMethod,
    this.cardLast4,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF141417),
      appBar: AppBar(
        backgroundColor: const Color(0xFF141417),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new,
              color: Colors.white, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 2),
        
              const Text(
                "Review Summary",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 33,
                  fontWeight: FontWeight.w900,
                  letterSpacing: -0.6,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                "Double-check your subscription before confirming.",
                style: TextStyle(
                  color: Colors.white.withOpacity(0.55),
                  fontSize: 15,
                ),
              ),
              const SizedBox(height: 30),
        
              // ⭐ Premium Plan Card Info
              Center(
                child: SizedBox(
                  width: 360, 
                  child: PremiumCard(
                    price: price,
                    type: "month",
                    features: const [
                      "Unlimited Movies & Series",
                      "4K Ultra HD + HDR",
                      "Watch on Any Device",
                    ],
                    isSelected: true,
                    onTap: () {},
                  ),
                ),
              ),
        
              const SizedBox(height: 38),
        
              // ⭐ Payment Method Info
              _sectionCard(
            title: "Payment Method",
            contentMain: paymentMethod,
            contentSub: cardLast4 != null
                ? "Card ending with •••• $cardLast4"
                : "Auto-renew every month unless cancelled.",
          ),
        
              const SizedBox(height: 25),
        
              // ⭐ Price Summary
              _priceBreakdown(),
        
              SizedBox(height: 30),

        
              SizedBox(
                height: 58,
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      barrierDismissible: false,
                      barrierColor: Colors.black.withOpacity(0.65),
                      builder: (_) => _SuccessDialog(),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFE21220),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: const Text(
                    "Confirm Subscription",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ),
        
              const SizedBox(height: 35),
            ],
          ),
        ),
      ),
    );
  }

Widget _sectionCard({
  required String title,
  required String contentMain,
  String? contentSub,
  String? cardLast4,
}) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(22),
    decoration: BoxDecoration(
      color: const Color(0xFF1E1E22),
      borderRadius: BorderRadius.circular(20),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            color: Colors.white.withOpacity(0.85),
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          contentMain,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w800,
          ),
        ),
        if (cardLast4 != null) ...[
          const SizedBox(height: 6),
          Text(
            "Card ending with •••• $cardLast4",
            style: TextStyle(
              color: Colors.white.withOpacity(0.7),
              fontSize: 15,
            ),
          ),
        ],
        if (contentSub != null) ...[
          const SizedBox(height: 6),
          Text(
            contentSub!,
            style: TextStyle(
              color: Colors.white.withOpacity(0.55),
              fontSize: 14,
            ),
          ),
        ],
      ],
    ),
  );
}

  // 🔶 Price Breakdown Component
  Widget _priceBreakdown() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E22),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          _row("Premium Plan", "\$$price"),
          const SizedBox(height: 12),
          _row("Tax", "\$0.00"),
          const SizedBox(height: 12),
          Divider(color: Colors.white.withOpacity(0.25)),
          const SizedBox(height: 12),
          _row("Total", "\$$price", isBold: true, fontSize: 20),
        ],
      ),
    );
  }

  // 🔶 Reusable Row
  Widget _row(String left, String right,
      {bool isBold = false, double fontSize = 17}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          left,
          style: TextStyle(
            color: Colors.white.withOpacity(0.75),
            fontSize: fontSize,
            fontWeight: isBold ? FontWeight.w700 : FontWeight.w500,
          ),
        ),
        Text(
          right,
          style: TextStyle(
            color: Colors.white,
            fontSize: fontSize,
            fontWeight: isBold ? FontWeight.w900 : FontWeight.w700,
          ),
        ),
      ],
    );
  }
}

// Widget

class _SuccessDialog extends StatefulWidget {
  const _SuccessDialog({Key? key}) : super(key: key);

  @override
  State<_SuccessDialog> createState() => _SuccessDialogState();
}

class _SuccessDialogState extends State<_SuccessDialog>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 420),
    );
    _scaleAnimation =
        CurvedAnimation(parent: _controller, curve: Curves.easeOutBack);
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _scaleAnimation,
      child: Dialog(
        insetPadding: const EdgeInsets.symmetric(horizontal: 30),
        backgroundColor: const Color(0xFF1A1B20),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(26)),
        child: Container(
          padding: const EdgeInsets.fromLTRB(26, 28, 26, 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // GLOW ICON ✨
              Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color(0xFFE21220).withOpacity(0.12),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFFE21220).withOpacity(0.5),
                      blurRadius: 30,
                      spreadRadius: 4,
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.check_rounded,
                  color: Color(0xFFE21220),
                  size: 52,
                ),
              ),

              const SizedBox(height: 22),

              const Text(
                "Congratulations!",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
                  letterSpacing: -0.5,
                ),
              ),

              const SizedBox(height: 10),

              Text(
                "Your premium subscription is now active.\nEnjoy unlimited streaming!",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white.withOpacity(0.65),
                  fontSize: 15,
                  height: 1.4,
                ),
              ),

              const SizedBox(height: 26),

              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context); // Pop dialog
                    Navigator.pop(context); // Kembali ke halaman sebelumnya
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFE21220),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                  ),
                  child: const Text(
                    "Continue",
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}



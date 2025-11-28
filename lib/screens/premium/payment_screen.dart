import 'package:flutter/material.dart';
import 'package:mova_app/screens/premium/add_new_card_screen.dart';
import 'package:mova_app/screens/premium/review_summary_screen.dart';
import 'package:mova_app/screens/premium/widgets/payment_option.dart';
import 'package:mova_app/utils/app_color.dart';

class PaymentScreen extends StatefulWidget {
  final String price;
  final String type;

  const PaymentScreen({super.key, required this.price, required this.type});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  int selectedMethod = -1;

  /// Store cards user-added
  List<Map<String, String>> userCards = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kPrimary,

      appBar: AppBar(
        backgroundColor: AppColors.kPrimary,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: AppColors.kTextColor,
            size: 20,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.qr_code_scanner_rounded,
              color: AppColors.kTextColor,
              size: 26,
            ),
            onPressed: () {},
          ),
        ],
      ),

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 27, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),

            const Text(
              "Payment",
              style: TextStyle(
                fontSize: 33,
                fontWeight: FontWeight.w900,
                letterSpacing: -0.6,
                color: Colors.white,
              ),
            ),

            const SizedBox(height: 8),

            Text(
              "You are subscribing to Premium (${widget.type} • \$${widget.price})",
              style: TextStyle(
                fontSize: 15,
                color: AppColors.kTextColor.withValues(alpha: 0.55),
              ),
            ),

            const SizedBox(height: 35),

            Text(
              "Payment Methods",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: AppColors.kTextColor.withValues(alpha: 0.88),
              ),
            ),

            const SizedBox(height: 18),

            PaymentOption(
              index: 0,
              selectedIndex: selectedMethod,
              title: "PayPal",
              assetLogo: "assets/images/paypal.png",
              onTap: () => setState(() => selectedMethod = 0),
            ),
            const SizedBox(height: 16),

            PaymentOption(
              index: 1,
              selectedIndex: selectedMethod,
              title: "Google Play",
              assetLogo: "assets/images/googleplay.png",
              onTap: () => setState(() => selectedMethod = 1),
            ),
            const SizedBox(height: 16),

            PaymentOption(
              index: 2,
              selectedIndex: selectedMethod,
              title: "Apple Pay",
              assetLogo: "assets/images/applepay.png",
              onTap: () => setState(() => selectedMethod = 2),
            ),

            const SizedBox(height: 20),

            if (userCards.isNotEmpty)
              Column(
                children: List.generate(userCards.length, (i) {
                  final card = userCards[i];
                  int index = 3 + i;

                  return Column(
                    children: [
                      PaymentOption(
                        index: index,
                        selectedIndex: selectedMethod,
                        title:
                            "${card["brand"]!.toUpperCase()} •••• ${card["number"]!.substring(card["number"]!.length - 4)}",
                        assetLogo: "assets/cards/${card["brand"]}.png",
                        onTap: () => setState(() => selectedMethod = index),
                      ),
                      const SizedBox(height: 16),
                    ],
                  );
                }),
              ),

            GestureDetector(
              onTap: () async {
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const AddNewCardScreen()),
                );

                if (result != null) {
                  setState(() {
                    userCards.add(Map<String, String>.from(result));
                    selectedMethod = 3 + userCards.length - 1;
                  });

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Card Added Successfully"),
                      backgroundColor: Colors.green,
                      duration: Duration(seconds: 2),
                    ),
                  );
                }
              },
              child: Container(
                width: double.infinity,
                height: 58,
                decoration: BoxDecoration(
                  color: const Color(0xFF2A2A2D),
                  borderRadius: BorderRadius.circular(40),
                ),
                alignment: Alignment.center,
                child: Text(
                  "Add New Card",
                  style: TextStyle(
                    color: AppColors.kTextColor.withValues(alpha: 0.72),
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),

            const Spacer(),

            SizedBox(
              width: double.infinity,
              height: 58,
              child: ElevatedButton(
                onPressed: selectedMethod == -1
                    ? null
                    : () {
                        String method;

                        if (selectedMethod <= 2) {
                          // Default payment methods
                          method = selectedMethod == 0
                              ? "PayPal"
                              : selectedMethod == 1
                              ? "Google Play"
                              : "Apple Pay";
                        } else {
                          // User added cards
                          final cardIndex = selectedMethod - 3;
                          method = userCards[cardIndex]["brand"]!.toUpperCase();
                        }

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => ReviewSummaryScreen(
                              price: widget.price,
                              type: widget.type,
                              paymentMethod: method,
                              cardLast4: selectedMethod > 2
                                  ? userCards[selectedMethod - 3]["number"]!
                                        .substring(
                                          userCards[selectedMethod -
                                                      3]["number"]!
                                                  .length -
                                              4,
                                        )
                                  : null,
                            ),
                          ),
                        );
                      },

                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.kSecondary,
                  disabledBackgroundColor: AppColors.kSecondary.withOpacity(0.3),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: Text(
                  "Continue",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                    color: selectedMethod == -1
                        ? AppColors.kTextColor.withValues(alpha: 0.55)
                        : AppColors.kTextColor,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 35),
          ],
        ),
      ),
    );
  }
}

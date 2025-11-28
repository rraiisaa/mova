import 'package:flutter/material.dart';
import 'package:mova_app/screens/premium/payment_screen.dart';
import 'package:mova_app/screens/premium/widgets/premium_card.dart';
import 'package:mova_app/utils/app_color.dart';


class PremiumScreen extends StatefulWidget {
  const PremiumScreen({super.key});

  @override
  State<PremiumScreen> createState() => _PremiumScreenState();
}

class _PremiumScreenState extends State<PremiumScreen> {
  int selectedIndex = -1; // tidak ada selected, karena langsung navigate

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color.fromARGB(255, 13, 13, 16),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const SizedBox(height: 30),

            Text(
              
              "Subscribe to Premium",
              style: const TextStyle(
                fontSize: 31,
                fontWeight: FontWeight.w700,
                color: AppColors.kSecondary,
              ),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 12),

            Text(
              "Enjoy watching Full-HD & 4K movies, without restrictions, and no ads.",
              style: TextStyle(
                fontSize: 15,
                color: Colors.white.withOpacity(0.75),
              ),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 35),

            PremiumCard(
              price: "9.99",
              type: "month",
              features: const [
                "Ad-free streaming",
                "Unlimited movies & series",
                "Supports Full HD & 4K",
              ],
              isSelected: false,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => PaymentScreen(
                      price: "9.99",
                      type: "month",
                    ),
                  ),
                );
              },
            ),

            const SizedBox(height: 23),

            PremiumCard(
              price: "99.99",
              type: "year",
              features: const [
                "Ad-free streaming",
                "Unlimited movies & series",
                "Supports Full HD & 4K",
                "Best value for long-term",
              ],
              isSelected: false,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => PaymentScreen(
                      price: "99.99",
                      type: "year",
                    ),
                  ),
                );
              },
            ),

            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
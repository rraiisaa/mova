import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AddNewCardScreen extends StatefulWidget {
  const AddNewCardScreen({super.key});

  @override
  State<AddNewCardScreen> createState() => _AddNewCardScreenState();
}

class _AddNewCardScreenState extends State<AddNewCardScreen> {
  final TextEditingController nameCtrl = TextEditingController();
  final TextEditingController numberCtrl = TextEditingController();
  final TextEditingController expiryCtrl = TextEditingController();
  final TextEditingController cvvCtrl = TextEditingController();

  // BRAND DETECTOR FUNCTION
  String detectCardBrand(String number) {
    String cleaned = number.replaceAll(' ', '');

    if (cleaned.startsWith('4')) return 'visa';

    if (RegExp(r'^5[1-5]').hasMatch(cleaned) ||
        RegExp(r'^(222[1-9]|22[3-9]\d|2[3-6]\d{2}|27[01]\d|2720)')
            .hasMatch(cleaned)) return 'mastercard';

    if (cleaned.startsWith('34') || cleaned.startsWith('37')) return 'amex';

    // Indonesiany
    if (cleaned.startsWith('8957')) return 'gopay';
    if (cleaned.startsWith('8888')) return 'dana';
    if (cleaned.startsWith('6211')) return 'shopeepay';

    return '';
  }

  // FORMAT NUMBER 4-4-4-4
  String formatCardNumber(String input) {
    String digits = input.replaceAll(RegExp(r'\D'), '');
    List<String> groups = [];
    for (int i = 0; i < digits.length; i += 4) {
      groups.add(digits.substring(i, i + 4 > digits.length ? digits.length : i + 4));
    }
    return groups.join(' ');
  }

  // LUHN VALIDATION
  bool validateLuhn(String number) {
    String cleaned = number.replaceAll(' ', '');
    int sum = 0;
    bool alternate = false;

    for (int i = cleaned.length - 1; i >= 0; i--) {
      int digit = int.parse(cleaned[i]);
      if (alternate) {
        digit *= 2;
        if (digit > 9) digit -= 9;
      }
      sum += digit;
      alternate = !alternate;
    }
    return sum % 10 == 0;
  }

  bool isValidForm() {
    return nameCtrl.text.isNotEmpty &&
        validateLuhn(numberCtrl.text) &&
        expiryCtrl.text.isNotEmpty &&
        cvvCtrl.text.length == 3;
  }

  // UI
  @override
  Widget build(BuildContext context) {
    String brand = detectCardBrand(numberCtrl.text);

    return Scaffold(
      backgroundColor: const Color(0xFF141417),

      appBar: AppBar(
        backgroundColor: const Color(0xFF141417),
        elevation: 0,
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon:  Icon(Icons.arrow_back_ios_new, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.qr_code_scanner_rounded,
                color: Colors.white, size: 26),
            onPressed: () {},
          ),
        ],
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 22),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Add New Card",
              style: TextStyle(
                fontSize: 33,
                fontWeight: FontWeight.w900,
                color: Colors.white,
              ),
            ),

            const SizedBox(height: 20),

            /// CARD PREVIEW
            Container(
              width: double.infinity,
              height: 190,
              padding: const EdgeInsets.all(22),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18),
                gradient: const LinearGradient(
                  colors: [Color(0xFFE21220), Color(0xFFB01018)],
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Mocard",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 17,
                              fontWeight: FontWeight.w700)),

                      AnimatedSwitcher(
                        duration: const Duration(milliseconds: 250),
                        child: brand.isEmpty
                            ? const SizedBox(width: 40, key: ValueKey("empty"))
                            : Image.asset(
                                "assets/cards/$brand.png",
                                key: ValueKey(brand),
                                height: 28,
                                fit: BoxFit.contain,
                              ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  Text(
                    numberCtrl.text.isEmpty
                        ? "•••• •••• •••• ••••"
                        : numberCtrl.text,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 3,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          nameCtrl.text.isEmpty
                              ? "Card Holder Name"
                              : nameCtrl.text,
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.78),
                            fontSize: 13,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(width: 25),
                      Text(
                        expiryCtrl.text.isEmpty
                            ? "••/••"
                            : expiryCtrl.text,
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.78),
                          fontSize: 13,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),

            const SizedBox(height: 28),

            _inputLabel("Card Name"),
            _inputField(nameCtrl, "John Doe"),

            const SizedBox(height: 18),

            _inputLabel("Card Number"),
            _inputField(
              numberCtrl,
              "1234 5678 9012 3456",
              keyboard: TextInputType.number,
              onChangeCustom: (v) {
                final formatted = formatCardNumber(v);
                String digits = v.replaceAll(RegExp(r'\D'), '');
                numberCtrl.value = numberCtrl.value.copyWith(
                  text: formatted,
                  selection:
                      TextSelection.collapsed(offset: formatted.length),
                );
                if (digits.length == 16) {
                  FocusScope.of(context).nextFocus();
                }
                setState(() {});
              },
            ),

            const SizedBox(height: 18),

            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _inputLabel("Expiry Date"),
                      _inputField(
                        expiryCtrl,
                        "MM/YY",
                        keyboard: TextInputType.datetime,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _inputLabel("CVV"),
                      _inputField(
                        cvvCtrl,
                        "123",
                        keyboard: TextInputType.number,
                        isObscure: true,
                        maxLength: 3,
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 32),

            /// ADD BUTTON
            SizedBox(
              width: double.infinity,
              height: 58,
              child: ElevatedButton(
                onPressed: isValidForm()
                 ? () {
                  final newCard = {
                    "brand": detectCardBrand(numberCtrl.text),
                    "number": numberCtrl.text,
                    "name": nameCtrl.text,
                    "expiry": expiryCtrl.text,
                  };
                  Navigator.pop(context, newCard);
                }
                : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor:  Color(0xFFE21220),
                  disabledBackgroundColor: Colors.red.withOpacity(0.3),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
              
                ),
                child: const Text(
                  "Add", 
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                  ),
                ),
                
              ),
              
            ),

            const SizedBox(height: 25),
          ],
        ),
      ),
    );
  }

  Widget _inputLabel(String text) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.w700,
        color: Colors.white.withOpacity(0.85),
      ),
    );
  }

  Widget _inputField(
    TextEditingController controller,
    String hint, {
    TextInputType keyboard = TextInputType.text,
    bool isObscure = false,
    int? maxLength,
    Function(String)? onChangeCustom,
  }) {
    return TextField(
      controller: controller,
      keyboardType: keyboard,
      obscureText: isObscure,
      maxLength: maxLength,
      onChanged: (value) {
        if (onChangeCustom != null) {
          onChangeCustom(value);
        } else {
          setState(() {});
        }
      },
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        counterText: "",
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
        hintText: hint,
        hintStyle: TextStyle(
          color: Colors.white.withOpacity(0.55),
          fontSize: 15,
        ),
        filled: true,
        fillColor: const Color(0xFF222225),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:mova_app/l10n/app_localizations.dart';
import 'package:mova_app/main.dart';

class AppLanguage {
  final String key;
  final Locale locale;

  AppLanguage(this.key, this.locale);
}

class LanguageSettingsScreen extends StatefulWidget {
  const LanguageSettingsScreen({super.key});

  @override
  State<LanguageSettingsScreen> createState() => _LanguageSettingsScreenState();
}

class _LanguageSettingsScreenState extends State<LanguageSettingsScreen> {
  Locale? selectedLocale;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    selectedLocale = Localizations.localeOf(context);
  }

void changeLanguage(Locale locale) {
  MovieApp.setLocale(context, locale);
  setState(() => selectedLocale = locale);
  Navigator.pop(context);
}  

  final suggested = [
    AppLanguage("englishUS", const Locale("en")),
    AppLanguage("englishUK", const Locale("en")),
  ];

  final languages = [
    AppLanguage("mandarin", const Locale("zh")),
    AppLanguage("hindi", const Locale("hi")),
    AppLanguage("spanish", const Locale("es")),
    AppLanguage("french", const Locale("fr")),
    AppLanguage("arabic", const Locale("ar")),
    AppLanguage("bengali", const Locale("bn")),
    AppLanguage("russian", const Locale("ru")),
    AppLanguage("indonesia", const Locale("id")),
    AppLanguage("portuguese", const Locale("pt")),
    AppLanguage("urdu", const Locale("ur")),
    AppLanguage("german", const Locale("de")),
    AppLanguage("japanese", const Locale("ja")),
    AppLanguage("korean", const Locale("ko")),
    AppLanguage("italian", const Locale("it")),
    AppLanguage("turkish", const Locale("tr")),
    AppLanguage("vietnamese", const Locale("vi")),
    AppLanguage("thai", const Locale("th")),
  ];

  Widget buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, bottom: 8, top: 25),
      child: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w700,
          fontSize: 16,
        ),
      ),
    );
  }

  Widget buildLanguageTile(String title, Locale locale) {
    final isSelected =
        (selectedLocale?.languageCode == locale.languageCode) &&
        (selectedLocale?.countryCode == locale.countryCode);

    return InkWell(
      onTap: () => changeLanguage(locale),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Row(
          children: [
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                ),
              ),
            ),
            Icon(
              isSelected ? Icons.radio_button_checked : Icons.radio_button_off,
              color: Colors.red,
              size: 22,
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: const Color(0xFF0F0F0F),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0F0F0F),
        elevation: 0,
        title: Text(
          t.language,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.w700,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: ListView(
        children: [
          buildSectionTitle(t.suggested),
          ...suggested.map((lang) => buildLanguageTile(t.get(lang.key), lang.locale)),

          const Divider(color: Colors.white12, thickness: 1, height: 30),

          buildSectionTitle(t.language),
          ...languages.map((lang) => buildLanguageTile(t.get(lang.key), lang.locale)),
        ],
      ),
    );
  }
}

extension LocalizationGetter on AppLocalizations {
  String get(String key) {
    switch (key) {
      case "englishUS": return englishUS;
      case "englishUK": return englishUK;
      case "mandarin": return mandarin;
      case "hindi": return hindi;
      case "spanish": return spanish;
      case "french": return french;
      case "arabic": return arabic;
      case "bengali": return bengali;
      case "russian": return russian;
      case "indonesia": return indonesia;
      case "portuguese": return portuguese;
      case "urdu": return urdu;
      case "german": return german;
      case "japanese": return japanese;
      case "korean": return korean;
      case "italian": return italian;
      case "turkish": return turkish;
      case "vietnamese": return vietnamese;
      case "thai": return thai;
      default: return key;
    }
  }
}

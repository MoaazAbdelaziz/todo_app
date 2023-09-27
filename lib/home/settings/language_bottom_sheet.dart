import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/providers/app_config_provider.dart';

class LanguageBottomSheet extends StatefulWidget {
  const LanguageBottomSheet({super.key});

  @override
  State<LanguageBottomSheet> createState() => _LanguageBottomSheetState();
}

class _LanguageBottomSheetState extends State<LanguageBottomSheet> {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppConfigProvider>(context);

    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          InkWell(
            onTap: () {
              provider.changeAppLanguage('en');
            },
            child: provider.appLanguage == 'en'
                ? selectedLanguage(AppLocalizations.of(context)!.english)
                : unselectedLanguage(AppLocalizations.of(context)!.english),
          ),
          const SizedBox(height: 10),
          InkWell(
            onTap: () {
              provider.changeAppLanguage('ar');
            },
            child: provider.appLanguage == 'ar'
                ? selectedLanguage(AppLocalizations.of(context)!.arabic)
                : unselectedLanguage(AppLocalizations.of(context)!.arabic),
          ),
        ],
      ),
    );
  }

  Row unselectedLanguage(String language) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          language,
          style: Theme.of(context).textTheme.titleSmall,
        ),
      ],
    );
  }

  Row selectedLanguage(String language) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          language,
          style: Theme.of(context).textTheme.titleSmall!.copyWith(
                color: Theme.of(context).primaryColor,
              ),
        ),
        Icon(
          Icons.check,
          size: 30,
          color: Theme.of(context).primaryColor,
        ),
      ],
    );
  }
}

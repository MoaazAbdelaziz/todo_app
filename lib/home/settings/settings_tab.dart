import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/home/my_theme.dart';
import 'package:todo_app/home/settings/language_bottom_sheet.dart';
import 'package:todo_app/home/settings/mode_bottom_sheet.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:todo_app/providers/app_config_provider.dart';

class SettingsTab extends StatefulWidget {
  const SettingsTab({super.key});

  @override
  State<SettingsTab> createState() => _SettingsTabState();
}

class _SettingsTabState extends State<SettingsTab> {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppConfigProvider>(context);

    return Padding(
      padding: const EdgeInsets.only(left: 38.0, top: 28),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            AppLocalizations.of(context)!.language,
            style: Theme.of(context).textTheme.titleSmall!.copyWith(
                  fontSize: 14,
                ),
          ),
          const SizedBox(height: 23),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: InkWell(
              onTap: () {
                showLangaugeBottomSheet();
              },
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: MyTheme.whitColor,
                  border: Border.all(
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      provider.appLanguage == 'en'
                          ? AppLocalizations.of(context)!.english
                          : AppLocalizations.of(context)!.arabic,
                      style: Theme.of(context).textTheme.titleSmall!.copyWith(
                            fontSize: 14,
                            fontWeight: FontWeight.normal,
                            color: Theme.of(context).primaryColor,
                          ),
                    ),
                    Icon(
                      Icons.arrow_drop_down,
                      color: Theme.of(context).primaryColor,
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 22),
          Text(
            AppLocalizations.of(context)!.mode,
            style: Theme.of(context).textTheme.titleSmall!.copyWith(
                  fontSize: 14,
                ),
          ),
          const SizedBox(height: 23),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: InkWell(
              onTap: () {
                showModeBottomSheet();
              },
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: MyTheme.whitColor,
                  border: Border.all(
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      provider.appTheme == ThemeMode.light
                          ? AppLocalizations.of(context)!.light
                          : AppLocalizations.of(context)!.dark,
                      style: Theme.of(context).textTheme.titleSmall!.copyWith(
                            fontSize: 14,
                            fontWeight: FontWeight.normal,
                            color: Theme.of(context).primaryColor,
                          ),
                    ),
                    Icon(
                      Icons.arrow_drop_down,
                      color: Theme.of(context).primaryColor,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void showLangaugeBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (context) => const LanguageBottomSheet(),
    );
  }

  void showModeBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (context) => const ModeBottomSheet(),
    );
  }
}

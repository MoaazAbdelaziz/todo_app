import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/providers/app_config_provider.dart';

class ModeBottomSheet extends StatefulWidget {
  const ModeBottomSheet({super.key});

  @override
  State<ModeBottomSheet> createState() => _ModeBottomSheetState();
}

class _ModeBottomSheetState extends State<ModeBottomSheet> {
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
              provider.changeAppTheme(ThemeMode.light);
            },
            child: provider.appTheme == ThemeMode.light
                ? selectedThemeMode(AppLocalizations.of(context)!.light)
                : unselectedThemeMode(AppLocalizations.of(context)!.light),
          ),
          const SizedBox(height: 10),
          InkWell(
            onTap: () {
              provider.changeAppTheme(ThemeMode.dark);
            },
            child: provider.appTheme == ThemeMode.dark
                ? selectedThemeMode(AppLocalizations.of(context)!.dark)
                : unselectedThemeMode(AppLocalizations.of(context)!.dark),
          ),
        ],
      ),
    );
  }

  Widget unselectedThemeMode(String appTheme) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          appTheme,
          style: Theme.of(context).textTheme.titleSmall,
        ),
      ],
    );
  }

  Widget selectedThemeMode(String appTheme) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          appTheme,
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

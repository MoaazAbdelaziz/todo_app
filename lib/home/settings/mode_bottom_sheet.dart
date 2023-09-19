import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ModeBottomSheet extends StatefulWidget {
  const ModeBottomSheet({super.key});

  @override
  State<ModeBottomSheet> createState() => _ModeBottomSheetState();
}

class _ModeBottomSheetState extends State<ModeBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          InkWell(
            onTap: () {},
            child: selectedThemeMode(),
          ),
          const SizedBox(height: 10),
          InkWell(
            onTap: () {},
            child: unselectedThemeMode(),
          ),
        ],
      ),
    );
  }

  Widget unselectedThemeMode() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          AppLocalizations.of(context)!.dark,
          style: Theme.of(context).textTheme.titleSmall,
        ),
      ],
    );
  }

  Widget selectedThemeMode() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          AppLocalizations.of(context)!.light,
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

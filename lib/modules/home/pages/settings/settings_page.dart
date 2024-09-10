import 'package:flutter/material.dart';
import 'package:news/core/providers/locales/locales_provider.dart';
import 'package:news/core/providers/themes/themes_provider.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  late List<String> themes;
  late LocalesProvider localesProvider;
  late ThemesProvider themesProvider;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    localesProvider = Provider.of(context);
    themesProvider = Provider.of(context);
    themes = [
      LocalesProvider.getTrans(context).light,
      LocalesProvider.getTrans(context).dark,
      LocalesProvider.getTrans(context).system
    ];
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    ThemeData theme = Theme.of(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              LocalesProvider.getTrans(context).language,
              style: theme.textTheme.labelMedium,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              child: DropdownMenu(
                  controller: TextEditingController(
                      text: localesProvider.isArabic()
                          ? localesProvider.locales[1]
                          : localesProvider.locales[0]),
                  onSelected: (value) {
                    localesProvider.changeLocale(
                        value == localesProvider.locales[1] ? "ar" : "en");
                  },
                  width: size.width * 0.85,
                  dropdownMenuEntries: [
                    DropdownMenuEntry<String>(
                        value: localesProvider.locales[0],
                        labelWidget: Text(
                          localesProvider.locales[0],
                          style: theme.textTheme.labelMedium!
                              .copyWith(fontSize: 20),
                        ),
                        label: localesProvider.locales[0]),
                    DropdownMenuEntry<String>(
                        value: localesProvider.locales[1],
                        labelWidget: Text(
                          localesProvider.locales[1],
                          style: theme.textTheme.labelMedium!
                              .copyWith(fontSize: 20),
                        ),
                        label: localesProvider.locales[1]),
                  ]),
            ),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              LocalesProvider.getTrans(context).theme,
              style: theme.textTheme.labelMedium,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              child: DropdownMenu(
                  controller: TextEditingController(
                      text: themes[themesProvider.determineThemeName(
                          themesProvider.currentThemeMode)]),
                  onSelected: (value) {
                    themesProvider.changeTheme(themes.indexOf(value!));
                  },
                  width: size.width * 0.85,
                  dropdownMenuEntries: [
                    DropdownMenuEntry<String>(
                        value: themes[0],
                        labelWidget: Text(
                          themes[0],
                          style: theme.textTheme.labelMedium!
                              .copyWith(fontSize: 20),
                        ),
                        label: themes[0]),
                    DropdownMenuEntry<String>(
                        value: themes[1],
                        labelWidget: Text(
                          themes[1],
                          style: theme.textTheme.labelMedium!
                              .copyWith(fontSize: 20),
                        ),
                        label: themes[1]),
                    DropdownMenuEntry<String>(
                        value: themes[2],
                        labelWidget: Text(
                          themes[2],
                          style: theme.textTheme.labelMedium!
                              .copyWith(fontSize: 20),
                        ),
                        label: themes[2]),
                  ]),
            ),
          ],
        ),
      ],
    );
  }
}

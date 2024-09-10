import 'package:flutter/material.dart';
import 'package:news/core/providers/locales/locales_provider.dart';
import 'package:news/core/themes/app_themes.dart';

class CustomDrawer extends StatelessWidget {
  final VoidCallback categoriesOnTap, settingsOnTap;

  const CustomDrawer(
      {super.key, required this.categoriesOnTap, required this.settingsOnTap});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
              decoration: const BoxDecoration(
                color: AppThemes.darkOnPrimaryColor,
              ),
              child: Center(
                child: Text(
                  LocalesProvider.getTrans(context).drawerHeader,
                  style: theme.textTheme.titleMedium,
                ),
              )),
          ListTile(
            onTap: () {
              categoriesOnTap();
            },
            leading: ImageIcon(
              const AssetImage('assets/icons/menu_icon.png'),
              color: theme.textTheme.labelMedium!.color,
            ),
            title: Text(
              LocalesProvider.getTrans(context).categories,
              style: theme.textTheme.labelMedium!
                  .copyWith(fontWeight: FontWeight.bold),
            ),
          ),
          ListTile(
            onTap: () {
              settingsOnTap();
            },
            leading: ImageIcon(
              const AssetImage('assets/icons/settings_icon.png'),
              color: theme.textTheme.labelMedium!.color,
            ),
            title: Text(
              LocalesProvider.getTrans(context).settings,
              style: theme.textTheme.labelMedium!
                  .copyWith(fontWeight: FontWeight.bold),
            ),
          )
        ],
      ),
    );
  }
}

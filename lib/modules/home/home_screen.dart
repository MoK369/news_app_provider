import 'package:flutter/material.dart';
import 'package:news/core/providers/home/home_provider.dart';
import 'package:news/core/providers/locales/locales_provider.dart';
import 'package:news/core/widgets/background_pattern/background_pattern.dart';
import 'package:news/modules/home/pages/categories/categories_page.dart';
import 'package:news/modules/home/pages/settings/settings_page.dart';
import 'package:news/modules/home/widgets/drawer/custom_drawer.dart';
import 'package:news/modules/search/search_screen.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  static const String routeName = 'HomeScreen';

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(
      builder: (context, homeProvider, child) {
        if (homeProvider.currentAppBarTitle == '') {
          homeProvider.initAppBarTitle(
              appBarTitle: LocalesProvider.getTrans(context).categoryBarTitle);
        }
        if (homeProvider.didLocaleDropDownClicked) {
          homeProvider.currentAppBarTitle =
              LocalesProvider.getTrans(context).settings;
          homeProvider.didLocaleDropDownClicked = false;
        }
        final Size size = MediaQuery.of(context).size;
        return Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            title: Text(homeProvider.currentAppBarTitle),
            toolbarHeight: size.height * 0.08,
            leadingWidth: 80,
            actions: homeProvider.currentCategoryId != null
                ? [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: IconButton(
                          onPressed: () {
                            Navigator.pushNamed(
                                context, SearchScreen.routeName);
                          },
                          icon: const Icon(Icons.search)),
                    ),
                  ]
                : null,
          ),
          drawer: const CustomDrawer(),
          body: BgPattern(
              child: PageView(
            controller: homeProvider.pageController,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              CategoriesPage(
                currentCategoryId: homeProvider.currentCategoryId,
              ),
              const SettingsPage(),
            ],
          )),
        );
      },
    );
  }
}

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

  HomeScreen({super.key});

  final PageController pageController = PageController(initialPage: 0);


  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(
      builder: (context, homeProvider, child) {
        final Size size = MediaQuery.of(context).size;
        if (homeProvider.currentAppBarTitle == '') {
          homeProvider.initAppBarTitle(
              appBarTitle: LocalesProvider.getTrans(context).categoryBarTitle);
        }
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
          drawer: CustomDrawer(
            categoriesOnTap: () {
              pageController.jumpToPage(0);
              homeProvider.changeBarTitleAndCategoryId(
                  newAppBarTitle:
                      LocalesProvider.getTrans(context).categoryBarTitle,
                  newCategoryId: null);
              Navigator.pop(context);
            },
            settingsOnTap: () {
              pageController.jumpToPage(1);
              homeProvider.changeBarTitleAndCategoryId(
                  newAppBarTitle: LocalesProvider.getTrans(context).settings,
                  newCategoryId: null);
              Navigator.pop(context);
            },
          ),
          body: BgPattern(
              child: PageView(
            controller: pageController,
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

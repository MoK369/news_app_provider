import 'package:flutter/material.dart';
import 'package:news/core/providers/locales/locales_provider.dart';
import 'package:news/core/widgets/background_pattern/background_pattern.dart';
import 'package:news/modules/home/pages/categories/categories_page.dart';
import 'package:news/modules/home/pages/settings/settings_page.dart';
import 'package:news/modules/home/widgets/drawer/custom_drawer.dart';
import 'package:news/modules/search/search_screen.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = 'HomeScreen';

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? currentCategoryId;

  final PageController pageController = PageController(initialPage: 0);
  late String appBarTitle;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    appBarTitle = LocalesProvider.getTrans(context).categoryBarTitle;
  }

  @override
  Widget build(BuildContext context) {
    //final ThemeData theme = Theme.of(context);
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(appBarTitle),
        toolbarHeight: size.height * 0.08,
        leadingWidth: 80,
        actions: currentCategoryId != null
            ? [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: IconButton(
                      onPressed: () {
                        Navigator.pushNamed(context, SearchScreen.routeName);
                      },
                      icon: const Icon(Icons.search)),
                ),
              ]
            : null,
      ),
      drawer: CustomDrawer(
        categoriesOnTap: () {
          pageController.animateToPage(0,
              duration: const Duration(milliseconds: 50),
              curve: Curves.easeInOut);
          setState(() {
            currentCategoryId = null;
            appBarTitle = LocalesProvider.getTrans(context).categoryBarTitle;
            Navigator.pop(context);
          });
        },
        settingsOnTap: () {
          pageController.animateToPage(1,
              duration: const Duration(microseconds: 50),
              curve: Curves.easeInOut);
          setState(() {
            currentCategoryId = null;
            appBarTitle = LocalesProvider.getTrans(context).settings;
            Navigator.pop(context);
          });
        },
      ),
      body: BgPattern(
          child: PageView(
        controller: pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          CategoriesPage(
            currentCategoryId: currentCategoryId,
            onTap: (categoryId, categoryLabel) {
              setState(() {
                currentCategoryId = categoryId;
                appBarTitle = categoryLabel;
                // .replaceRange(0, 1, currentCategoryId![0].toUpperCase());
              });
            },
          ),
          const SettingsPage(),
        ],
      )),
    );
  }
}

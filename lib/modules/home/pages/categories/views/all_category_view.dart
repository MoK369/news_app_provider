import 'package:flutter/material.dart';
import 'package:news/core/providers/home/home_provider.dart';
import 'package:news/core/providers/locales/locales_provider.dart';
import 'package:news/modules/home/pages/categories/categories_page.dart';
import 'package:news/modules/home/pages/categories/widgets/category_card.dart';
import 'package:provider/provider.dart';

class AllCategoryView extends StatelessWidget {
  const AllCategoryView({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final LocalesProvider localesProvider = Provider.of(context);
    HomeProvider homeProvider = Provider.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 25),
      child: Column(
        children: [
          Text(
            textAlign: TextAlign.center,
            LocalesProvider.getTrans(context).pickCategory,
            style: theme.textTheme.labelMedium!
                .copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 25,
          ),
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 160 / 190,
                  mainAxisSpacing: 20,
                  crossAxisSpacing: 20),
              itemBuilder: (context, index) {
                return CategoryCard(
                    categoryModel: CategoriesPage.categories[index],
                    isLTR: localesProvider.isArabic()
                        ? index % 2 != 0
                        : index % 2 == 0);
              },
              itemCount: CategoriesPage.categories.length,
            ),
          ),
        ],
      ),
    );
  }
}

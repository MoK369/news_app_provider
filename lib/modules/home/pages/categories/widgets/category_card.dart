import 'package:flutter/material.dart';
import 'package:news/core/models/category_model.dart';

class CategoryCard extends StatelessWidget {
  final CategoryModel categoryModel;
  final void Function(String categoryId, String categoryLabel) onTap;
  final bool isLTR;

  const CategoryCard(
      {super.key,
      required this.categoryModel,
      required this.isLTR,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return InkWell(
      onTap: () {
        onTap(categoryModel.id, categoryModel.label);
      },
      child: Container(
          decoration: BoxDecoration(
              color: categoryModel.bgColor,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(isLTR ? 25 : 0),
                bottomRight: Radius.circular(isLTR ? 0 : 25),
                topLeft: const Radius.circular(25),
                topRight: const Radius.circular(25),
              )),
          child: Column(
            children: [
              Center(
                  child: Image.asset(
                categoryModel.imagePath,
                scale: 0.7,
              )),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Text(
                  textAlign: TextAlign.center,
                  categoryModel.label,
                  style: theme.textTheme.labelMedium!
                      .copyWith(color: Colors.white),
                ),
              ),
              const Spacer(),
            ],
          )),
    );
  }
}

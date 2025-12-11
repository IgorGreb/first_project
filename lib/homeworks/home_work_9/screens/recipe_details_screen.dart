import 'package:flutter/material.dart';
import 'package:flutter_application_grebenyuk/constants/dimensions.dart';
import 'package:flutter_application_grebenyuk/constants/ui_texts.dart';
import 'package:flutter_application_grebenyuk/homeworks/home_work_9/models/recipe.dart';
import 'package:flutter_application_grebenyuk/widgets/app_scaffold.dart';

class RecipeDetailsScreen extends StatelessWidget {
  const RecipeDetailsScreen({super.key, required this.recipe});

  final Recipe recipe;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return AppScaffold(
      titleWidget: Text(recipe.title),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppDimensions.paddingDefault),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius:
                  BorderRadius.circular(AppDimensions.borderRadiusMedium),
              child: Image.network(
                recipe.imageUrl,
                height: AppDimensions.recipeImageHeight,
                width: double.infinity,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, progress) {
                  if (progress == null) return child;
                  return SizedBox(
                    height: AppDimensions.recipeImageHeight,
                    child: const Center(child: CircularProgressIndicator()),
                  );
                },
                errorBuilder: (_, __, ___) => Container(
                  height: AppDimensions.recipeImageHeight,
                  color: Theme.of(context)
                      .colorScheme
                      .surfaceContainerHighest,
                  alignment: Alignment.center,
                  child: const Icon(Icons.broken_image, size: 48),
                ),
              ),
            ),
            const SizedBox(height: AppDimensions.gap16),
            Text(
              recipe.description,
              style: theme.textTheme.titleMedium,
            ),
            const SizedBox(height: AppDimensions.gap20),
            _Section(
              title: RecipeDetailsTexts.ingredientsTitle,
              items: recipe.ingredients,
            ),
            const SizedBox(height: AppDimensions.gap16),
            _Section(
              title: RecipeDetailsTexts.instructionsTitle,
              items: recipe.instructions,
              numbered: true,
            ),
          ],
        ),
      ),
    );
  }
}

class _Section extends StatelessWidget {
  const _Section({
    required this.title,
    required this.items,
    this.numbered = false,
  });

  final String title;
  final List<String> items;
  final bool numbered;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: AppDimensions.gap8),
        ...items.asMap().entries.map(
              (entry) => Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: AppDimensions.gap4),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      numbered ? '${entry.key + 1}.' : '•',
                      style: textTheme.bodyLarge,
                    ),
                    const SizedBox(width: AppDimensions.gap8),
                    Expanded(
                      child: Text(
                        entry.value,
                        style: textTheme.bodyLarge,
                      ),
                    ),
                  ],
                ),
              ),
            ),
      ],
    );
  }
}

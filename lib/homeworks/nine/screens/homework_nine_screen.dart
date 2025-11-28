import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_application_grebenyuk/constants/dimensions.dart';
import 'package:flutter_application_grebenyuk/constants/ui_texts.dart';
import 'package:flutter_application_grebenyuk/homeworks/nine/bloc/recipe_bloc.dart';
import 'package:flutter_application_grebenyuk/homeworks/nine/models/recipe.dart';
import 'package:flutter_application_grebenyuk/homeworks/nine/screens/recipe_details_screen.dart';
import 'package:flutter_application_grebenyuk/homeworks/nine/screens/recipe_form_screen.dart';
import 'package:flutter_application_grebenyuk/widgets/app_scaffold.dart';

class HomeworkNineScreen extends StatelessWidget {
  const HomeworkNineScreen({super.key});

  static const String routeName = '/homework-nine';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => RecipeBloc(),
      child: const _RecipeListView(),
    );
  }
}

class _RecipeListView extends StatelessWidget {
  const _RecipeListView();

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: HomeworkNineTexts.appBarTitle,
      body: BlocBuilder<RecipeBloc, RecipeState>(
        builder: (context, state) {
          if (state.recipes.isEmpty) {
            return const Center(
              child: Text(
                HomeworkNineTexts.emptyListMessage,
                textAlign: TextAlign.center,
              ),
            );
          }
          return ListView.builder(
            padding:
                const EdgeInsets.all(AppDimensions.paddingDefault),
            itemCount: state.recipes.length,
            itemBuilder: (context, index) {
              final Recipe recipe = state.recipes[index];
              return Card(
                margin:
                    const EdgeInsets.only(bottom: AppDimensions.gap12),
                elevation: 2,
                child: ListTile(
                  leading: SizedBox(
                    width: AppDimensions.recipeListImageSize,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(
                        AppDimensions.borderRadiusSmall,
                      ),
                      child: Image.network(
                        recipe.imageUrl,
                        width: AppDimensions.recipeListImageSize,
                        height: AppDimensions.recipeListImageSize,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => const Icon(Icons.image),
                      ),
                    ),
                  ),
                  title: Text(recipe.title),
                  subtitle: Text(
                    recipe.description,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute<void>(
                        builder: (_) => RecipeDetailsScreen(recipe: recipe),
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _openAddRecipeForm(context),
        child: const Icon(Icons.add),
      ),
    );
  }

  void _openAddRecipeForm(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => BlocProvider.value(
          value: context.read<RecipeBloc>(),
          child: const RecipeFormScreen(),
        ),
      ),
    );
  }
}

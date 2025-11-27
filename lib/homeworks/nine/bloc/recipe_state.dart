part of 'recipe_bloc.dart';

class RecipeState extends Equatable {
  const RecipeState({required this.recipes});

  final List<Recipe> recipes;

  RecipeState copyWith({List<Recipe>? recipes}) {
    return RecipeState(recipes: recipes ?? this.recipes);
  }

  @override
  List<Object> get props => [recipes];
}

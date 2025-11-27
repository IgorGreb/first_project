part of 'recipe_bloc.dart';

sealed class RecipeEvent extends Equatable {
  const RecipeEvent();

  @override
  List<Object?> get props => [];
}

class RecipeAdded extends RecipeEvent {
  const RecipeAdded(this.recipe);

  final Recipe recipe;

  @override
  List<Object> get props => [recipe];
}

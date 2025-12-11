import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_application_grebenyuk/constants/recipes.dart';
import 'package:flutter_application_grebenyuk/homeworks/home_work_9/models/recipe.dart';

part 'recipe_event.dart';
part 'recipe_state.dart';

class RecipeBloc extends Bloc<RecipeEvent, RecipeState> {
  RecipeBloc() : super(const RecipeState(recipes: recipeSeedData)) {
    on<RecipeAdded>(_onRecipeAdded);
  }

  void _onRecipeAdded(RecipeAdded event, Emitter<RecipeState> emit) {
    final List<Recipe> updatedRecipes = List<Recipe>.from(state.recipes)
      ..add(event.recipe);
    emit(state.copyWith(recipes: updatedRecipes));
  }
}

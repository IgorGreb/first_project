import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_application_grebenyuk/constants/dimensions.dart';
import 'package:flutter_application_grebenyuk/constants/ui_texts.dart';
import 'package:flutter_application_grebenyuk/homeworks/nine/bloc/recipe_bloc.dart';
import 'package:flutter_application_grebenyuk/homeworks/nine/models/recipe.dart';

class RecipeFormScreen extends StatefulWidget {
  const RecipeFormScreen({super.key});

  @override
  State<RecipeFormScreen> createState() => _RecipeFormScreenState();
}

class _RecipeFormScreenState extends State<RecipeFormScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _ingredientsController = TextEditingController();
  final TextEditingController _instructionsController = TextEditingController();
  final TextEditingController _imageUrlController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _ingredientsController.dispose();
    _instructionsController.dispose();
    _imageUrlController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(RecipeFormTexts.appBarTitle),
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppDimensions.paddingDefault),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              _buildTextField(
                controller: _titleController,
                label: RecipeFormTexts.titleLabel,
                hint: RecipeFormTexts.titleHint,
              ),
              const SizedBox(height: AppDimensions.gap12),
              _buildTextField(
                controller: _descriptionController,
                label: RecipeFormTexts.descriptionLabel,
                hint: RecipeFormTexts.descriptionHint,
                maxLines: 3,
              ),
              const SizedBox(height: AppDimensions.gap12),
              _buildTextField(
                controller: _imageUrlController,
                label: RecipeFormTexts.imageUrlLabel,
                hint: RecipeFormTexts.imageUrlHint,
              ),
              const SizedBox(height: AppDimensions.gap12),
              _buildTextField(
                controller: _ingredientsController,
                label: RecipeFormTexts.ingredientsLabel,
                hint: RecipeFormTexts.ingredientsHint,
                maxLines: 5,
              ),
              const SizedBox(height: AppDimensions.gap12),
              _buildTextField(
                controller: _instructionsController,
                label: RecipeFormTexts.instructionsLabel,
                hint: RecipeFormTexts.instructionsHint,
                maxLines: 6,
              ),
              const SizedBox(height: AppDimensions.gap20),
              FilledButton.icon(
                onPressed: _saveRecipe,
                icon: const Icon(Icons.save),
                label: const Text(RecipeFormTexts.saveButton),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    int maxLines = 1,
  }) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        labelText: label,
        hintText: hint,
      ),
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return RecipeFormTexts.fieldValidationError;
        }
        return null;
      },
    );
  }

  void _saveRecipe() {
    if (!(_formKey.currentState?.validate() ?? false)) {
      return;
    }

    final Recipe recipe = Recipe(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: _titleController.text.trim(),
      description: _descriptionController.text.trim(),
      ingredients: _splitMultilineText(_ingredientsController.text),
      instructions: _splitMultilineText(_instructionsController.text),
      imageUrl: _imageUrlController.text.trim(),
    );

    context.read<RecipeBloc>().add(RecipeAdded(recipe));
    Navigator.of(context).pop();
  }

  List<String> _splitMultilineText(String raw) {
    return raw
        .split('\n')
        .map((line) => line.trim())
        .where((line) => line.isNotEmpty)
        .toList();
  }
}

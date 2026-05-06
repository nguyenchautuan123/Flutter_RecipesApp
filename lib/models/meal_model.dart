class Meal {
  final String idMeal;
  final String strMeal;
  final String? strArea;
  final String? strCategory;
  final String strMealThumb;
  final String? strInstructions;
  final List<String> ingredients;
  final List<String> measures;

  Meal({
    required this.idMeal,
    required this.strMeal,
    this.strArea,
    this.strCategory,
    required this.strMealThumb,
    this.strInstructions,
    required this.ingredients,
    required this.measures
  });

  factory Meal.fromJson(Map<String, dynamic> json){
    List<String> ingredients = [];
    List<String> measures = [];

    for(int i=1; i<=20; i++){
      final ingredient = json['strIngredient$i'];
      final measure = json['strMeasure$i'];
      if(ingredient != null && ingredient.toString().trim().isNotEmpty){
        ingredients.add(ingredient);
        measures.add(measure);
      }
    }

    return Meal(
        idMeal: json['idMeal'] ?? '',
        strMeal: json['strMeal'] ?? '',
        strArea: json['idArea'],
        strCategory: json['strCategory'],
        strMealThumb: json['strMealThumb'] ?? '',
        strInstructions: json['strInstructions'],
        ingredients: ingredients,
        measures: measures,
    );
  }
}
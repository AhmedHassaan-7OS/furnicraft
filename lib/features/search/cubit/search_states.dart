import '../../../../data/models/product_model.dart';

abstract class SearchState {
  const SearchState();
}

class SearchInitial extends SearchState {}

class SearchLoading extends SearchState {}

class SearchLoaded extends SearchState {
  final List<ProductModel> results;
  final String query;

  const SearchLoaded({required this.results, required this.query});
}

class SearchError extends SearchState {
  final String message;
  const SearchError(this.message);
}

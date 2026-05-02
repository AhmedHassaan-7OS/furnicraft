import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../data/repositories/products_repository.dart';
import 'search_states.dart';

class SearchCubit extends Cubit<SearchState> {
  final ProductsRepository _productsRepository;

  SearchCubit({required ProductsRepository productsRepository})
      : _productsRepository = productsRepository,
        super(SearchInitial());

  Future<void> search(String query) async {
    if (query.trim().isEmpty) {
      emit(SearchInitial());
      return;
    }
    emit(SearchLoading());
    try {
      final results = await _productsRepository.search(query.trim());
      emit(SearchLoaded(results: results, query: query.trim()));
    } catch (e) {
      emit(SearchError(e.toString()));
    }
  }

  void clear() => emit(SearchInitial());
}

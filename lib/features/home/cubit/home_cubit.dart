import 'package:flutter_bloc/flutter_bloc.dart';
import 'home_states.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(const HomeInitial());

  int _selectedCategoryIndex = 0;

  Future<void> loadHome() async {
    emit(const HomeLoading());
    await Future.delayed(const Duration(milliseconds: 500));
    emit(HomeLoaded(selectedCategoryIndex: _selectedCategoryIndex));
  }

  void selectCategory(int index) {
    _selectedCategoryIndex = index;
    emit(HomeCategoryChanged(selectedIndex: index));
  }
}

abstract class HomeState {
  const HomeState();
}

class HomeInitial extends HomeState {
  const HomeInitial();
}

class HomeLoading extends HomeState {
  const HomeLoading();
}

class HomeLoaded extends HomeState {
  final int selectedCategoryIndex;
  const HomeLoaded({this.selectedCategoryIndex = 0});
}

class HomeCategoryChanged extends HomeState {
  final int selectedIndex;
  const HomeCategoryChanged({required this.selectedIndex});
}

class HomeFailure extends HomeState {
  final String message;
  const HomeFailure({required this.message});
}

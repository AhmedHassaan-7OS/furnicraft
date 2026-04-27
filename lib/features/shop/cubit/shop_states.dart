abstract class ShopState {
  const ShopState();
}

class ShopInitial extends ShopState {
  const ShopInitial();
}

class ShopLoading extends ShopState {
  const ShopLoading();
}

class ShopLoaded extends ShopState {
  final String activeFilter;
  const ShopLoaded({this.activeFilter = 'All'});
}

class ShopFilterChanged extends ShopState {
  final String filter;
  const ShopFilterChanged({required this.filter});
}

class ShopLoadingMore extends ShopState {
  const ShopLoadingMore();
}

class ShopFailure extends ShopState {
  final String message;
  const ShopFailure({required this.message});
}

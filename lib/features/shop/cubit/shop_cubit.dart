import 'package:flutter_bloc/flutter_bloc.dart';
import 'shop_states.dart';

class ShopCubit extends Cubit<ShopState> {
  ShopCubit() : super(const ShopInitial());

  String _activeFilter = 'All';

  Future<void> loadCategory() async {
    emit(const ShopLoading());
    await Future.delayed(const Duration(milliseconds: 400));
    emit(ShopLoaded(activeFilter: _activeFilter));
  }

  void changeFilter(String filter) {
    _activeFilter = filter;
    emit(ShopFilterChanged(filter: filter));
  }

  Future<void> loadMore() async {
    emit(const ShopLoadingMore());
    await Future.delayed(const Duration(seconds: 1));
    emit(ShopLoaded(activeFilter: _activeFilter));
  }
}

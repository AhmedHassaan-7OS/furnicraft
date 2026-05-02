import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'profile_states.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileInitial()) {
    _loadUser();
  }

  void _loadUser() {
    final user = Supabase.instance.client.auth.currentUser;
    if (user != null) {
      emit(ProfileLoaded(user));
    }
  }

  Future<void> signOut() async {
    await Supabase.instance.client.auth.signOut();
    emit(ProfileSignedOut());
  }
}

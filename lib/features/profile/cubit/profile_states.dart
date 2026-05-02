import 'package:supabase_flutter/supabase_flutter.dart';

abstract class ProfileState {
  const ProfileState();
}

class ProfileInitial extends ProfileState {}

class ProfileLoaded extends ProfileState {
  final User user;
  const ProfileLoaded(this.user);
}

class ProfileSignedOut extends ProfileState {}

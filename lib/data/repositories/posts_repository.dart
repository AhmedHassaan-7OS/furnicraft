import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/post_model.dart';

class PostsRepository {
  final SupabaseClient _client;

  PostsRepository({SupabaseClient? client})
      : _client = client ?? Supabase.instance.client;

  Future<List<PostModel>> fetchAll() async {
    final data = await _client
        .from('posts')
        .select()
        .order('id', ascending: true);

    return (data as List<dynamic>)
        .map((e) => PostModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}

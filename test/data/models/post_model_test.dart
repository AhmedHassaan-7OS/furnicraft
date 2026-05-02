import 'package:flutter_test/flutter_test.dart';
import 'package:furnicraft/data/models/post_model.dart';

void main() {
  group('PostModel', () {
    test('fromJson parses correctly', () {
      final json = {
        'id': 1,
        'title': 'Top 5 Living Room Trends',
        'excerpt': 'Discover the hottest trends...',
        'image': 'https://example.com/post.jpg',
      };

      final model = PostModel.fromJson(json);

      expect(model.id, 1);
      expect(model.title, 'Top 5 Living Room Trends');
      expect(model.excerpt, isNotNull);
    });

    test('fromJson handles null excerpt and image', () {
      final json = {'id': 2, 'title': 'Minimal Design'};
      final model = PostModel.fromJson(json);

      expect(model.excerpt, isNull);
      expect(model.image, isNull);
    });
  });
}

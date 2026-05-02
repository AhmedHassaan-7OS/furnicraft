import 'package:flutter_test/flutter_test.dart';
import 'package:furnicraft/data/models/category_model.dart';

void main() {
  group('CategoryModel', () {
    test('fromJson parses correctly', () {
      final json = {
        'id': 1,
        'name': 'Sofas',
        'imageUrl': 'https://example.com/sofa.jpg',
      };

      final model = CategoryModel.fromJson(json);

      expect(model.id, 1);
      expect(model.name, 'Sofas');
      expect(model.imageUrl, 'https://example.com/sofa.jpg');
    });

    test('fromJson handles null image', () {
      final json = {'id': 2, 'name': 'Tables', 'imageUrl': null};
      final model = CategoryModel.fromJson(json);

      expect(model.imageUrl, isNull);
    });

    test('toJson round-trips correctly', () {
      const model = CategoryModel(id: 3, name: 'Chairs', imageUrl: null);
      final json = model.toJson();

      expect(json['id'], 3);
      expect(json['name'], 'Chairs');
      expect(json['imageUrl'], isNull);
    });
  });
}

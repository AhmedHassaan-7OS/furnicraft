import 'package:flutter_test/flutter_test.dart';
import 'package:furnicraft/data/models/product_model.dart';

void main() {
  group('ProductModel', () {
    final fullJson = {
      'id': 10,
      'name': 'Luxury Sofa',
      'description': 'A comfortable sofa',
      'price': 1299.99,
      'categoryId': 'Sofas',
      'sku': 'SOF-001',
      'tags': ['luxury', 'fabric'],
      'imageUrl': 'https://example.com/sofa.jpg',
      'images': [
        'https://example.com/sofa1.jpg',
        'https://example.com/sofa2.jpg'
      ],
      'specs': {'material': 'Fabric', 'weight': '45kg'},
      'isFeatured': true,
    };

    test('fromJson parses all fields correctly', () {
      final model = ProductModel.fromJson(fullJson);

      expect(model.id, 10);
      expect(model.name, 'Luxury Sofa');
      expect(model.price, 1299.99);
      expect(model.categoryId, 'Sofas');
      expect(model.tags, ['luxury', 'fabric']);
      expect(model.images?.length, 2);
      expect(model.specs?['material'], 'Fabric');
      expect(model.isFeatured, isTrue);
    });

    test('fromJson handles null optional fields', () {
      final sparseJson = {
        'id': 11,
        'name': 'Simple Chair',
        'price': 199.00,
      };

      final model = ProductModel.fromJson(sparseJson);

      expect(model.description, isNull);
      expect(model.imageUrl, isNull);
      expect(model.tags, isNull);
      expect(model.isFeatured, isFalse);
    });

    test('toJson serializes correctly', () {
      final model = ProductModel.fromJson(fullJson);
      final json = model.toJson();

      expect(json['id'], 10);
      expect(json['categoryId'], 'Sofas');
      expect(json['tags'], ['luxury', 'fabric']);
    });
  });
}

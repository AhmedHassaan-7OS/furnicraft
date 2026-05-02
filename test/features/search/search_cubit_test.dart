import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:furnicraft/data/models/product_model.dart';
import 'package:furnicraft/data/repositories/products_repository.dart';
import 'package:furnicraft/features/search/cubit/search_cubit.dart';
import 'package:furnicraft/features/search/cubit/search_states.dart';

@GenerateMocks([ProductsRepository])
import 'search_cubit_test.mocks.dart';

void main() {
  late MockProductsRepository mockRepo;
  late SearchCubit cubit;

  setUp(() {
    mockRepo = MockProductsRepository();
    cubit = SearchCubit(productsRepository: mockRepo);
  });

  tearDown(() => cubit.close());

  const fakeProduct = ProductModel(
    id: 1,
    name: 'Test Chair',
    price: 299.0,
    categoryId: 'Chairs',
  );

  group('SearchCubit', () {
    blocTest<SearchCubit, SearchState>(
      'emits [SearchLoading, SearchLoaded] when search returns results',
      build: () {
        when(mockRepo.search('chair'))
            .thenAnswer((_) async => [fakeProduct]);
        return cubit;
      },
      act: (c) => c.search('chair'),
      expect: () => [
        isA<SearchLoading>(),
        isA<SearchLoaded>()
            .having((s) => s.results.length, 'results count', 1)
            .having((s) => s.query, 'query', 'chair'),
      ],
    );

    blocTest<SearchCubit, SearchState>(
      'emits [SearchLoading, SearchLoaded with empty] when no results',
      build: () {
        when(mockRepo.search('xyz'))
            .thenAnswer((_) async => []);
        return cubit;
      },
      act: (c) => c.search('xyz'),
      expect: () => [
        isA<SearchLoading>(),
        isA<SearchLoaded>()
            .having((s) => s.results, 'results', isEmpty),
      ],
    );

    blocTest<SearchCubit, SearchState>(
      'emits [SearchInitial] when query is empty',
      build: () => cubit,
      act: (c) => c.search(''),
      expect: () => [isA<SearchInitial>()],
    );

    blocTest<SearchCubit, SearchState>(
      'emits [SearchLoading, SearchError] on exception',
      build: () {
        when(mockRepo.search(any)).thenThrow(Exception('Network error'));
        return cubit;
      },
      act: (c) => c.search('sofa'),
      expect: () => [
        isA<SearchLoading>(),
        isA<SearchError>(),
      ],
    );

    blocTest<SearchCubit, SearchState>(
      'clear() emits SearchInitial',
      build: () => cubit,
      act: (c) => c.clear(),
      expect: () => [isA<SearchInitial>()],
    );
  });
}

import 'package:bloc/bloc.dart';
import 'package:food_delivery_app/blocs/product_event.dart';
import 'package:food_delivery_app/blocs/product_state.dart';
import 'package:food_delivery_app/repositories/product_repository.dart';
import 'package:food_delivery_app/services/api_services.dart';

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  final ProductRepository productRepository;

  ProductsBloc(this.productRepository) : super(ProductsLoading()) {
    on<FetchProducts>(_onFetchProducts);
    on<SearchProducts>(_onSearchProducts);
  }

  Future<void> _onFetchProducts(
      FetchProducts event, Emitter<ProductsState> emit) async {
    emit(ProductsLoading());
    try {
      final products = await productRepository.fetchProducts();
      emit(ProductsLoaded(products));
    } catch (e) {
      emit(ProductsError('Failed to fetch products: $e'));
    }
  }

  Future<void> _onSearchProducts(
      SearchProducts event, Emitter<ProductsState> emit) async {
    emit(ProductsLoading());
    try {
      final products =
          await productRepository.fetchProducts(keyword: event.query);
      emit(ProductsLoaded(products));
    } catch (e) {
      emit(ProductsError('Failed to search products: $e'));
    }
  }
}

import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_view/exceptions/api_exception.dart';
import 'package:product_view/models/product_list_result.dart';
import 'package:product_view/repositories/products_repository.dart';

part 'products_event.dart';
part 'products_state.dart';

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  final IProductsRepository productRepository;

  ProductsBloc({required this.productRepository}) : super(ProductsLoadingState()) {
    on<FetchProductsEvent>(_onFetchProductsEvent);
  }

  // try to fetch API data from products repo
  FutureOr<void> _onFetchProductsEvent(FetchProductsEvent event, Emitter<ProductsState> emit) async {
    emit(ProductsLoadingState());

    final result = await productRepository.fetchProducts();
    result.when(
        (success) => emit(
              ProductsLoadedState(
                result: success,
              ),
            ), (error) {
      if (error is ApiException) {
        emit(ProductsErrorState('We could not fetch data from the server. Status code - ${error.statusCode}.'));
      } else {
        emit(const ProductsErrorState('Unknown error'));
      }
    });
  }
}

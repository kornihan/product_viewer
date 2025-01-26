part of 'products_bloc.dart';

sealed class ProductsState extends Equatable {
  const ProductsState();

  @override
  List<Object?> get props => [];
}

// Loading state
class ProductsLoadingState extends ProductsState {}

// Data loaded state
class ProductsLoadedState extends ProductsState {
  final ProductListResult result;

  const ProductsLoadedState({required this.result});

  @override
  List<Object?> get props => [result];
}

// Error state
class ProductsErrorState extends ProductsState {
  final String message;

  const ProductsErrorState(this.message);

  @override
  List<Object?> get props => [message];
}

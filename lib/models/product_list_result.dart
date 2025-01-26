import 'package:equatable/equatable.dart';
import 'package:product_view/models/product_model.dart';

enum DataSource {
  db,
  network,
}

class ProductListResult extends Equatable {
  final DataSource dataSource;
  final List<ProductModel> data;

  const ProductListResult({
    required this.dataSource,
    required this.data,
  });

  @override
  List<Object?> get props => [dataSource, data];
}

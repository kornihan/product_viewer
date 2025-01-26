import 'dart:convert';

import 'package:http/http.dart';
import 'package:multiple_result/multiple_result.dart';
import 'package:product_view/exceptions/api_exception.dart';
import 'package:product_view/exceptions/no_internet_exception.dart';
import 'package:product_view/models/product_list_result.dart';
import 'package:product_view/models/product_model.dart';
import 'package:product_view/network/api_client.dart';
import 'package:product_view/repositories/local_db/products_db.dart';

// abstract class and implementation for products repo where products are fetched
abstract class IProductsRepository {
  Future<Result<ProductListResult, Exception>> fetchProducts();
}

class ProductsRepositoryImpl implements IProductsRepository {
  final ApiClient apiClient;
  final IProductsDb productsDb;

  ProductsRepositoryImpl({required this.apiClient, required this.productsDb});

  @override
  Future<Result<ProductListResult, Exception>> fetchProducts() async {
    try {
      final response = await apiClient.get('/products') as Response;

      if (response.statusCode >= 200 && response.statusCode < 300) {
        // success use case
        final List<dynamic> resp = jsonDecode(response.body);

        final productList = resp.map((e) => ProductModel.fromJson(e)).toList();
        try {
          await productsDb.saveProducts(productList);
        } catch (_) {
          //if error - nothing happen, just local db stays in prev state
        }
        return Result.success(ProductListResult(dataSource: DataSource.network, data: productList));
      } else {
        throw ApiException(message: 'Error ${response.body}', statusCode: response.statusCode);
      }
    } catch (e) {
      if (e is ApiException) {
        return Result.error(e);
      } else if (e is NoInternetException) {
        // get products from local db
        final productsFromDb = await productsDb.fetchProducts();
        return Result.success(ProductListResult(
          dataSource: DataSource.db,
          data: productsFromDb,
        ));
      }
      return Result.error(e as Exception);
    }
  }
}

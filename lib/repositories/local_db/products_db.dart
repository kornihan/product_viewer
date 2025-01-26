import 'package:hive_ce/hive.dart';
import 'package:product_view/models/product_model.dart';

// abstarct class and implementation of local db(save and get products methods)
abstract class IProductsDb {
  Future<List<ProductModel>> fetchProducts();
  Future<void> saveProducts(List<ProductModel> products);
}

class ProductsDbImpl implements IProductsDb {
  final Box box;

  ProductsDbImpl({required this.box});
  @override
  Future<List<ProductModel>> fetchProducts() async {
    try {
      final products = box.values.toList().cast<ProductModel>();
      return products;
    } catch (e) {
      //local db is empty, return empty list
      return [];
    }
  }

  @override
  Future<void> saveProducts(List<ProductModel> products) async {
    try {
      await box.clear();
      await box.addAll(products);
    } catch (e) {
      print('Could not save products: $e');
    }
  }
}

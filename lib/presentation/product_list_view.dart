import 'package:flutter/material.dart';
import 'package:product_view/models/product_model.dart';
import 'package:product_view/presentation/custom_hero_image.dart';
import 'package:product_view/presentation/product_detail_screen.dart';

class ProductListView extends StatelessWidget {
  const ProductListView({
    super.key,
    required this.products,
  });

  final List<ProductModel> products;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: products.length,
      separatorBuilder: (context, index) => const Divider(),
      itemBuilder: (context, index) {
        final product = products[index];
        return ListTile(
          leading: CustomHeroImage(image: product.image),
          title: Text(
            product.title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          trailing: Text(
            '\$${product.price}',
            style: const TextStyle(
              fontSize: 14,
            ),
          ),
          onTap: () =>
              Navigator.push(context, MaterialPageRoute(builder: (context) => ProductDetailScreen(product: product))),
        );
      },
    );
  }
}

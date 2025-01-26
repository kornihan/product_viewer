import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_view/bloc/products_bloc.dart';
import 'package:product_view/models/product_list_result.dart';
import 'package:product_view/presentation/product_list_view.dart';
import 'package:product_view/presentation/reload_button.dart';

class ProductScreenBody extends StatefulWidget {
  const ProductScreenBody({super.key});

  @override
  State<ProductScreenBody> createState() => _ProductScreenBodyState();
}

class _ProductScreenBodyState extends State<ProductScreenBody> {
  @override
  void initState() {
    super.initState();
    context.read<ProductsBloc>().add(const FetchProductsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductsBloc, ProductsState>(
      builder: (BuildContext context, ProductsState state) {
        return switch (state) {
          ProductsLoadingState() => const Center(
              child: CircularProgressIndicator(),
            ),
          final ProductsLoadedState state => Column(
              children: [
                if (state.result.dataSource == DataSource.db) ...[
                  const Text('Data is from local storage!'),
                  ReloadButton(
                    onTap: () => context.read<ProductsBloc>().add(const FetchProductsEvent()),
                  ),
                ],
                Expanded(
                  child: ProductListView(
                    products: state.result.data,
                  ),
                )
              ],
            ),
          ProductsErrorState() => Center(
              child: Column(
                children: [
                  Text(
                    state.message,
                    style: const TextStyle(color: Colors.red),
                  ),
                  ReloadButton(
                    onTap: () => context.read<ProductsBloc>().add(const FetchProductsEvent()),
                  ),
                ],
              ),
            ),
        };
      },
    );
  }
}

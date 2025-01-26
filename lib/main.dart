import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:product_view/bloc/products_bloc.dart';
import 'package:product_view/models/product_model.dart';
import 'package:product_view/models/rating_model.dart';
import 'package:product_view/network/api_client.dart';
import 'package:product_view/presentation/product_screen_body.dart';
import 'package:product_view/repositories/local_db/products_db.dart';
import 'package:product_view/repositories/products_repository.dart';

final GetIt locator = GetIt.instance;
void main() async {
  runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();
    await init();

    runApp(const MainApp());
  }, (Object exception, StackTrace stackTrace) async {
    // Track error 
  });
}

// initialize dependencies for project(db, blocs, repositories etc)
Future<void> init() async {
  await Hive.initFlutter();

  Hive.registerAdapter(RatingModelAdapter());
  Hive.registerAdapter(ProductModelAdapter());

  final box = await Hive.openBox<ProductModel>('productsBox');

  locator.registerSingleton<ApiClient>(ApiClient(
    baseUrl: 'https://fakestoreapi.com',
  ));
  locator.registerSingleton<IProductsDb>(ProductsDbImpl(box: box));

  locator.registerSingleton<IProductsRepository>(
    ProductsRepositoryImpl(apiClient: locator(), productsDb: locator()),
  );

  locator.registerFactory<ProductsBloc>(() => ProductsBloc(productRepository: locator()));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Products"),
          centerTitle: true,
        ),
        body: Center(
          child: BlocProvider(
            create: (context) => locator.get<ProductsBloc>(),
            child: const ProductScreenBody(),
          ),
        ),
      ),
    );
  }
}

import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_assngmnt/dio_client.dart';
import 'product.dart';

class ProductDisplayPage extends StatelessWidget {
  final int id;

  const ProductDisplayPage({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: FutureBuilder(
            future: getProduct(id),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final Product? product = snapshot.data;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Text(
                        product?.title ?? "Product",
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Center(
                      child: CachedNetworkImage(
                        imageUrl: product?.thumbnail ??
                            'https://via.placeholder.com/150',
                        height: 250,
                        fit: BoxFit.contain,
                        placeholder: (context, url) {
                          return const Center(
                              child: CircularProgressIndicator());
                        },
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      product?.description ?? "",
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Price: \$${product?.price}',
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Category: ${product?.category}',
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 20),
                    const Spacer(),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.green,
                        ),
                        child: const Text(
                          'Add to Cart',
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              } else if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else {
                return const Center(
                  child: Text('Failed to get Product'),
                );
              }
            }),
      ),
    );
  }
}

Future<Product> getProduct(int id) async {
  DioClient dioClient = DioClient();
  String endpoint = 'https://dummyjson.com/products/$id';

  final response = await dioClient.get(endpoint);
  if (response.statusCode == 200) {
    log(response.toString());
    return Product.fromJson(response.data);
  } else {
    return Future.error("error");
  }
}

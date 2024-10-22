import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_assngmnt/category_product_screen.dart';
import 'dio_client.dart';
import 'category.dart';

class AllCategoriesScreen extends StatefulWidget {
  const AllCategoriesScreen({super.key});

  @override
  State<AllCategoriesScreen> createState() => _AllCategoriesScreenState();
}

class _AllCategoriesScreenState extends State<AllCategoriesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: TextField(
            decoration: InputDecoration(
              hintText: 'Search',
              border: InputBorder.none,
              fillColor: Colors.grey[200],
              filled: true,
              prefixIcon: const Icon(Icons.search),
              suffixIcon: const Icon(Icons.mic),
              contentPadding: const EdgeInsets.symmetric(vertical: 12.0),
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_alt),
            onPressed: () {
              // Navigate to the filter screen
            },
          ),
        ],
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
           
            const Padding(
              padding: EdgeInsets.only(bottom: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Categories',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

         
            Expanded(
              child: FutureBuilder<List<Category>>(
                future: getCategories(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasData) {
                    return GridView.builder(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                        childAspectRatio: 1.2, 
                      ),
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        final Category category = snapshot.data![index];
                        return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => CategoryProductScreen(
                                    category: category.slug,
                                  ),
                                ),
                              );
                            },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.2),
                                  blurRadius: 8,
                                  spreadRadius: 4,
                                ),
                              ],
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CachedNetworkImage(
                                  imageUrl: category.url,
                                  height: 50,
                                  placeholder: (context, url) => const CircularProgressIndicator(),
                                  errorWidget: (context, url, error) =>
                                      const Icon(Icons.error),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  category.name,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  } else {
                    return const Center(child: Text('Failed to load categories'));
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Fetch categories function
Future<List<Category>> getCategories() async {
  DioClient dioClient = DioClient();

  final response = await dioClient.get('https://dummyjson.com/products/categories');
  if (response.statusCode == 200) {
    List<Category> categoryList = response.data
        .map<Category>((category) => Category.fromJson(category))
        .toList();
    return categoryList;
  } else {
    return Future.error("Failed to load categories");
  }
}

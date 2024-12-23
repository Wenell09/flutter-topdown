import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';
import 'package:topdown_store/bloc/product/product_bloc.dart';
import 'package:topdown_store/pages/detail_page.dart';
import 'package:topdown_store/repository/product_repo.dart';

class SeeMorePage extends StatelessWidget {
  final String categoryId, title;
  const SeeMorePage({super.key, required this.categoryId, required this.title});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductBloc(ProductRepo())
        ..add(GetProductByCategoryId(categoryId: categoryId)),
      child: BlocBuilder<ProductBloc, ProductState>(
        builder: (context, state) {
          if (state is ProductLoading) {
            return ShimmerLoading(title: title);
          } else if (state is ProductLoaded) {
            return Scaffold(
              appBar: AppBar(
                title: Text(title),
                centerTitle: true,
              ),
              body: GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3, // Empat item dalam satu baris
                  mainAxisSpacing: 15, // Jarak antar baris
                  crossAxisSpacing: 1, // Jarak antar kolom
                  childAspectRatio: 4 / 5, // Lebar dan tinggi item sama
                ),
                padding: const EdgeInsets.all(8.0),
                itemBuilder: (context, index) {
                  var data = state.allProduct[index];
                  return InkWell(
                    borderRadius: BorderRadius.circular(10),
                    onTap: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>
                          DetailPage(productId: data.productId),
                    )),
                    child: Card(
                      elevation: 5,
                      shadowColor: Colors.black,
                      child: Column(
                        children: [
                          Expanded(
                            flex: 5,
                            child: ClipRRect(
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10),
                              ),
                              child: Image.network(
                                data.image,
                                fit: BoxFit.cover,
                                width: MediaQuery.of(context).size.width,
                              ),
                            ),
                          ),
                          Flexible(
                            flex: 2,
                            child: Center(
                              child: Text(
                                data.name,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
                itemCount: state.allProduct.length,
              ),
            );
          }
          return ShimmerLoading(title: title);
        },
      ),
    );
  }
}

class ShimmerLoading extends StatelessWidget {
  const ShimmerLoading({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        centerTitle: true,
      ),
      body: Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        child: GridView(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3, // Empat item dalam satu baris
            mainAxisSpacing: 15, // Jarak antar baris
            crossAxisSpacing: 1, // Jarak antar kolom
            childAspectRatio: 4 / 5, // Lebar dan tinggi item sama
          ),
          padding: const EdgeInsets.all(8.0),
          children: List.generate(
            12,
            (index) => const Card(),
          ),
        ),
      ),
    );
  }
}

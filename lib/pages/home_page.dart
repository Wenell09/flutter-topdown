import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';
import 'package:topdown_store/bloc/product/product_bloc.dart';
import 'package:topdown_store/data/model/product_model.dart';
import 'package:topdown_store/pages/detail_page.dart';
import 'package:topdown_store/pages/see_more_page.dart';
import 'package:topdown_store/repository/product_repo.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductBloc(ProductRepo())
        ..add(GetProductGames(categoryId: "KT01"))
        ..add(GetProductEntertainment(categoryId: "KT02"))
        ..add(GetProductTagihan(categoryId: "KT03")),
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Topdown Store",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
        ),
        body: BlocBuilder<ProductBloc, ProductState>(
          builder: (context, state) {
            if (state is ProductLoading) {
              return const HomeShimmerLoading();
            } else if (state is ProductLoaded) {
              return ListView(
                children: [
                  UnconstrainedBox(
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.9,
                      height: 170,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        image: const DecorationImage(
                          image: AssetImage("image/banner.jpg"),
                          fit: BoxFit.fill,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      "Mau top up apa hari ini?",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  (state.games.isEmpty)
                      ? Container()
                      : ProductCard(
                          product: state.games,
                        ),
                  (state.entertainment.isEmpty)
                      ? Container()
                      : ProductCard(
                          product: state.entertainment,
                        ),
                  (state.tagihan.isEmpty)
                      ? Container()
                      : ProductCard(
                          product: state.tagihan,
                        ),
                ],
              );
            }
            return const HomeShimmerLoading();
          },
        ),
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  final List<ProductModel> product;
  const ProductCard({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Top up ${product[0].category}",
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              InkWell(
                onTap: () => Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => SeeMorePage(
                    categoryId: product[0].categoryId,
                    title: product[0].category,
                  ),
                )),
                child: const Text(
                  "Lihat Lainnya",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.blue,
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.all(10),
          margin: const EdgeInsets.symmetric(horizontal: 5),
          width: MediaQuery.of(context).size.width,
          height: 170,
          child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            physics: const ScrollPhysics(),
            itemBuilder: (context, index) {
              final data = product[index];
              return InkWell(
                borderRadius: BorderRadius.circular(10),
                onTap: () => Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => DetailPage(productId: data.productId),
                )),
                child: Card(
                  elevation: 5,
                  shadowColor: Colors.black,
                  child: Container(
                    width: 115,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    ),
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
                                errorBuilder: (context, error, stackTrace) =>
                                    const Center(
                                  child: CircularProgressIndicator(),
                                ),
                                data.image,
                                fit: BoxFit.cover,
                                width: MediaQuery.of(context).size.width,
                              ),
                            )),
                        Flexible(
                          flex: 2,
                          child: Center(
                            child: Text(
                              data.name,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              );
            },
            itemCount: (product.length > 3) ? 3 : product.length,
          ),
        )
      ],
    );
  }
}

class HomeShimmerLoading extends StatelessWidget {
  const HomeShimmerLoading({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Shimmer.fromColors(
          baseColor: Colors.grey.shade300,
          highlightColor: Colors.grey.shade100,
          child: UnconstrainedBox(
            child: Container(
              width: MediaQuery.of(context).size.width * 0.9,
              height: 170,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Shimmer.fromColors(
          baseColor: Colors.grey.shade300,
          highlightColor: Colors.grey.shade100,
          child: Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: UnconstrainedBox(
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.55,
                  height: 27,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5)),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        const RowTitleShimmerLoading(),
        const CardShimmerLoading(),
        const SizedBox(
          height: 10,
        ),
        const RowTitleShimmerLoading(),
        const CardShimmerLoading(),
        const SizedBox(
          height: 10,
        ),
        const RowTitleShimmerLoading(),
        const CardShimmerLoading(),
      ],
    );
  }
}

class RowTitleShimmerLoading extends StatelessWidget {
  const RowTitleShimmerLoading({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Shimmer.fromColors(
            baseColor: Colors.grey.shade300,
            highlightColor: Colors.grey.shade100,
            child: Container(
              width: MediaQuery.of(context).size.width * 0.3,
              height: 27,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(5)),
            ),
          ),
          Shimmer.fromColors(
            baseColor: Colors.grey.shade300,
            highlightColor: Colors.grey.shade100,
            child: Container(
              width: MediaQuery.of(context).size.width * 0.2,
              height: 27,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(5)),
            ),
          )
        ],
      ),
    );
  }
}

class CardShimmerLoading extends StatelessWidget {
  const CardShimmerLoading({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(10),
        width: MediaQuery.of(context).size.width,
        height: 170,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return Shimmer.fromColors(
              baseColor: Colors.grey.shade300,
              highlightColor: Colors.grey.shade100,
              child: Card(
                child: Container(
                  width: 115,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                  ),
                ),
              ),
            );
          },
          itemCount: 3,
        ));
  }
}

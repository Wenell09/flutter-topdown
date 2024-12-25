import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:topdown_store/bloc/item/item_bloc.dart';
import 'package:topdown_store/bloc/product/product_bloc.dart';
import 'package:topdown_store/bloc/select_category_product/select_product_bloc.dart';
import 'package:topdown_store/bloc/theme/theme_bloc.dart';
import 'package:topdown_store/bloc/user/user_bloc.dart';
import 'package:topdown_store/data/model/product_model.dart';
import 'package:topdown_store/pages/admin_detail_item_page.dart';
import 'package:topdown_store/pages/drawer_page.dart';
import 'package:topdown_store/widgets/shimmer_card.dart';

class AdminItemPage extends StatelessWidget {
  const AdminItemPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Item"),
        centerTitle: true,
      ),
      drawer: BlocBuilder<UserBloc, UserState>(
        builder: (context, userState) {
          if (userState is UserLoaded) {
            return DrawerPage(
              data: userState.user[0],
            );
          }
          return Container();
        },
      ),
      body: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, themeState) {
          return ListView(
            children: [
              BlocListener<SelectCategoryProductBloc,
                  SelectCategoryProductState>(
                listener: (context, selectState) {
                  context.read<ProductBloc>().add(
                        GetProductByCategoryId(
                          categoryId: (selectState.index == 0)
                              ? "KT01"
                              : (selectState.index == 1)
                                  ? "KT02"
                                  : "KT03",
                        ),
                      );
                },
                child: BlocBuilder<SelectCategoryProductBloc,
                    SelectCategoryProductState>(
                  builder: (context, selectState) {
                    return SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 35,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: List.generate(3, (index) {
                          return GestureDetector(
                            onTap: () {
                              context
                                  .read<SelectCategoryProductBloc>()
                                  .add(SelectCategoryProduct(index: index));
                            },
                            child: Container(
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              width: 110,
                              decoration: BoxDecoration(
                                color: (selectState.index == index)
                                    ? (themeState.isDark
                                        ? Colors.white
                                        : Colors.black)
                                    : (themeState.isDark
                                        ? Colors.black
                                        : Colors.white),
                                borderRadius: BorderRadius.circular(50),
                                border: Border.all(
                                  color: (selectState.index == index)
                                      ? Colors.blue
                                      : (themeState.isDark
                                          ? Colors.white
                                          : Colors.black),
                                  width: 2,
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  (index == 0)
                                      ? "Games"
                                      : (index == 1)
                                          ? "Entertainment"
                                          : "Tagihan",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: (selectState.index == index)
                                        ? (themeState.isDark
                                            ? Colors.black
                                            : Colors.white)
                                        : (themeState.isDark
                                            ? Colors.white
                                            : Colors.black),
                                  ),
                                ),
                              ),
                            ),
                          );
                        }),
                      ),
                    );
                  },
                ),
              ),
              BlocBuilder<ProductBloc, ProductState>(
                builder: (context, state) {
                  if (state is ProductLoading) {
                    return const ShimmerCard();
                  } else if (state is ProductLoaded) {
                    return CardProduct(product: state.allProduct);
                  }
                  return const ShimmerCard();
                },
              ),
            ],
          );
        },
      ),
    );
  }
}

class CardProduct extends StatelessWidget {
  final List<ProductModel> product;
  const CardProduct({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
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
        var data = product[index];
        return InkWell(
          borderRadius: BorderRadius.circular(10),
          onTap: () {
            context.read<ItemBloc>().add(GetItem(productId: data.productId));
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) =>
                  AdminDetailItemPage(productId: data.productId),
            ));
          },
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
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
      itemCount: product.length,
    );
  }
}

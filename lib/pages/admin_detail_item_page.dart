import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:topdown_store/bloc/item/item_bloc.dart';
import 'package:topdown_store/bloc/theme/theme_bloc.dart';
import 'package:topdown_store/pages/add_item_page.dart';
import 'package:topdown_store/pages/edit_item_page.dart';
import 'package:topdown_store/widgets/shimmer_card.dart';

class AdminDetailItemPage extends StatelessWidget {
  final String productId;
  const AdminDetailItemPage({
    super.key,
    required this.productId,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Detail Item"),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: IconButton(
              onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => AddItemPage(productId: productId),
              )),
              icon: const Icon(Icons.add),
            ),
          )
        ],
      ),
      body: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, themeState) {
          return BlocBuilder<ItemBloc, ItemState>(
            builder: (context, state) {
              if (state is ItemLoading) {
                return const ShimmerCard();
              } else if (state is ItemLoaded) {
                if (state.item.isEmpty) {
                  return const Center(
                    child: Text(
                      textAlign: TextAlign.center,
                      "Item untuk produk ini kosong.\nSilahkan tambahkan item!",
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  );
                }
                return ListView(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: GridView.builder(
                        physics: const ScrollPhysics(),
                        shrinkWrap: true,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          mainAxisSpacing: 15,
                          crossAxisSpacing: 1,
                          childAspectRatio: 4 / 5,
                        ),
                        itemBuilder: (context, index) {
                          var data = state.item[index];
                          return InkWell(
                            onTap: () =>
                                Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => EditItemPage(
                                itemId: data.itemId,
                                productId: productId,
                                itemName: data.name,
                                itemPrice: data.price.toString(),
                                itemImage: data.image,
                              ),
                            )),
                            child: Card(
                              elevation: 5,
                              shadowColor: Colors.black,
                              child: Column(
                                children: [
                                  Expanded(
                                    flex: 3,
                                    child: ClipRRect(
                                      borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(10),
                                        topRight: Radius.circular(10),
                                      ),
                                      child: Image.network(
                                        data.image,
                                        fit: BoxFit.cover,
                                        width:
                                            MediaQuery.of(context).size.width,
                                      ),
                                    ),
                                  ),
                                  Flexible(
                                    flex: 1,
                                    child: Center(
                                      child: Text(
                                        data.name,
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                  Flexible(
                                    flex: 1,
                                    child: Center(
                                      child: Text(
                                        "Rp.${data.price}",
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.blue,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                        itemCount: state.item.length,
                      ),
                    )
                  ],
                );
              }
              return const ShimmerCard();
            },
          );
        },
      ),
    );
  }
}

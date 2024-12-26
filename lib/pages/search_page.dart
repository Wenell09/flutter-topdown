import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';
import 'package:topdown_store/bloc/search_product/search_product_bloc.dart';
import 'package:topdown_store/bloc/theme/theme_bloc.dart';
import 'package:topdown_store/bloc/validation_search/input_bloc.dart';
import 'package:topdown_store/pages/detail_page.dart';
import 'package:topdown_store/repository/product_repo.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController inputSearch = TextEditingController();
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => SearchProductBloc(ProductRepo()),
        ),
        BlocProvider(
          create: (context) => InputBloc(),
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Pencarian"),
          centerTitle: true,
        ),
        body: GestureDetector(
          onPanDown: (_) => FocusManager.instance.primaryFocus?.unfocus(),
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: BlocBuilder<ThemeBloc, ThemeState>(
                  builder: (context, themeState) {
                    return Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      margin: const EdgeInsets.only(top: 10),
                      width: MediaQuery.of(context).size.width,
                      height: 50,
                      decoration: BoxDecoration(
                        color: (themeState.isDark)
                            ? Colors.grey[700]!
                            : Colors.grey[200],
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: const [
                          BoxShadow(
                            color: Color(0x3F000000),
                            blurRadius: 4,
                            offset: Offset(0, 4),
                            spreadRadius: 0,
                          )
                        ],
                      ),
                      child: TextField(
                        autofocus: false,
                        textInputAction: TextInputAction.search,
                        controller: inputSearch,
                        onChanged: (value) {
                          context
                              .read<SearchProductBloc>()
                              .add(SearchProduct(name: value));
                          if (value.isNotEmpty) {
                            context.read<InputBloc>().add(ValidationInput(
                                showClearInput: true, value: value));
                          } else {
                            context.read<InputBloc>().add(ValidationInput(
                                showClearInput: false, value: value));
                          }
                        },
                        onSubmitted: (value) {
                          context.read<InputBloc>().add(ValidationInput(
                              showClearInput: true, value: value));
                          context
                              .read<SearchProductBloc>()
                              .add(SearchProduct(name: value));
                        },
                        decoration: InputDecoration(
                          contentPadding:
                              const EdgeInsets.symmetric(vertical: 12),
                          prefixIcon: Icon(
                            Icons.search,
                            size: 30,
                            color: (themeState.isDark)
                                ? Colors.white
                                : Colors.black,
                          ),
                          suffixIcon: BlocBuilder<InputBloc, InputState>(
                            builder: (context, state) {
                              if (state.showClearInput) {
                                return IconButton(
                                  onPressed: () {
                                    FocusScope.of(context).unfocus();
                                    inputSearch.clear();
                                    context.read<InputBloc>().add(
                                        ValidationInput(
                                            showClearInput: false, value: ""));
                                    context
                                        .read<SearchProductBloc>()
                                        .add(SearchProduct(name: ""));
                                  },
                                  icon: Icon(
                                    Icons.clear,
                                    size: 25,
                                    color: (themeState.isDark)
                                        ? Colors.white
                                        : Colors.black,
                                  ),
                                );
                              }
                              return const SizedBox();
                            },
                          ),
                          hintText: "Cari game atau produk di sini...",
                          hintStyle: TextStyle(
                            color: (themeState.isDark)
                                ? Colors.white
                                : Colors.black,
                          ),
                          border: InputBorder.none,
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              BlocBuilder<InputBloc, InputState>(
                builder: (context, inputState) {
                  if (inputState.showClearInput) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: Text(
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        "Hasil pencarian: ${inputState.value}",
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w500),
                      ),
                    );
                  }
                  return Container();
                },
              ),
              const SizedBox(
                height: 10,
              ),
              BlocBuilder<SearchProductBloc, SearchProductState>(
                builder: (context, state) {
                  if (state is SearchProductLoading) {
                    return const ShimmerLoading();
                  } else if (state is SearchProductLoaded) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: GridView.builder(
                        shrinkWrap: true,
                        physics: const ScrollPhysics(),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3, // Empat item dalam satu baris
                          mainAxisSpacing: 15, // Jarak antar baris
                          crossAxisSpacing: 1, // Jarak antar kolom
                          childAspectRatio: 4 / 5, // Lebar dan tinggi item sama
                        ),
                        padding: const EdgeInsets.all(8.0),
                        itemBuilder: (context, index) {
                          var data = state.product[index];
                          return InkWell(
                            borderRadius: BorderRadius.circular(10),
                            onTap: () =>
                                Navigator.of(context).push(MaterialPageRoute(
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
                                        width:
                                            MediaQuery.of(context).size.width,
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
                        itemCount: state.product.length,
                      ),
                    );
                  }
                  return const NotFound();
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

class NotFound extends StatelessWidget {
  const NotFound({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height / 2,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.search,
              size: 150,
              color: Colors.grey[400],
            ),
            const Text(
              textAlign: TextAlign.center,
              "Cari game atau produk kesukaan kamu di sini!",
              style: TextStyle(fontSize: 16),
            )
          ],
        ),
      ),
    );
  }
}

class ShimmerLoading extends StatelessWidget {
  const ShimmerLoading({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: GridView(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
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
    );
  }
}

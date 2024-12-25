import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:topdown_store/bloc/product/product_bloc.dart';
import 'package:topdown_store/bloc/select_category/select_category_bloc.dart';
import 'package:topdown_store/bloc/select_category_product/select_product_bloc.dart';
import 'package:topdown_store/bloc/theme/theme_bloc.dart';
import 'package:topdown_store/widgets/text_field_custom.dart';

class AddProductPage extends StatelessWidget {
  const AddProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController inputProductId = TextEditingController();
    TextEditingController inputProductName = TextEditingController();
    TextEditingController inputProductImage = TextEditingController();
    return BlocProvider(
      create: (context) => SelectCategoryBloc(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Tambah Produk"),
          centerTitle: true,
        ),
        body: BlocBuilder<ThemeBloc, ThemeState>(
          builder: (context, themeState) {
            return GestureDetector(
              onPanDown: (_) => FocusManager.instance.primaryFocus?.unfocus(),
              child: ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20, bottom: 10),
                    child: Text(
                      "ID Produk",
                      style: TextStyle(
                        fontSize: 20,
                        color:
                            (themeState.isDark) ? Colors.white : Colors.black,
                      ),
                    ),
                  ),
                  TextFieldCustom(
                    color: (themeState.isDark) ? Colors.white : Colors.black,
                    controller: inputProductId,
                    text: "Masukkan Product Id",
                    typeKeyboard: TextInputType.text,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, bottom: 10),
                    child: Text(
                      "Nama Produk",
                      style: TextStyle(
                        fontSize: 20,
                        color:
                            (themeState.isDark) ? Colors.white : Colors.black,
                      ),
                    ),
                  ),
                  TextFieldCustom(
                    color: (themeState.isDark) ? Colors.white : Colors.black,
                    controller: inputProductName,
                    text: "Masukkan Nama Produk",
                    typeKeyboard: TextInputType.text,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, bottom: 10),
                    child: Text(
                      "Kategori",
                      style: TextStyle(
                        fontSize: 20,
                        color:
                            (themeState.isDark) ? Colors.white : Colors.black,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18),
                    child: Container(
                      margin: const EdgeInsets.only(top: 5),
                      width: MediaQuery.of(context).size.width,
                      height: 55,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                            color: (themeState.isDark)
                                ? Colors.white
                                : Colors.black,
                            width: 2),
                      ),
                      child:
                          BlocBuilder<SelectCategoryBloc, SelectCategoryState>(
                        builder: (context, categoryState) {
                          return DropdownButton<String>(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            value: (categoryState.categoryId.isEmpty)
                                ? null
                                : categoryState.categoryId,
                            isExpanded: true,
                            items: const [
                              DropdownMenuItem(
                                value: "KT01",
                                child: Text("Games"),
                              ),
                              DropdownMenuItem(
                                value: "KT02",
                                child: Text("Entertainment"),
                              ),
                              DropdownMenuItem(
                                value: "KT03",
                                child: Text("Tagihan"),
                              ),
                            ],
                            onChanged: (value) {
                              debugPrint("categoryId:$value");
                              context
                                  .read<SelectCategoryBloc>()
                                  .add(SelectCategory(categoryId: value!));
                            },
                          );
                        },
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, bottom: 10),
                    child: Text(
                      "Gambar Produk",
                      style: TextStyle(
                        fontSize: 20,
                        color:
                            (themeState.isDark) ? Colors.white : Colors.black,
                      ),
                    ),
                  ),
                  TextFieldCustom(
                    color: (themeState.isDark) ? Colors.white : Colors.black,
                    controller: inputProductImage,
                    text: "Masukkan URL Gambar Produk",
                    typeKeyboard: TextInputType.text,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  BlocListener<ProductBloc, ProductState>(
                    listener: (context, state) {
                      if (state is AddProductSuccess) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            duration: Duration(
                              seconds: 1,
                            ),
                            content: Text(
                              "Berhasil Tambah Produk!",
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ),
                        );
                        Navigator.of(context).pop();
                      }
                    },
                    child: BlocBuilder<ProductBloc, ProductState>(
                      builder: (context, state) {
                        if (state is ProductLoading) {
                          return UnconstrainedBox(
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.9,
                              height: 50,
                              decoration: BoxDecoration(
                                  color: Colors.grey,
                                  borderRadius: BorderRadius.circular(50)),
                              child: const Center(
                                child: CircularProgressIndicator(),
                              ),
                            ),
                          );
                        }
                        return BlocBuilder<SelectCategoryBloc,
                            SelectCategoryState>(
                          builder: (context, categoryState) {
                            return UnconstrainedBox(
                              child: InkWell(
                                onTap: () {
                                  if (inputProductId.text.isEmpty ||
                                      inputProductName.text.isEmpty ||
                                      inputProductImage.text.isEmpty ||
                                      categoryState.categoryId.isEmpty) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        duration: Duration(
                                          seconds: 1,
                                        ),
                                        content: Text(
                                          "Gagal tambah Produk!",
                                          style: TextStyle(
                                            fontSize: 16,
                                          ),
                                        ),
                                      ),
                                    );
                                  }
                                  context.read<ProductBloc>().add(AddProduct(
                                        productId: inputProductId.text,
                                        name: inputProductName.text,
                                        categoryId: categoryState.categoryId,
                                        image: inputProductImage.text,
                                      ));
                                  context.read<SelectCategoryProductBloc>().add(
                                        SelectCategoryProduct(
                                          index: (categoryState.categoryId ==
                                                  "KT01")
                                              ? 0
                                              : (categoryState.categoryId ==
                                                      "KT02")
                                                  ? 1
                                                  : 2,
                                        ),
                                      );
                                },
                                child: Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.9,
                                  height: 50,
                                  decoration: BoxDecoration(
                                      color: Colors.green,
                                      borderRadius: BorderRadius.circular(50)),
                                  child: const Center(
                                    child: Text(
                                      "Tambah Produk",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 17),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

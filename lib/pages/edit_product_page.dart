import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:topdown_store/bloc/product/product_bloc.dart';
import 'package:topdown_store/bloc/select_category/select_category_bloc.dart';
import 'package:topdown_store/bloc/select_category_product/select_product_bloc.dart';
import 'package:topdown_store/bloc/theme/theme_bloc.dart';
import 'package:topdown_store/widgets/text_field_custom.dart';

class EditProductPage extends StatelessWidget {
  final String productId, productName, productImage, categoryId;
  const EditProductPage({
    super.key,
    required this.productId,
    required this.productName,
    required this.productImage,
    required this.categoryId,
  });

  @override
  Widget build(BuildContext context) {
    TextEditingController inputProductName =
        TextEditingController(text: productName);
    TextEditingController inputProductImage =
        TextEditingController(text: productImage);
    return BlocProvider(
      create: (context) =>
          SelectCategoryBloc()..add(SelectCategory(categoryId: categoryId)),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Edit Produk"),
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
                                ? categoryId
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
                    height: 40,
                  ),
                  BlocBuilder<SelectCategoryBloc, SelectCategoryState>(
                    builder: (context, categoryState) {
                      return UnconstrainedBox(
                        child: InkWell(
                          borderRadius: BorderRadius.circular(50),
                          onTap: () {
                            context.read<ProductBloc>().add(EditProduct(
                                  productId: productId,
                                  name: inputProductName.text,
                                  categoryId: (categoryState.categoryId.isEmpty)
                                      ? categoryId
                                      : categoryState.categoryId,
                                  image: inputProductImage.text,
                                ));
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                duration: Duration(
                                  seconds: 1,
                                ),
                                content: Text(
                                  "Berhasil ubah produk!",
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            );
                            context.read<SelectCategoryProductBloc>().add(
                                  SelectCategoryProduct(
                                    index: (categoryState.categoryId == "KT01")
                                        ? 0
                                        : (categoryState.categoryId == "KT02")
                                            ? 1
                                            : 2,
                                  ),
                                );
                            Navigator.of(context).pop();
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.9,
                            height: 50,
                            decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.circular(50)),
                            child: const Center(
                              child: Text(
                                "Ubah produk",
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
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  BlocBuilder<SelectCategoryBloc, SelectCategoryState>(
                    builder: (context, categoryState) {
                      return UnconstrainedBox(
                        child: InkWell(
                          borderRadius: BorderRadius.circular(50),
                          onTap: () {
                            showDialog(
                              barrierDismissible: false,
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  contentPadding: const EdgeInsets.only(
                                    top: 20,
                                    bottom: 20,
                                  ),
                                  actionsAlignment:
                                      MainAxisAlignment.spaceAround,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  content: const Text(
                                    textAlign: TextAlign.center,
                                    "Apakah kamu yakin ingin menghapus produk ini?",
                                    style: TextStyle(
                                      fontSize: 17,
                                    ),
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () =>
                                          Navigator.of(context).pop(),
                                      child: const Text(
                                        "Tidak",
                                        style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        context.read<ProductBloc>().add(
                                            DeleteProduct(
                                                productId: productId,
                                                categoryId: (categoryState
                                                        .categoryId.isEmpty)
                                                    ? categoryId
                                                    : categoryState
                                                        .categoryId));

                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                            duration: Duration(
                                              seconds: 1,
                                            ),
                                            content: Text(
                                              "Berhasil hapus produk!",
                                              style: TextStyle(
                                                fontSize: 16,
                                              ),
                                            ),
                                          ),
                                        );
                                        context
                                            .read<SelectCategoryProductBloc>()
                                            .add(
                                              SelectCategoryProduct(
                                                index: (categoryState
                                                            .categoryId ==
                                                        "KT01")
                                                    ? 0
                                                    : (categoryState
                                                                .categoryId ==
                                                            "KT02")
                                                        ? 1
                                                        : 2,
                                              ),
                                            );
                                        Navigator.of(context).pop();
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text(
                                        "Ya",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.blue,
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.9,
                            height: 50,
                            decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(50)),
                            child: const Center(
                              child: Text(
                                "Hapus produk",
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

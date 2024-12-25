import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:topdown_store/bloc/item/item_bloc.dart';
import 'package:topdown_store/bloc/theme/theme_bloc.dart';
import 'package:topdown_store/widgets/text_field_custom.dart';

class AddItemPage extends StatelessWidget {
  final String productId;
  const AddItemPage({
    super.key,
    required this.productId,
  });

  @override
  Widget build(BuildContext context) {
    TextEditingController inputItemName = TextEditingController();
    TextEditingController inputItemPrice = TextEditingController();
    TextEditingController inputItemImage = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tambah Item"),
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
                    "Nama Item",
                    style: TextStyle(
                      fontSize: 20,
                      color: (themeState.isDark) ? Colors.white : Colors.black,
                    ),
                  ),
                ),
                TextFieldCustom(
                  color: (themeState.isDark) ? Colors.white : Colors.black,
                  controller: inputItemName,
                  text: "Masukkan Nama Item",
                  typeKeyboard: TextInputType.text,
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, bottom: 10),
                  child: Text(
                    "Harga Item",
                    style: TextStyle(
                      fontSize: 20,
                      color: (themeState.isDark) ? Colors.white : Colors.black,
                    ),
                  ),
                ),
                TextFieldCustom(
                  color: (themeState.isDark) ? Colors.white : Colors.black,
                  controller: inputItemPrice,
                  text: "Masukkan Harga Item",
                  typeKeyboard: TextInputType.number,
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, bottom: 10),
                  child: Text(
                    "Gambar Item",
                    style: TextStyle(
                      fontSize: 20,
                      color: (themeState.isDark) ? Colors.white : Colors.black,
                    ),
                  ),
                ),
                TextFieldCustom(
                  color: (themeState.isDark) ? Colors.white : Colors.black,
                  controller: inputItemImage,
                  text: "Masukkan URL Gambar Item",
                  typeKeyboard: TextInputType.text,
                ),
                const SizedBox(
                  height: 30,
                ),
                BlocListener<ItemBloc, ItemState>(
                  listener: (context, state) {
                    if (state is AddItemSuccess) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          duration: Duration(
                            seconds: 1,
                          ),
                          content: Text(
                            "Berhasil Tambah Item!",
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ),
                      );
                      Navigator.of(context).pop();
                    }
                  },
                  child: BlocBuilder<ItemBloc, ItemState>(
                    builder: (context, state) {
                      if (state is ItemLoading) {
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
                      return UnconstrainedBox(
                        child: InkWell(
                          onTap: () {
                            if (inputItemName.text.isEmpty ||
                                inputItemPrice.text.isEmpty ||
                                inputItemImage.text.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  duration: Duration(
                                    seconds: 1,
                                  ),
                                  content: Text(
                                    "Gagal Tambah Item!",
                                    style: TextStyle(
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              );
                            }
                            context.read<ItemBloc>().add(AddItem(
                                  name: inputItemName.text,
                                  productId: productId,
                                  price: int.parse(inputItemPrice.text),
                                  image: inputItemImage.text,
                                ));
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.9,
                            height: 50,
                            decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.circular(50)),
                            child: const Center(
                              child: Text(
                                "Tambah Item",
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
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

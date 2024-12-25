import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:topdown_store/bloc/item/item_bloc.dart';
import 'package:topdown_store/bloc/theme/theme_bloc.dart';
import 'package:topdown_store/widgets/text_field_custom.dart';

class EditItemPage extends StatelessWidget {
  final String itemId, productId, itemName, itemPrice, itemImage;
  const EditItemPage({
    super.key,
    required this.itemId,
    required this.productId,
    required this.itemName,
    required this.itemPrice,
    required this.itemImage,
  });

  @override
  Widget build(BuildContext context) {
    TextEditingController inputItemName = TextEditingController(text: itemName);
    TextEditingController inputItemPrice =
        TextEditingController(text: itemPrice);
    TextEditingController inputItemImage =
        TextEditingController(text: itemImage);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Ubah Item"),
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
                    if (state is EditItemSuccess) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          duration: Duration(
                            seconds: 1,
                          ),
                          content: Text(
                            "Berhasil ubah item!",
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
                                    "Gagal ubah item!",
                                    style: TextStyle(
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              );
                            }
                            context.read<ItemBloc>().add(EditItem(
                                  itemId: itemId,
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
                                "Ubah item",
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
                const SizedBox(
                  height: 20,
                ),
                UnconstrainedBox(
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
                            actionsAlignment: MainAxisAlignment.spaceAround,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            content: const Text(
                              textAlign: TextAlign.center,
                              "Apakah kamu yakin ingin menghapus item ini?",
                              style: TextStyle(
                                fontSize: 17,
                              ),
                            ),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.of(context).pop(),
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
                                  context.read<ItemBloc>().add(DeleteItem(
                                      itemId: itemId, productId: productId));
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      duration: Duration(
                                        seconds: 1,
                                      ),
                                      content: Text(
                                        "Berhasil hapus item!",
                                        style: TextStyle(
                                          fontSize: 16,
                                        ),
                                      ),
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
                          "Hapus item",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 17),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}

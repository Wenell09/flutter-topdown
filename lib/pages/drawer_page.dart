import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:topdown_store/bloc/product/product_bloc.dart';
import 'package:topdown_store/bloc/save_userId/save_user_id_bloc.dart';
import 'package:topdown_store/bloc/select_category_product/select_product_bloc.dart';
import 'package:topdown_store/bloc/transaction/transaction_bloc.dart';
import 'package:topdown_store/bloc/user/user_bloc.dart';
import 'package:topdown_store/data/model/user_model.dart';
import 'package:topdown_store/pages/admin_home_page.dart';
import 'package:topdown_store/pages/admin_item_page.dart';
import 'package:topdown_store/pages/admin_product_page.dart';
import 'package:topdown_store/pages/admin_transaction_page.dart';
import 'package:topdown_store/pages/navigation_page.dart';

class DrawerPage extends StatelessWidget {
  final UserModel data;
  const DrawerPage({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
              decoration: const BoxDecoration(color: Colors.blue),
              currentAccountPicture: CircleAvatar(
                backgroundImage: NetworkImage(data.image),
              ),
              accountName: Text(data.username),
              accountEmail: Text(data.email)),
          ListTile(
            onTap: () {
              Navigator.pop(context);
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => const AdminHomePage(),
              ));
            },
            leading: const Icon(
              Icons.home,
              color: Colors.blue,
            ),
            title: const Text("Beranda"),
          ),
          ListTile(
            onTap: () {
              Navigator.pop(context);
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => const AdminProductPage(),
              ));
              context
                  .read<SelectCategoryProductBloc>()
                  .add(SelectCategoryProduct(index: 0));
              context
                  .read<ProductBloc>()
                  .add(GetProductByCategoryId(categoryId: "KT01"));
            },
            leading: const Icon(
              Icons.shopping_bag,
              color: Colors.blue,
            ),
            title: const Text("Produk"),
          ),
          ListTile(
            onTap: () {
              Navigator.pop(context);
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => const AdminItemPage(),
              ));
              context
                  .read<SelectCategoryProductBloc>()
                  .add(SelectCategoryProduct(index: 0));
              context
                  .read<ProductBloc>()
                  .add(GetProductByCategoryId(categoryId: "KT01"));
            },
            leading: const Icon(
              Icons.list,
              color: Colors.blue,
            ),
            title: const Text("Item"),
          ),
          ListTile(
            onTap: () {
              Navigator.pop(context);
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) =>
                    AdminTransactionPage(adminId: data.userId),
              ));
              context.read<TransactionBloc>().add(GetTransaction(userId: ""));
            },
            leading: const Icon(
              Icons.credit_card,
              color: Colors.blue,
            ),
            title: const Text("Transaksi"),
          ),
          ListTile(
            onTap: () {
              Navigator.pop(context);
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
                      "Apakah kamu ingin keluar?",
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
                          context
                              .read<SaveUserIdBloc>()
                              .add(SaveUserId(userId: ""));
                          context.read<UserBloc>().add(GetUser(userId: ""));
                          Navigator.of(context).pop();
                          Navigator.of(context)
                              .pushReplacement(MaterialPageRoute(
                            builder: (context) => const NavigationPage(),
                          ));
                        },
                        child: const Text(
                          "Keluar",
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
            leading: const Icon(
              Icons.logout,
              color: Colors.blue,
            ),
            title: const Text("Keluar"),
          ),
        ],
      ),
    );
  }
}

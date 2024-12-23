import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:topdown_store/bloc/theme/theme_bloc.dart';
import 'package:topdown_store/bloc/transaction/transaction_bloc.dart';
import 'package:topdown_store/pages/transaction_success_page.dart';
import 'package:topdown_store/repository/transaction_repo.dart';

class DetailPembayaranPage extends StatelessWidget {
  final Map<String, dynamic> data;
  const DetailPembayaranPage({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TransactionBloc(TransactionRepo()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Detail Pembayaran"),
          centerTitle: true,
        ),
        body: BlocBuilder<ThemeBloc, ThemeState>(
          builder: (context, themeState) {
            return Column(
              children: [
                Expanded(
                    child: Container(
                  margin: const EdgeInsets.all(0),
                  width: MediaQuery.of(context).size.width,
                  child: ListView(
                    children: [
                      UnconstrainedBox(
                        child: Container(
                          margin: const EdgeInsets.only(top: 20),
                          padding: const EdgeInsets.all(10),
                          width: MediaQuery.of(context).size.width * 0.85,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: (themeState.isDark)
                                  ? Colors.white
                                  : Colors.black,
                              width: 2,
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Detail Transaksi:",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              RowDetail(
                                  title: "Kategori: ", data: data["category"]),
                              const SizedBox(
                                height: 5,
                              ),
                              RowDetail(
                                  title: "Produk: ", data: data["product"]),
                              const SizedBox(
                                height: 5,
                              ),
                              RowDetail(title: "UID: ", data: data["uid"]),
                              const SizedBox(
                                height: 5,
                              ),
                              RowDetail(
                                  title: "item: ", data: data["itemName"]),
                              const SizedBox(
                                height: 5,
                              ),
                              RowDetail(
                                  title: "Harga: ",
                                  data: "Rp.${data["itemPrice"]}"),
                              const SizedBox(
                                height: 5,
                              ),
                              RowDetail(
                                title: "pembayaran: ",
                                data: data["pembayaran"],
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      const Icon(
                        Icons.warning_rounded,
                        color: Colors.red,
                        size: 150,
                      ),
                      const Center(
                        child: Text(
                          textAlign: TextAlign.center,
                          "Periksa kembali item yang anda beli sebelum membayar!",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    ],
                  ),
                )),
                Column(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.all(20),
                      height: MediaQuery.of(context).size.height * 0.11,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          BlocListener<TransactionBloc, TransactionState>(
                            listener: (context, state) {
                              if (state is AddTransactionSuccess) {
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) =>
                                      const TransactionSuccessPage(),
                                ));
                              }
                            },
                            child:
                                BlocBuilder<TransactionBloc, TransactionState>(
                              builder: (context, state) {
                                if (state is TransactionLoading) {
                                  return UnconstrainedBox(
                                    child: Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.8,
                                      height: 50,
                                      decoration: BoxDecoration(
                                          color: Colors.grey,
                                          borderRadius:
                                              BorderRadius.circular(50)),
                                      child: const Center(
                                          child: CircularProgressIndicator()),
                                    ),
                                  );
                                }
                                return InkWell(
                                  onTap: () {
                                    if (data["product"] == "Topay") {
                                      context.read<TransactionBloc>().add(
                                            TopUpTopay(
                                              userId: data["userId"],
                                              itemId: data["itemId"],
                                              paymentCategoryId:
                                                  data["paymentCategoryId"],
                                              transactionTarget: data["uid"],
                                            ),
                                          );
                                    } else {
                                      context.read<TransactionBloc>().add(
                                            AddTransaction(
                                              userId: data["userId"],
                                              itemId: data["itemId"],
                                              paymentCategoryId:
                                                  data["paymentCategoryId"],
                                              transactionTarget: data["uid"],
                                            ),
                                          );
                                    }
                                  },
                                  child: Container(
                                    width:
                                        MediaQuery.of(context).size.width * 0.8,
                                    height: 50,
                                    decoration: BoxDecoration(
                                      color: (themeState.isDark)
                                          ? Colors.white
                                          : Colors.black,
                                      borderRadius: BorderRadius.circular(50),
                                    ),
                                    child: Center(
                                      child: Text(
                                        "Bayar Sekarang",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: (themeState.isDark)
                                              ? Colors.black
                                              : Colors.white,
                                          fontSize: 17,
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class RowDetail extends StatelessWidget {
  final String title, data;
  const RowDetail({
    super.key,
    required this.title,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          data,
          style: const TextStyle(
            fontSize: 17,
          ),
        ),
      ],
    );
  }
}

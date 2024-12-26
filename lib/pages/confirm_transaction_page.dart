import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:topdown_store/bloc/transaction/transaction_bloc.dart';
import 'package:topdown_store/data/model/transaction_model.dart';

class ConfirmTransactionPage extends StatelessWidget {
  final String adminId;
  final TransactionModel transaction;
  const ConfirmTransactionPage({
    super.key,
    required this.transaction,
    required this.adminId,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Detail Transaksi"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            flex: 1,
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: ListView(
                  children: [
                    Card(
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            RowDetail(
                              judul: "Transaction Id: ",
                              isi: transaction.transactionId,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            RowDetail(
                              judul: "Username: ",
                              isi: transaction.username,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            RowDetail(
                              judul: "Email: ",
                              isi: transaction.email,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            RowDetail(
                              judul: (transaction.productName == "Topay")
                                  ? "Email Topup: "
                                  : "UID Akun: ",
                              isi: transaction.transactionTarget,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            RowDetail(
                              judul: "Nama Produk: ",
                              isi: transaction.productName,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            RowDetail(
                              judul: "Kategori: ",
                              isi: transaction.productCategory,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            RowDetail(
                              judul: "Nama Item: ",
                              isi: transaction.itemName,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            RowDetail(
                              judul: "Harga Item: ",
                              isi: "Rp.${transaction.itemPrice}",
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            RowDetail(
                              judul: "Uang Bayar: ",
                              isi: "Rp.${transaction.payMoney}",
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            RowDetail(
                              judul: "Uang Kembalian: ",
                              isi: "Rp.${transaction.moneyChange}",
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            RowDetail(
                              judul: "Pembayaran: ",
                              isi: transaction.payment,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            RowDetail(
                              judul: "Status: ",
                              isi: transaction.status,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            RowDetail(
                              judul: "Tanggal Pembelian: ",
                              isi: formatTanggal(transaction.createdAt),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 110,
            child: UnconstrainedBox(
              child: BlocListener<TransactionBloc, TransactionState>(
                listener: (context, state) {
                  if (state is ConfirmTransactionSuccess ||
                      state is ConfirmTopUpTopaySuccess) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        duration: Duration(
                          seconds: 1,
                        ),
                        content: Text(
                          "Konfirmasi transaksi berhasil!",
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ),
                    );
                    Navigator.of(context).pop();
                  }
                },
                child: BlocBuilder<TransactionBloc, TransactionState>(
                  builder: (context, state) {
                    if (state is TransactionLoading) {
                      return Container(
                        width: MediaQuery.of(context).size.width * 0.9,
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: Colors.grey,
                        ),
                        child: const Center(child: CircularProgressIndicator()),
                      );
                    }
                    if (transaction.status == "selesai") {
                      return Container(
                        width: MediaQuery.of(context).size.width * 0.9,
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: Colors.grey,
                        ),
                        child: const Center(
                          child: Text(
                            "Transaksi selesai",
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      );
                    }
                    return InkWell(
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
                                "Konfirmasi transaksi ini?",
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
                                    if (transaction.productName == "Topay") {
                                      context
                                          .read<TransactionBloc>()
                                          .add(ConfirmTopUpTopay(
                                            userId: transaction.userId,
                                            transactionId:
                                                transaction.transactionId,
                                            adminId: adminId,
                                            itemId: transaction.itemId,
                                          ));
                                    } else {
                                      context
                                          .read<TransactionBloc>()
                                          .add(ConfirmTransaction(
                                            userId: transaction.userId,
                                            transactionId:
                                                transaction.transactionId,
                                          ));
                                    }
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text(
                                    "Ya",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.green,
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
                          borderRadius: BorderRadius.circular(50),
                          color: Colors.green,
                        ),
                        child: const Center(
                          child: Text(
                            "Konfirmasi Transaksi",
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class RowDetail extends StatelessWidget {
  final String judul, isi;
  const RowDetail({
    super.key,
    required this.judul,
    required this.isi,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          judul,
          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        ),
        Flexible(
          child: Text(
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            isi,
            style: const TextStyle(fontSize: 15),
          ),
        ),
      ],
    );
  }
}

String formatTanggal(String isoDate) {
  DateTime parsedDate = DateTime.parse(isoDate);
  String formattedDate =
      DateFormat("dd MMMM yyyy HH:mm", "id_ID").format(parsedDate);
  return formattedDate;
}

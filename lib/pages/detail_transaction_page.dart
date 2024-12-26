import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:topdown_store/data/model/transaction_model.dart';

class DetailTransactionPage extends StatelessWidget {
  final TransactionModel transaction;
  const DetailTransactionPage({super.key, required this.transaction});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Detail Transaksi"),
        centerTitle: true,
      ),
      body: Padding(
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

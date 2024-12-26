import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';
import 'package:topdown_store/bloc/transaction/transaction_bloc.dart';
import 'package:topdown_store/bloc/user/user_bloc.dart';
import 'package:topdown_store/pages/confirm_transaction_page.dart';
import 'package:topdown_store/pages/drawer_page.dart';

class AdminTransactionPage extends StatelessWidget {
  final String adminId;
  const AdminTransactionPage({
    super.key,
    required this.adminId,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Transaksi"),
        centerTitle: true,
      ),
      drawer: BlocBuilder<UserBloc, UserState>(
        builder: (context, state) {
          if (state is UserLoaded) {
            return DrawerPage(data: state.user[0]);
          }
          return Container();
        },
      ),
      body: BlocBuilder<TransactionBloc, TransactionState>(
        builder: (context, state) {
          if (state is TransactionLoading) {
            return const ShimmerLoading();
          } else if (state is TransactionLoaded) {
            if (state.transaction.isEmpty) {
              return const Center(
                child: Text(
                  "Daftar transaksi kosong!",
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              );
            }
            final transactions = state.transaction;
            return RefreshIndicator(
              backgroundColor: Colors.black,
              color: Colors.blue,
              displacement: 50,
              onRefresh: () async {
                context
                    .read<TransactionBloc>()
                    .add(GetTransaction(userId: transactions[0].userId));
              },
              child: ListView.builder(
                itemCount: transactions.length,
                itemBuilder: (context, index) {
                  final transaction = transactions[index];
                  return InkWell(
                    onTap: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => ConfirmTransactionPage(
                        adminId: adminId,
                        transaction: transaction,
                      ),
                    )),
                    child: Card(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      elevation: 3,
                      child: ListTile(
                        leading: Image.network(
                          transaction.productImage,
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
                        ),
                        title: Text(
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          transaction.itemName,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Rp.${transaction.itemPrice}"),
                            Text(
                                "Tanggal Pembelian: \n${formatTanggal(transaction.createdAt)}"),
                          ],
                        ),
                        trailing: Text(
                          transaction.status,
                          style: TextStyle(
                            color: (transaction.status == "sedang diproses")
                                ? Colors.orange
                                : Colors.green,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            );
          }
          return const ShimmerLoading();
        },
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
      child: ListView(
        shrinkWrap: true,
        children: List.generate(
          6,
          (index) => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Container(
              margin: const EdgeInsets.only(bottom: 5),
              height: 120,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

String formatTanggal(String isoDate) {
  DateTime parsedDate = DateTime.parse(isoDate);
  String formattedDate =
      DateFormat("dd MMMM yyyy HH:mm", "id_ID").format(parsedDate);
  return formattedDate;
}

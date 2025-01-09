import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';
import 'package:topdown_store/bloc/item/item_bloc.dart';
import 'package:topdown_store/bloc/payment_category/payment_category_bloc.dart';
import 'package:topdown_store/bloc/select_item/select_item_bloc.dart';
import 'package:topdown_store/bloc/select_payment/select_payment_bloc.dart';
import 'package:topdown_store/bloc/theme/theme_bloc.dart';
import 'package:topdown_store/bloc/user/user_bloc.dart';
import 'package:topdown_store/pages/detail_payment_page.dart';
import 'package:topdown_store/repository/item_repo.dart';
import 'package:topdown_store/repository/payment_category_repo.dart';

class DetailPage extends StatelessWidget {
  final String productId;
  const DetailPage({super.key, required this.productId});

  @override
  Widget build(BuildContext context) {
    TextEditingController inputUid = TextEditingController();
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              ItemBloc(ItemRepo())..add(GetItem(productId: productId)),
        ),
        BlocProvider(
          create: (context) => PaymentCategoryBloc(PaymentCategoryRepo())
            ..add(GetPaymentCategory()),
        ),
        BlocProvider(
          create: (context) => SelectPaymentBloc(),
        ),
        BlocProvider(
          create: (context) => SelectItemBloc(),
        )
      ],
      child: BlocBuilder<ItemBloc, ItemState>(
        builder: (context, state) {
          if (state is ItemLoading) {
            return const DetailLoading();
          } else if (state is ItemLoaded) {
            if (state.item.isEmpty) {
              return const DetailLoading();
            }
            return BlocBuilder<ThemeBloc, ThemeState>(
              builder: (context, themeState) {
                return Scaffold(
                  body: GestureDetector(
                    onPanDown: (_) => FocusScope.of(context).unfocus(),
                    child: CustomScrollView(
                      slivers: [
                        SliverAppBar(
                          pinned: true,
                          floating: false,
                          expandedHeight: 210,
                          flexibleSpace: FlexibleSpaceBar(
                            centerTitle: false,
                            title: Text(
                              state.item[0].productName,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            background: ColorFiltered(
                              colorFilter: ColorFilter.mode(
                                  Colors.black.withOpacity(0.7),
                                  BlendMode.dstATop),
                              child: Image.network(
                                state.item[0].productImage,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        SliverTextField(
                          color:
                              (themeState.isDark) ? Colors.white : Colors.black,
                          controller: inputUid,
                          text: "1.Masukkan UID",
                          hint: (state.item[0].productName == "Topay")
                              ? "Masukkan Email akun"
                              : "Masukan ID akun ${state.item[0].productName}",
                        ),
                        const SliverToBoxAdapter(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            child: Text(
                              "2.Pilih Nominal Top Up",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        SliverPadding(
                          padding: const EdgeInsets.all(10),
                          sliver: SliverGrid(
                            delegate: SliverChildBuilderDelegate(
                              (BuildContext context, int index) {
                                var data = state.item[index];
                                return GestureDetector(
                                  onTap: () => context.read<SelectItemBloc>()
                                    ..add(AddSelectItem(
                                      itemId: data.itemId,
                                      itemName: data.name,
                                      itemPrice: data.price,
                                    )),
                                  child: BlocBuilder<SelectItemBloc,
                                      SelectItemState>(
                                    builder: (context, selectItemState) {
                                      return Card(
                                        elevation: 5,
                                        shadowColor: Colors.black,
                                        child: Container(
                                          decoration: (selectItemState.itemId ==
                                                  data.itemId)
                                              ? BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  border: Border.all(
                                                      color: Colors.blue,
                                                      width: 3))
                                              : null,
                                          child: Column(
                                            children: [
                                              Expanded(
                                                flex: 3,
                                                child: ClipRRect(
                                                  borderRadius:
                                                      const BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(10),
                                                    topRight:
                                                        Radius.circular(10),
                                                  ),
                                                  child: Image.network(
                                                    data.image,
                                                    fit: BoxFit.cover,
                                                    width:
                                                        MediaQuery.of(context)
                                                            .size
                                                            .width,
                                                  ),
                                                ),
                                              ),
                                              Flexible(
                                                flex: 1,
                                                child: Center(
                                                  child: Text(
                                                    data.name,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    maxLines: 1,
                                                    style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                              ),
                                              Flexible(
                                                flex: 1,
                                                child: Center(
                                                  child: Text(
                                                    "Rp.${data.price}",
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    maxLines: 1,
                                                    style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.blue,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                );
                              },
                              childCount: state.item.length,
                            ),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              mainAxisSpacing: 15,
                              crossAxisSpacing: 1,
                              childAspectRatio: 4 / 5,
                            ),
                          ),
                        ),
                        BlocBuilder<PaymentCategoryBloc, PaymentCategoryState>(
                          builder: (context, paymentCategoryState) {
                            if (paymentCategoryState
                                is PaymentCategoryLoading) {
                              return SliverToBoxAdapter(
                                child: Container(),
                              );
                            } else if (paymentCategoryState
                                is PaymentCategoryLoaded) {
                              if (paymentCategoryState
                                  .paymentCategory.isEmpty) {
                                return SliverToBoxAdapter(
                                  child: Container(),
                                );
                              }
                              return SliverToBoxAdapter(
                                child: UnconstrainedBox(
                                  child: Container(
                                    padding: const EdgeInsets.all(10),
                                    margin: const EdgeInsets.only(
                                        top: 25, bottom: 10),
                                    width: MediaQuery.of(context).size.width *
                                        0.93,
                                    height: 110,
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          "3.Pilih Pembayaran",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 17),
                                        ),
                                        Container(
                                          margin: const EdgeInsets.only(top: 5),
                                          width:
                                              MediaQuery.of(context).size.width,
                                          height: 50,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              border: Border.all(
                                                  color: (themeState.isDark)
                                                      ? Colors.white
                                                      : Colors.black,
                                                  width: 2)),
                                          child: BlocBuilder<SelectPaymentBloc,
                                              SelectPaymentState>(
                                            builder:
                                                (context, selectPaymentState) {
                                              return DropdownButton<String>(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 15),
                                                value: selectPaymentState
                                                        .paymentCategoryId
                                                        .isEmpty
                                                    ? null
                                                    : selectPaymentState
                                                        .paymentCategoryId,
                                                isExpanded: true,
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                items: (state.item[0]
                                                            .productName ==
                                                        "Topay")
                                                    ? paymentCategoryState
                                                        .paymentCategory
                                                        .map((value) {
                                                        return DropdownMenuItem<
                                                            String>(
                                                          value: (value
                                                                      .paymentCategoryId ==
                                                                  "PC01")
                                                              ? null
                                                              : value
                                                                  .paymentCategoryId,
                                                          child:
                                                              (value.paymentCategoryId ==
                                                                      "PC01")
                                                                  ? const Text(
                                                                      "")
                                                                  : Text(value
                                                                      .name),
                                                        );
                                                      }).toList()
                                                    : paymentCategoryState
                                                        .paymentCategory
                                                        .map((value) {
                                                        return DropdownMenuItem<
                                                            String>(
                                                          value: value
                                                              .paymentCategoryId,
                                                          child:
                                                              Text(value.name),
                                                        );
                                                      }).toList(),
                                                onChanged: (value) {
                                                  if (state.item[0]
                                                              .productName ==
                                                          "Topay" &&
                                                      value == "PC01") {
                                                    return;
                                                  }
                                                  final paymentName =
                                                      paymentCategoryState
                                                          .paymentCategory
                                                          .firstWhere((category) =>
                                                              category
                                                                  .paymentCategoryId ==
                                                              value);
                                                  context
                                                      .read<SelectPaymentBloc>()
                                                      .add(ChangeSelectPayment(
                                                          paymentCategoryId:
                                                              value!,
                                                          paymentName:
                                                              paymentName
                                                                  .name));
                                                },
                                              );
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            }
                            return SliverToBoxAdapter(
                              child: Container(),
                            );
                          },
                        ),
                        BlocBuilder<UserBloc, UserState>(
                          builder: (context, userState) {
                            if (userState is UserLoaded) {
                              return BlocBuilder<SelectItemBloc,
                                  SelectItemState>(
                                builder: (context, selectItemState) {
                                  return BlocBuilder<SelectPaymentBloc,
                                      SelectPaymentState>(
                                    builder: (context, selectPaymentState) {
                                      return SliverToBoxAdapter(
                                        child: UnconstrainedBox(
                                          child: InkWell(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            onTap: () {
                                              if (userState.user.isEmpty) {
                                                showDialog(
                                                  context: context,
                                                  builder: (context) =>
                                                      AlertDialog(
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                    ),
                                                    content: const Text(
                                                      "Login terlebih dahulu!",
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ),
                                                );
                                              } else {
                                                if (inputUid.text.isEmpty ||
                                                    selectItemState
                                                        .itemId.isEmpty ||
                                                    selectPaymentState
                                                        .paymentCategoryId
                                                        .isEmpty) {
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(
                                                    const SnackBar(
                                                      duration: Duration(
                                                        seconds: 1,
                                                      ),
                                                      content: Text(
                                                        "Pastikan semua sudah terisi!",
                                                        style: TextStyle(
                                                          fontSize: 16,
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                } else {
                                                  Navigator.of(context)
                                                      .push(MaterialPageRoute(
                                                    builder: (context) =>
                                                        DetailPaymentPage(
                                                            data: {
                                                          "userId": userState
                                                              .user[0].userId,
                                                          "category": state
                                                              .item[0].category,
                                                          "product": state
                                                              .item[0]
                                                              .productName,
                                                          "uid": inputUid.text,
                                                          "itemId":
                                                              selectItemState
                                                                  .itemId,
                                                          "itemName":
                                                              selectItemState
                                                                  .itemName,
                                                          "itemPrice":
                                                              selectItemState
                                                                  .itemPrice,
                                                          "paymentCategoryId":
                                                              selectPaymentState
                                                                  .paymentCategoryId,
                                                          "pembayaran":
                                                              selectPaymentState
                                                                  .paymentName,
                                                        }),
                                                  ));
                                                }
                                              }
                                            },
                                            child: Container(
                                              margin: const EdgeInsets.only(
                                                  bottom: 20, top: 10),
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.93,
                                              height: 60,
                                              decoration: BoxDecoration(
                                                color: (themeState.isDark)
                                                    ? Colors.white
                                                    : Colors.black,
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                              ),
                                              child: Center(
                                                child: Text(
                                                  "Lanjutkan Pembayaran",
                                                  style: TextStyle(
                                                      fontSize: 17,
                                                      color: (themeState.isDark)
                                                          ? Colors.black
                                                          : Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                },
                              );
                            }
                            return SliverToBoxAdapter(
                              child: UnconstrainedBox(
                                child: InkWell(
                                  borderRadius: BorderRadius.circular(50),
                                  onTap: () {
                                    showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        content: const Text(
                                          "Login terlebih dahulu!",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.only(
                                        bottom: 20, top: 10),
                                    width: MediaQuery.of(context).size.width *
                                        0.93,
                                    height: 60,
                                    decoration: BoxDecoration(
                                      color: (themeState.isDark)
                                          ? Colors.white
                                          : Colors.black,
                                      borderRadius: BorderRadius.circular(50),
                                    ),
                                    child: Center(
                                      child: Text(
                                        "Lanjutkan Pembayaran",
                                        style: TextStyle(
                                            fontSize: 17,
                                            color: (themeState.isDark)
                                                ? Colors.black
                                                : Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
          return const DetailLoading();
        },
      ),
    );
  }
}

class DetailLoading extends StatelessWidget {
  const DetailLoading({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.all(0),
        children: [
          Shimmer.fromColors(
            baseColor: Colors.grey.shade300,
            highlightColor: Colors.grey.shade100,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 245,
              color: Colors.white,
            ),
          ),
          Shimmer.fromColors(
            baseColor: Colors.grey.shade300,
            highlightColor: Colors.grey.shade100,
            child: UnconstrainedBox(
              child: Container(
                padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.only(top: 25, bottom: 10),
                width: MediaQuery.of(context).size.width * 0.93,
                height: 110,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Shimmer.fromColors(
            baseColor: Colors.grey.shade300,
            highlightColor: Colors.grey.shade100,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: Align(
                alignment: Alignment.topLeft,
                child: UnconstrainedBox(
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.6,
                    height: 30,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Shimmer.fromColors(
            baseColor: Colors.grey.shade300,
            highlightColor: Colors.grey.shade100,
            child: GridView(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 15,
                crossAxisSpacing: 1,
                childAspectRatio: 4 / 5,
              ),
              children: List.generate(
                6,
                (index) => const Card(),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Shimmer.fromColors(
            baseColor: Colors.grey.shade300,
            highlightColor: Colors.grey.shade100,
            child: UnconstrainedBox(
              child: Container(
                margin: const EdgeInsets.only(bottom: 20, top: 10),
                width: MediaQuery.of(context).size.width * 0.93,
                height: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: Colors.white,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class SliverTextField extends StatelessWidget {
  final Color color;
  final TextEditingController controller;
  final String hint;
  final String text;
  const SliverTextField({
    super.key,
    required this.controller,
    required this.text,
    required this.hint,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: UnconstrainedBox(
        child: Container(
          padding: const EdgeInsets.all(10),
          margin: const EdgeInsets.only(top: 25, bottom: 10),
          width: MediaQuery.of(context).size.width * 0.93,
          height: 110,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: color,
              width: 2,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                text,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                controller: controller,
                decoration: InputDecoration(
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  hintText: hint,
                  hintStyle: const TextStyle(color: Colors.grey, fontSize: 14),
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(10),
                    ),
                    borderSide: BorderSide(
                      color: color,
                      width: 2.0,
                    ),
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                    borderSide: BorderSide(
                      color: Colors.blue,
                      width: 2.0,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

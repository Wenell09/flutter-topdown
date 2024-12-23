import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';
import 'package:topdown_store/bloc/save_userId/save_user_id_bloc.dart';
import 'package:topdown_store/bloc/theme/theme_bloc.dart';
import 'package:topdown_store/bloc/user/user_bloc.dart';
import 'package:topdown_store/pages/account_setting.dart';
import 'package:topdown_store/pages/history_transaction.dart';
import 'package:topdown_store/pages/login_page.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, userState) {
        if (userState is UserLoading) {
          return const ShimmerLoading();
        } else if (userState is UserLoaded) {
          if (userState.user.isEmpty) {
            return const DefaultProfile();
          }
          return Scaffold(
            body: ListView(
              padding: const EdgeInsets.all(0),
              children: [
                Stack(
                  children: [
                    Column(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height * 0.23,
                          decoration: const BoxDecoration(
                            color: Colors.blue,
                          ),
                        ),
                        const SizedBox(
                          height: 70,
                        ),
                        Center(
                          child: Center(
                            child: Text(
                              cutString(userState.user[0].username),
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ),
                        ListTile(
                          title: const Text(
                            "Username",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                          trailing: Text(
                            userState.user[0].username,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        const Divider(),
                        ListTile(
                          title: const Text(
                            "Email",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                          trailing: Text(
                            userState.user[0].email,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        const Divider(),
                        ListTile(
                          title: const Text(
                            "Saldo",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                          trailing: Text(
                            userState.user[0].saldo.toString(),
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        const Divider(),
                        ListTile(
                          onTap: () =>
                              Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => HistoryTransaction(
                              userId: userState.user[0].userId,
                            ),
                          )),
                          leading: const Icon(
                            Icons.history,
                            color: Colors.blue,
                            size: 30,
                          ),
                          title: const Text("Riwayat Transaksi"),
                          trailing: const Icon(
                            Icons.navigate_next_outlined,
                            color: Colors.blue,
                            size: 30,
                          ),
                        ),
                        const Divider(),
                        ListTile(
                          onTap: () =>
                              Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => AccountSetting(
                              user: userState.user[0],
                            ),
                          )),
                          leading: const Icon(
                            Icons.settings,
                            color: Colors.blue,
                            size: 30,
                          ),
                          title: const Text("Pengaturan Akun"),
                          trailing: const Icon(
                            Icons.navigate_next_outlined,
                            color: Colors.blue,
                            size: 30,
                          ),
                        ),
                        const Divider(),
                        ListTile(
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
                                    "Apakah kamu ingin keluar?",
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
                                        context
                                            .read<SaveUserIdBloc>()
                                            .add(SaveUserId(userId: ""));
                                        context
                                            .read<UserBloc>()
                                            .add(GetUser(userId: ""));
                                        Navigator.of(context).pop();
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
                            size: 30,
                          ),
                          title: const Text(
                            "Keluar",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          trailing: const Icon(
                            Icons.navigate_next_outlined,
                            color: Colors.blue,
                            size: 30,
                          ),
                        ),
                        const Divider(),
                        ListTile(
                          leading: const Icon(
                            Icons.dark_mode,
                            color: Colors.blue,
                            size: 30,
                          ),
                          title: const Text(
                            "Mode gelap",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          trailing: BlocBuilder<ThemeBloc, ThemeState>(
                            bloc: context.read<ThemeBloc>()..add(LoadTheme()),
                            builder: (context, state) {
                              return AnimatedSwitcher(
                                duration: const Duration(seconds: 2),
                                transitionBuilder: (child, animation) =>
                                    ScaleTransition(
                                  scale: animation,
                                  child: child,
                                ),
                                child: Switch(
                                  key: ValueKey<bool>(state.isDark),
                                  value: state.isDark,
                                  activeColor: Colors.white,
                                  activeTrackColor: Colors.grey[700],
                                  inactiveTrackColor: Colors.white,
                                  inactiveThumbColor: Colors.grey[700],
                                  onChanged: (value) async {
                                    context
                                        .read<ThemeBloc>()
                                        .add(SaveTheme(isDark: value));
                                  },
                                ),
                              );
                            },
                          ),
                        ),
                        const Divider(),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          textAlign: TextAlign.center,
                          "Versi Aplikasi\n1.0.0",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Positioned(
                      top: MediaQuery.of(context).size.height * 0.23 - 65,
                      left: MediaQuery.of(context).size.width / 2 - 62.5,
                      child: Container(
                        width: 125,
                        height: 125,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.lightBlueAccent,
                          image: DecorationImage(
                            image: NetworkImage(userState.user[0].image),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          );
        }
        return const ShimmerLoading();
      },
    );
  }
}

class DefaultProfile extends StatelessWidget {
  const DefaultProfile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.all(0),
        children: [
          Stack(
            children: [
              Column(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.23,
                    decoration: const BoxDecoration(
                      color: Colors.blue,
                    ),
                  ),
                  const SizedBox(
                    height: 70,
                  ),
                  Center(
                    child: Center(
                      child: InkWell(
                        onTap: () =>
                            Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const LoginPage(),
                        )),
                        child: const Text(
                          "Login",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const ListTile(
                    title: Text(
                      "Username",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    trailing: Text(
                      "**********",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  const Divider(),
                  const ListTile(
                    title: Text(
                      "Email",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    trailing: Text(
                      "**********",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  const Divider(),
                  const ListTile(
                    title: Text(
                      "Saldo",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    trailing: Text(
                      "0",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  const Divider(),
                  ListTile(
                    leading: const Icon(
                      Icons.dark_mode,
                      color: Colors.blue,
                      size: 30,
                    ),
                    title: const Text(
                      "Mode gelap",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    trailing: BlocBuilder<ThemeBloc, ThemeState>(
                      bloc: context.read<ThemeBloc>()..add(LoadTheme()),
                      builder: (context, state) {
                        return AnimatedSwitcher(
                          duration: const Duration(seconds: 2),
                          transitionBuilder: (child, animation) =>
                              ScaleTransition(
                            scale: animation,
                            child: child,
                          ),
                          child: Switch(
                            key: ValueKey<bool>(state.isDark),
                            value: state.isDark,
                            activeColor: Colors.white,
                            activeTrackColor: Colors.grey[700],
                            inactiveTrackColor: Colors.white,
                            inactiveThumbColor: Colors.grey[700],
                            onChanged: (value) async {
                              context
                                  .read<ThemeBloc>()
                                  .add(SaveTheme(isDark: value));
                            },
                          ),
                        );
                      },
                    ),
                  ),
                  const Divider(),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    textAlign: TextAlign.center,
                    "Versi Aplikasi\n1.0.0",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Positioned(
                top: MediaQuery.of(context).size.height * 0.23 - 65,
                left: MediaQuery.of(context).size.width / 2 - 62.5,
                child: Container(
                  width: 125,
                  height: 125,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(
                            "https://static.vecteezy.com/system/resources/thumbnails/009/292/244/small/default-avatar-icon-of-social-media-user-vector.jpg")),
                    shape: BoxShape.circle,
                    color: Colors.lightBlueAccent,
                  ),
                ),
              ),
            ],
          )
        ],
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
    return ListView(
      padding: const EdgeInsets.all(0),
      children: [
        Stack(
          children: [
            Column(
              children: [
                Shimmer.fromColors(
                  baseColor: Colors.grey.shade300,
                  highlightColor: Colors.grey.shade100,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.23,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(
                  height: 70,
                ),
                Center(
                  child: Shimmer.fromColors(
                    baseColor: Colors.grey.shade300,
                    highlightColor: Colors.grey.shade100,
                    child: Container(
                      width: 150,
                      height: 30,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Shimmer.fromColors(
                      baseColor: Colors.grey.shade300,
                      highlightColor: Colors.grey.shade100,
                      child: Container(
                        margin: const EdgeInsets.only(left: 10),
                        width: 100,
                        height: 30,
                        color: Colors.white,
                      ),
                    ),
                    Shimmer.fromColors(
                      baseColor: Colors.grey.shade300,
                      highlightColor: Colors.grey.shade100,
                      child: Container(
                        margin: const EdgeInsets.only(right: 10),
                        width: 100,
                        height: 30,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Shimmer.fromColors(
                      baseColor: Colors.grey.shade300,
                      highlightColor: Colors.grey.shade100,
                      child: Container(
                        margin: const EdgeInsets.only(left: 10),
                        width: 100,
                        height: 30,
                        color: Colors.white,
                      ),
                    ),
                    Shimmer.fromColors(
                      baseColor: Colors.grey.shade300,
                      highlightColor: Colors.grey.shade100,
                      child: Container(
                        margin: const EdgeInsets.only(right: 10),
                        width: 100,
                        height: 30,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Shimmer.fromColors(
                      baseColor: Colors.grey.shade300,
                      highlightColor: Colors.grey.shade100,
                      child: Container(
                        margin: const EdgeInsets.only(left: 10),
                        width: 100,
                        height: 30,
                        color: Colors.white,
                      ),
                    ),
                    Shimmer.fromColors(
                      baseColor: Colors.grey.shade300,
                      highlightColor: Colors.grey.shade100,
                      child: Container(
                        margin: const EdgeInsets.only(right: 10),
                        width: 100,
                        height: 30,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                Shimmer.fromColors(
                  baseColor: Colors.grey.shade300,
                  highlightColor: Colors.grey.shade100,
                  child: ListTile(
                    leading: const Icon(
                      Icons.history,
                      size: 30,
                    ),
                    title: Shimmer.fromColors(
                      baseColor: Colors.grey.shade300,
                      highlightColor: Colors.grey.shade100,
                      child: Container(
                        margin: const EdgeInsets.only(right: 10),
                        width: 30,
                        height: 30,
                        color: Colors.white,
                      ),
                    ),
                    trailing: const Icon(
                      Icons.navigate_next_outlined,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                ),
                Shimmer.fromColors(
                  baseColor: Colors.grey.shade300,
                  highlightColor: Colors.grey.shade100,
                  child: ListTile(
                    leading: const Icon(
                      Icons.settings,
                      size: 30,
                    ),
                    title: Shimmer.fromColors(
                      baseColor: Colors.grey.shade300,
                      highlightColor: Colors.grey.shade100,
                      child: Container(
                        margin: const EdgeInsets.only(right: 10),
                        width: 30,
                        height: 30,
                        color: Colors.white,
                      ),
                    ),
                    trailing: const Icon(
                      Icons.navigate_next_outlined,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                ),
                Shimmer.fromColors(
                  baseColor: Colors.grey.shade300,
                  highlightColor: Colors.grey.shade100,
                  child: ListTile(
                    leading: const Icon(
                      Icons.logout,
                      size: 30,
                    ),
                    title: Shimmer.fromColors(
                      baseColor: Colors.grey.shade300,
                      highlightColor: Colors.grey.shade100,
                      child: Container(
                        margin: const EdgeInsets.only(right: 10),
                        width: 30,
                        height: 30,
                        color: Colors.white,
                      ),
                    ),
                    trailing: const Icon(
                      Icons.navigate_next_outlined,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                ),
                Shimmer.fromColors(
                  baseColor: Colors.grey.shade300,
                  highlightColor: Colors.grey.shade100,
                  child: ListTile(
                    leading: const Icon(
                      Icons.dark_mode,
                      size: 30,
                    ),
                    title: Shimmer.fromColors(
                      baseColor: Colors.grey.shade300,
                      highlightColor: Colors.grey.shade100,
                      child: Container(
                        margin: const EdgeInsets.only(right: 10),
                        width: 30,
                        height: 30,
                        color: Colors.white,
                      ),
                    ),
                    trailing: const Icon(
                      Icons.navigate_next_outlined,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Center(
                  child: Shimmer.fromColors(
                    baseColor: Colors.grey.shade300,
                    highlightColor: Colors.grey.shade100,
                    child: Container(
                      margin: const EdgeInsets.only(right: 10),
                      width: 100,
                      height: 40,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            Positioned(
              top: MediaQuery.of(context).size.height * 0.23 - 65,
              left: MediaQuery.of(context).size.width / 2 - 62.5,
              child: Shimmer.fromColors(
                baseColor: Colors.grey.shade300,
                highlightColor: Colors.grey.shade100,
                child: Container(
                  width: 125,
                  height: 125,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

String cutString(String inputString) {
  int index = inputString.indexOf(' ');
  if (index != -1) {
    return inputString.substring(0, index).trim();
  } else {
    return inputString;
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:topdown_store/bloc/save_userId/save_user_id_bloc.dart';
import 'package:topdown_store/bloc/theme/theme_bloc.dart';
import 'package:topdown_store/bloc/user/user_bloc.dart';
import 'package:topdown_store/bloc/validation_password/validation_password_bloc.dart';
import 'package:topdown_store/data/model/user_model.dart';
import 'package:topdown_store/widgets/text_field_custom.dart';

class AccountSetting extends StatelessWidget {
  final UserModel user;
  const AccountSetting({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    TextEditingController inputUsername =
        TextEditingController(text: user.username);
    TextEditingController inputEmail = TextEditingController(text: user.email);
    TextEditingController inputPassword =
        TextEditingController(text: user.password);
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        return BlocProvider(
          create: (context) => ValidationPasswordBloc(),
          child: Scaffold(
            appBar: AppBar(
              title: const Text("Pengaturan akun"),
              centerTitle: true,
            ),
            body: GestureDetector(
              onPanDown: (_) => FocusManager.instance.primaryFocus?.unfocus(),
              child: ListView(
                children: [
                  const SizedBox(
                    height: 5,
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 20, bottom: 10),
                    child: Text(
                      "Username",
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ),
                  TextFieldCustom(
                    typeKeyboard: TextInputType.name,
                    color: (state.isDark) ? Colors.white : Colors.black,
                    controller: inputUsername,
                    text: "Ubah Username",
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 20, bottom: 10),
                    child: Text(
                      "Email",
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ),
                  TextFieldCustom(
                    typeKeyboard: TextInputType.emailAddress,
                    color: (state.isDark) ? Colors.white : Colors.black,
                    controller: inputEmail,
                    text: "Ubah Email",
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 20, bottom: 10),
                    child: Text(
                      "Password",
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 17),
                    child: BlocBuilder<ValidationPasswordBloc,
                        ValidationPasswordState>(
                      builder: (context, passwordState) {
                        return TextField(
                          obscureText: passwordState.hideShowPassword,
                          controller: inputPassword,
                          decoration: InputDecoration(
                            suffixIcon: Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: IconButton(
                                onPressed: () => context
                                    .read<ValidationPasswordBloc>()
                                    .add(ShowPassword(
                                        hideShowPassword:
                                            !passwordState.hideShowPassword)),
                                icon: (passwordState.hideShowPassword)
                                    ? const Icon(Icons.visibility_off)
                                    : const Icon(Icons.visibility),
                              ),
                            ),
                            hintText: "Masukkan Pasword",
                            hintStyle: const TextStyle(
                                color: Colors.grey, fontSize: 14),
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
                                color: (state.isDark)
                                    ? Colors.white
                                    : Colors.black,
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
                        );
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  UnconstrainedBox(
                    child: InkWell(
                      borderRadius: BorderRadius.circular(50),
                      onTap: () {
                        context.read<UserBloc>().add(EditUser(
                              userId: user.userId,
                              username: inputUsername.text,
                              email: inputEmail.text,
                              password: inputPassword.text,
                            ));
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            duration: Duration(
                              seconds: 1,
                            ),
                            content: Text(
                              "Berhasil ubah akun!",
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
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
                            "Ubah akun",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 17),
                          ),
                        ),
                      ),
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
                                "Apakah kamu yakin ingin menghapus akun?",
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
                                        .read<UserBloc>()
                                        .add(DeleteUser(userId: user.userId));
                                    context
                                        .read<SaveUserIdBloc>()
                                        .add(SaveUserId(userId: ""));
                                    context
                                        .read<UserBloc>()
                                        .add(GetUser(userId: ""));
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        duration: Duration(
                                          seconds: 1,
                                        ),
                                        content: Text(
                                          "Berhasil hapus akun!",
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
                            "Hapus akun",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 17),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

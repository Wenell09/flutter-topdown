import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:topdown_store/bloc/auth/auth_bloc.dart';
import 'package:topdown_store/bloc/save_userId/save_user_id_bloc.dart';
import 'package:topdown_store/bloc/user/user_bloc.dart';
import 'package:topdown_store/bloc/validation_password/validation_password_bloc.dart';
import 'package:topdown_store/pages/admin_home_page.dart';
import 'package:topdown_store/pages/register_page.dart';
import 'package:topdown_store/repository/auth_repo.dart';
import 'package:topdown_store/widgets/text_field_custom.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController inputEmail = TextEditingController();
    TextEditingController inputPassword = TextEditingController();
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthBloc(AuthRepo()),
        ),
        BlocProvider(
          create: (context) => ValidationPasswordBloc(),
        ),
      ],
      child: Scaffold(
        backgroundColor: const Color(0xFFECECED),
        body: GestureDetector(
          onPanDown: (_) => FocusManager.instance.primaryFocus?.unfocus(),
          child: ListView(
            children: [
              UnconstrainedBox(
                child: Container(
                  margin: const EdgeInsets.only(top: 50, bottom: 50),
                  width: 150,
                  height: 150,
                  decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(10),
                      image: const DecorationImage(
                          image: AssetImage("image/logo.png"))),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 20, bottom: 10),
                child: Text(
                  "Email",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                  ),
                ),
              ),
              TextFieldCustom(
                color: Colors.black,
                typeKeyboard: TextInputType.emailAddress,
                controller: inputEmail,
                text: "Masukkan Email",
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
                    color: Colors.black,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: BlocBuilder<ValidationPasswordBloc,
                    ValidationPasswordState>(
                  builder: (context, passwordState) {
                    return TextField(
                      obscureText: passwordState.hideShowPassword,
                      style: const TextStyle(
                        color: Colors.black,
                      ),
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
                                ? const Icon(
                                    Icons.visibility_off,
                                    color: Colors.black,
                                  )
                                : const Icon(
                                    Icons.visibility,
                                    color: Colors.black,
                                  ),
                          ),
                        ),
                        hintText: "Masukkan Password",
                        hintStyle:
                            const TextStyle(color: Colors.grey, fontSize: 14),
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                        enabledBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                          borderSide: BorderSide(
                            color: Colors.black,
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
              BlocListener<AuthBloc, AuthState>(
                listener: (context, authState) {
                  if (authState is AuthError) {
                    return;
                  } else if (authState is AuthLoginSuccess) {
                    context
                        .read<SaveUserIdBloc>()
                        .add(SaveUserId(userId: authState.userId));
                    context
                        .read<UserBloc>()
                        .add(GetUser(userId: authState.userId));
                    if (authState.userId ==
                        "411de7ad-044a-4dac-8b38-85616a7ee517") {
                      Navigator.of(context).pop();
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => const AdminHomePage(),
                      ));
                    } else {
                      Navigator.of(context).pop();
                    }
                  }
                },
                child: BlocBuilder<AuthBloc, AuthState>(
                  builder: (context, authState) {
                    if (authState is AuthLoading) {
                      return UnconstrainedBox(
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.9,
                          height: 50,
                          decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(50)),
                          child:
                              const Center(child: CircularProgressIndicator()),
                        ),
                      );
                    } else if (authState is AuthError) {
                      return Column(
                        children: [
                          Center(
                            child: Text(
                              textAlign: TextAlign.center,
                              authState.error,
                              style: const TextStyle(
                                  fontSize: 16, color: Colors.red),
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          UnconstrainedBox(
                            child: InkWell(
                              borderRadius: BorderRadius.circular(50),
                              onTap: () => context.read<AuthBloc>().add(Login(
                                    email: inputEmail.text,
                                    password: inputPassword.text,
                                  )),
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.9,
                                height: 50,
                                decoration: BoxDecoration(
                                    color: Colors.black,
                                    borderRadius: BorderRadius.circular(50)),
                                child: const Center(
                                  child: Text(
                                    "Login",
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
                      );
                    }
                    return UnconstrainedBox(
                      child: InkWell(
                        borderRadius: BorderRadius.circular(50),
                        onTap: () => context.read<AuthBloc>()
                          ..add(Login(
                            email: inputEmail.text,
                            password: inputPassword.text,
                          )),
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.9,
                          height: 50,
                          decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(50)),
                          child: const Center(
                            child: Text(
                              "Login",
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
                height: 10,
              ),
              Center(
                child: InkWell(
                  onTap: () =>
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => const RegisterPage(),
                  )),
                  child: const Text(
                    "Belum punya akun? Daftar disini!",
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 13,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

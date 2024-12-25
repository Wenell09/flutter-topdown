// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:topdown_store/bloc/save_userId/save_user_id_bloc.dart';
import 'package:topdown_store/pages/admin_home_page.dart';
import 'package:topdown_store/pages/navigation_page.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<SaveUserIdBloc, SaveUserIdState>(
      listener: (context, state) {
        if (state is SaveUserLoaded) {
          if (state.userId == "411de7ad-044a-4dac-8b38-85616a7ee517") {
            Future.delayed(
                const Duration(
                  seconds: 1,
                ),
                () => Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => const AdminHomePage(),
                    )));
          } else {
            Future.delayed(
                const Duration(
                  seconds: 1,
                ),
                () => Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => const NavigationPage(),
                    )));
          }
        }
      },
      child: Scaffold(
        backgroundColor: const Color(0xFFECECED),
        body: Center(
          child: SingleChildScrollView(
            child: Container(
              margin: const EdgeInsets.only(bottom: 50),
              width: 180,
              height: 180,
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(10),
                image: const DecorationImage(
                  image: AssetImage("image/logo.png"),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

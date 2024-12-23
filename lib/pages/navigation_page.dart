import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:topdown_store/bloc/navigation/navigation_bloc.dart';
import 'package:topdown_store/bloc/theme/theme_bloc.dart';
import 'package:topdown_store/pages/home_page.dart';
import 'package:topdown_store/pages/profile_page.dart';
import 'package:topdown_store/pages/search_page.dart';

class NavigationPage extends StatelessWidget {
  const NavigationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NavigationBloc(),
      child: BlocBuilder<NavigationBloc, NavigationState>(
        builder: (context, state) {
          return BlocBuilder<ThemeBloc, ThemeState>(
            builder: (context, themeState) {
              return Scaffold(
                body: IndexedStack(
                  index: state.index,
                  children: const [
                    HomePage(),
                    SearchPage(),
                    ProfilePage(),
                  ],
                ),
                bottomNavigationBar: BottomNavigationBar(
                  currentIndex: state.index,
                  onTap: (value) => context
                      .read<NavigationBloc>()
                      .add(ChangeNavigation(index: value)),
                  items: const [
                    BottomNavigationBarItem(
                      icon: Icon(Icons.home),
                      label: "Beranda",
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.search),
                      label: "Pencarian",
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.person),
                      label: "Akun",
                    ),
                  ],
                  elevation: 0,
                  backgroundColor:
                      (themeState.isDark) ? Colors.black : Colors.white,
                  unselectedItemColor: Colors.grey,
                  selectedItemColor:
                      (themeState.isDark) ? Colors.white : Colors.black,
                  unselectedIconTheme: const IconThemeData(size: 25),
                  selectedIconTheme: const IconThemeData(size: 30),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:topdown_store/bloc/item/item_bloc.dart';
import 'package:topdown_store/bloc/product/product_bloc.dart';
import 'package:topdown_store/bloc/save_userId/save_user_id_bloc.dart';
import 'package:topdown_store/bloc/select_category_product/select_product_bloc.dart';
import 'package:topdown_store/bloc/theme/theme_bloc.dart';
import 'package:topdown_store/bloc/user/user_bloc.dart';
import 'package:topdown_store/pages/splash_page.dart';
import 'package:topdown_store/repository/item_repo.dart';
import 'package:topdown_store/repository/product_repo.dart';
import 'package:topdown_store/repository/user_repo.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting("id_ID", null);
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => SaveUserIdBloc()..add(LoadUserId()),
        ),
        BlocProvider(
          create: (context) => UserBloc(UserRepo()),
        ),
        BlocProvider(
          create: (context) => ProductBloc(ProductRepo()),
        ),
        BlocProvider(
          create: (context) => ItemBloc(ItemRepo()),
        ),
        BlocProvider(
          create: (context) => ThemeBloc()..add(LoadTheme()),
        ),
        BlocProvider(
          create: (context) => SelectCategoryProductBloc(),
        )
      ],
      child: BlocListener<SaveUserIdBloc, SaveUserIdState>(
        listener: (context, state) {
          if (state is SaveUserLoaded) {
            context.read<UserBloc>().add(GetUser(userId: state.userId));
          }
        },
        child: BlocBuilder<ThemeBloc, ThemeState>(
          builder: (context, state) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Topdown Store',
              theme: state.isDark ? ThemeData.dark() : ThemeData.light(),
              home: const SplashPage(),
            );
          },
        ),
      ),
    );
  }
}

import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/features/all_routes.dart';
import 'package:amazon_clone/features/auth/services/auth_service.dart';
import 'package:amazon_clone/features/router.dart';
import 'package:amazon_clone/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => UserProvider(),
        ),
      ],
      child: const App(),
    ),
  );
}

GlobalKey<ScaffoldMessengerState> scaffoldMessenger =
    GlobalKey<ScaffoldMessengerState>();

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  final AuthService _authService = AuthService();

  @override
  void initState() {
    super.initState();
    _authService.getUserData(context);
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, __) {
        return MaterialApp(
          scaffoldMessengerKey: scaffoldMessenger,
          title: 'Amazon Clone',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            scaffoldBackgroundColor: GlobalVariables.backgroundColor,
            appBarTheme: const AppBarTheme(
              elevation: 0,
              iconTheme: IconThemeData(
                color: Colors.black,
              ),
            ),
            colorScheme: const ColorScheme.light(
              primary: GlobalVariables.secondaryColor,
            ),
          ),
          onGenerateRoute: onGenerateRoute,
          home: Provider.of<UserProvider>(context).user.token.isNotEmpty
              ? const HomeScreen()
              : const AuthScreen(),
        );
      },
    );
  }
}

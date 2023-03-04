import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/features/auth/screens/auth_screen.dart';
import 'package:amazon_clone/features/router.dart';
import 'package:amazon_clone/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    const App(),
  );
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return ChangeNotifierProvider(
            create: (_) => UserProvider(),
            child: MaterialApp(
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
              home: const AuthScreen(),
            ),
          );
        });
  }
}

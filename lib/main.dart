import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loavi_project/blocs/shared_bloc/shared_bloc.dart';
import 'package:loavi_project/frontend/app_theme.dart';
import 'package:loavi_project/frontend/screens/nav_bar.dart';
import 'package:loavi_project/frontend/screens/select_language_page.dart';
import 'package:loavi_project/frontend/screens/sign_in_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

String? loginToken;
bool? lang;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  SharedPreferences localStorage = await SharedPreferences.getInstance();
  loginToken = localStorage.getString('token');
  lang = localStorage.getBool('lang');
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ),
  );
  runApp(EasyLocalization(
      supportedLocales: const [Locale('ar'), Locale('en')],
      path: 'assets/translations',
      fallbackLocale: const Locale('ar'),
      saveLocale: true,
      child: const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: BlocProvider<SharedBloc>(
        create: (context) => SharedBloc(),
        child: BlocListener<SharedBloc,SharedState>(
          listener: (context , state){
              debugPrint("called -------------->");
              setState(() {

              });

          },
          child: MaterialApp(
              title: 'Flutter Demo',
              localizationsDelegates: context.localizationDelegates,
              supportedLocales: context.supportedLocales,
              locale: context.locale,
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                  appBarTheme: AppBarTheme(
                    color: AppTheme.accent7,
                    elevation: 0.0,
                  ),
                  inputDecorationTheme: InputDecorationTheme(
                    contentPadding: EdgeInsets.only(left: 10,right: 10),
                  )
              ),
              home: (lang == true)
                  ? (loginToken != null
                  ? const AppNavigationBar()
                  : const SigninScreen())
                  : SelectLanguagePage()),
        ),
      ),
    );
  }
}

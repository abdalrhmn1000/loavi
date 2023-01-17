import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loavi_project/frontend/app_theme.dart';
import 'package:loavi_project/frontend/screens/nav_bar.dart';
import 'package:loavi_project/frontend/screens/sign_in_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SelectLanguagePage extends StatefulWidget {
  const SelectLanguagePage({Key? key}) : super(key: key);

  @override
  State<SelectLanguagePage> createState() => _SelectLanguagePageState();
}

class _SelectLanguagePageState extends State<SelectLanguagePage> {
  bool _localization = false;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: screenWidth * (20 / 375)),
        child: Column(
          children: [
            Center(child: Image.asset('assets/images/logo 2.png')),
            Text(
              'welcome'.tr(),
              style: AppTheme.interBold
                  .copyWith(fontSize: 32, color: const Color(0xFF1A1D1F)),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 20,
                bottom: 50,
              ),
              child: Text(
                'select_your_language'.tr(),
                style: AppTheme.interBold
                    .copyWith(fontSize: 20, color: const Color(0xFF1A1D1F)),
              ),
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  !_localization ? 'English' : "العربية",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 17.0,
                  ),
                ),
                CupertinoSwitch(
                    activeColor: AppTheme.accent7,
                    value: _localization,
                    onChanged: (val) {
                      setState(() {
                        _localization = val;
                      });
                    })
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton(
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(AppTheme.accent7)),
            onPressed: () async {
              SharedPreferences localStorage =
                  await SharedPreferences.getInstance();
              localStorage.setBool('lang', true);
              if (_localization) {
                context.setLocale(const Locale('ar'));
              } else {
                context.setLocale(const Locale('en'));
              }
              Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
              (localStorage.getString('token') != null
                  ? const AppNavigationBar()
                  : const SigninScreen())), (Route<dynamic> route) => false);
            },
            child: Text('next').tr()),
      ),
    );
  }
}

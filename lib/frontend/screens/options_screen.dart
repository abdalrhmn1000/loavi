import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:loavi_project/blocs/shared_bloc/shared_bloc.dart';
import 'package:loavi_project/frontend/screens/setting_list_tile.dart';
import 'package:loavi_project/frontend/screens/sign_in_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OptionsScreen extends StatefulWidget {
  const OptionsScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<OptionsScreen> createState() => _OptionsScreenState();
}

class _OptionsScreenState extends State<OptionsScreen> {
  @override
  Widget build(BuildContext context) {
    void _showMaterialDialog() {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: Text('logout'.tr()),
                content: const Text('are_you_sure_you_want_to_logout').tr(),
                actions: <Widget>[
                  TextButton(
                    child: const Text('no').tr(),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  TextButton(
                    child: const Text('yes').tr(),
                    onPressed: () async {
                      SharedPreferences localStorage =
                          await SharedPreferences.getInstance();
                      var loginToken = localStorage.get('token');
                      var url = 'http://skygulf.zona.ae/api/auth/logout';
                      var response = await http.post(Uri.parse(url), headers: {
                        'Content-type': 'application/json',
                        'Accept': 'application/json',
                        'Authorization': 'Bearer $loginToken'
                      });
                      if (response.statusCode == 200) {
                        SharedPreferences localStorage =
                            await SharedPreferences.getInstance();
                        await localStorage.remove('token');
                        if (!mounted) return;

                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                                builder: (context) => const SigninScreen()),
                            (Route<dynamic> route) => false);
                      }
                    },
                  ),
                ],
              ));
    }

    void _showCupertinoLogoutDialog() {
      showCupertinoModalPopup<void>(
        context: context,
        builder: (BuildContext context) => CupertinoAlertDialog(
          title: Text('logout'.tr()),
          content: Text('are_you_sure_you_want_to_logout'.tr()),
          actions: <CupertinoDialogAction>[
            CupertinoDialogAction(
              isDefaultAction: true,
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('no').tr(),
            ),
            CupertinoDialogAction(
              isDestructiveAction: true,
              onPressed: () async {
                SharedPreferences localStorage =
                    await SharedPreferences.getInstance();
                var loginToken = localStorage.get('token');
                var url = 'http://skygulf.zona.ae/api/auth/logout';
                var response = await http.post(Uri.parse(url), headers: {
                  'Content-type': 'application/json',
                  'Accept': 'application/json',
                  'Authorization': 'Bearer $loginToken'
                });
                if (response.statusCode == 200) {
                  if (!mounted) return;
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                          builder: (context) => const SigninScreen()),
                      (Route<dynamic> route) => false);
                }
              },
              child: const Text('yes').tr(),
            ),
          ],
        ),
      );
    }

    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: screenWidth * (20 / 375)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(child: Image.asset('assets/images/logo 2.png')),
              // Text(
              //   'Profile',
              //   style: AppTheme.interMedium.copyWith(fontSize: 24),
              // ),
              // const Divider(),
              SettingListTile(
                  onTap: () {
                    if (Platform.isIOS) {
                      _showCupertinoLogoutDialog();
                      return;
                    }
                    _showMaterialDialog();
                  },
                  leading: Icon(Icons.logout_rounded),
                  title: Text('logout'.tr())),
              const Divider(),
              SettingListTile(
                onTap: () {
                  if (context.locale.toString() == 'en') {
                    context.setLocale(const Locale('ar'));
                    context.read<SharedBloc>().add(ChangedLanguage(loc: "ar"));
                  } else {
                    context.setLocale(const Locale('en'));
                    context.read<SharedBloc>().add(ChangedLanguage(loc: "en"));
                  }

                },
                leading: const Icon(Icons.language),
                title: Text('change_language'.tr()),
              ),
              const Divider(),
            ],
          ),
        ),
      ),
    );
  }
}

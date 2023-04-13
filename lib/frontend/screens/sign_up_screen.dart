import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:loavi_project/blocs/login/login_bloc.dart';
import 'package:loavi_project/blocs/signup/signup_bloc.dart';
import 'package:loavi_project/blocs/signup/signup_event.dart';
import 'package:loavi_project/blocs/signup/signup_state.dart';
import 'package:loavi_project/frontend/app_theme.dart';
import 'package:loavi_project/frontend/screens/nav_bar.dart';
import 'package:loavi_project/frontend/screens/sign_in_screen.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  String gender = '';
  String firstName = '';
  String lastName = '';
  String email = '';
  String phoneNumber = '';
  String password = '';
  bool _obscure = true;
  String birthdate = '';

  Future<String> login(String email, String password) async {
    var url =
        'https://Skygulfapp.gulfsky-app.website/api/auth/login?email=$email&password=$password';
    var response = await http.post(Uri.parse(url));
    var body = jsonDecode(response.body);
    if (response.statusCode == 200) {
      return body['data']['token'];
    } else {
      return 'fail';
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => SignupBloc(),
        ),
        BlocProvider(
          create: (context) => LoginBloc(),
        ),
      ],
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: screenWidth * (20 / 375)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                    child: Image.asset(
                  'assets/images/logo 2.png',
                  height: screenHeight * (200 / 812),
                )),
                Text(
                  'sign_up'.tr(),
                  style: AppTheme.interSemiBold
                      .copyWith(fontSize: 32, color: Colors.black),
                ),
                SizedBox(
                  height: screenHeight * (24 / 812),
                ),
                Text(
                  'gender'.tr(),
                  style: AppTheme.interSemiBold
                      .copyWith(fontSize: 15, color: Colors.black),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                     Text(
                      'male'.tr(),
                      style: AppTheme.interSemiBold,
                    ),
                    Radio<String>(
                      activeColor: AppTheme.accent7,
                      value: 'male'.tr(),
                      groupValue: gender,
                      onChanged: (value) {
                        setState(() {
                          gender = value!;
                        });
                      },
                    ),
                    SizedBox(
                      width: screenWidth * (30 / 375),
                    ),
                     Text(
                      'female'.tr(),
                      style: AppTheme.interSemiBold,
                    ),
                    Radio<String>(
                      activeColor: AppTheme.accent7,
                      value: 'female'.tr(),
                      groupValue: gender,
                      onChanged: (value) {
                        setState(() {
                          gender = value!;
                        });
                      },
                    ),
                  ],
                ),
                Text(
                  'first_name'.tr(),
                  style: AppTheme.interSemiBold
                      .copyWith(fontSize: 15, color: Colors.black),
                ),
                SizedBox(
                  height: screenHeight * (8 / 812),
                ),
                Container(
                  padding: EdgeInsets.only(left: screenWidth * (12 / 375)),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: AppTheme.lightGrey),
                  child: TextField(
                    onChanged: (value) {
                      firstName = value;
                    },
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'first_name'.tr(),
                        hintStyle: AppTheme.interSemiBold
                            .copyWith(color: const Color(0xFFD1D3D4))),
                  ),
                ),
                SizedBox(
                  height: screenHeight * (20 / 812),
                ),
                Text(
                  'last_name'.tr(),
                  style: AppTheme.interSemiBold
                      .copyWith(fontSize: 15, color: Colors.black),
                ),
                SizedBox(
                  height: screenHeight * (8 / 812),
                ),
                Container(
                  padding: EdgeInsets.only(left: screenWidth * (12 / 375)),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: AppTheme.lightGrey),
                  child: TextField(
                    onChanged: (value) {
                      lastName = value;
                    },
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText:   'last_name'.tr(),
                        hintStyle: AppTheme.interSemiBold
                            .copyWith(color: const Color(0xFFD1D3D4))),
                  ),
                ),
                SizedBox(
                  height: screenHeight * (20 / 812),
                ),
                Text(
                  'phone_number'.tr(),
                  style: AppTheme.interSemiBold
                      .copyWith(fontSize: 15, color: Colors.black),
                ),
                SizedBox(
                  height: screenHeight * (8 / 812),
                ),
                Container(
                  padding: EdgeInsets.only(left: screenWidth * (12 / 375)),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: AppTheme.lightGrey),
                  child: Row(
                    children: [
                      Image.asset(
                        'assets/images/emirates_flag_logo.png',
                        height: 24,
                        width: 24,
                      ),
                      const Text(
                        ' +971  ',
                        style: AppTheme.interSemiBold,
                      ),
                      Expanded(
                        child: TextField(
                          onChanged: (value) {
                            phoneNumber = value;
                          },
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'phone_number'.tr(),
                              hintStyle: AppTheme.interSemiBold
                                  .copyWith(color: const Color(0xFFD1D3D4))),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: screenHeight * (20 / 812),
                ),
                GestureDetector(
                  onTap: () {
                    DatePicker.showDatePicker(context,
                        showTitleActions: true,
                        minTime: DateTime(1920, 1, 1),
                        maxTime: DateTime(2019, 6, 7), onConfirm: (date) {
                      setState(() {
                        birthdate = date.toString();
                      });
                    }, currentTime: DateTime.now(), locale: LocaleType.en);
                  },
                  child: Container(
                    width: screenWidth,
                    padding: EdgeInsets.only(
                        left: screenWidth * (16 / 375),
                        right: screenWidth * (16 / 375),
                        top: screenHeight * (19 / 812),
                        bottom: screenHeight * (19 / 812)),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: const Color(0xFFCA3939))),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          (birthdate.isEmpty)
                              ? 'birthday'.tr()
                              : birthdate.toString().substring(0, 10),
                          style: AppTheme.interMedium
                              .copyWith(color: const Color(0xFF1A1B2D)),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: screenHeight * (20 / 812),
                ),
                Text(
                  'email'.tr(),
                  style: AppTheme.interSemiBold
                      .copyWith(fontSize: 15, color: Colors.black),
                ),
                SizedBox(
                  height: screenHeight * (8 / 812),
                ),
                Container(
                  padding: EdgeInsets.only(left: screenWidth * (12 / 375)),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: AppTheme.lightGrey),
                  child: TextField(
                    onChanged: (value) {
                      email = value;
                    },
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'email'.tr(),
                        hintStyle: AppTheme.interSemiBold
                            .copyWith(color: const Color(0xFFD1D3D4))),
                  ),
                ),
                SizedBox(
                  height: screenHeight * (20 / 812),
                ),
                Text(
                  'password'.tr(),
                  style: AppTheme.interSemiBold
                      .copyWith(fontSize: 15, color: Colors.black),
                ),
                SizedBox(
                  height: screenHeight * (8 / 812),
                ),
                Container(
                  padding: EdgeInsets.only(left: screenWidth * (12 / 375)),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: AppTheme.lightGrey),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          onChanged: (value) {
                            password = value;
                          },
                          obscureText: _obscure,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'password'.tr(),
                              hintStyle: AppTheme.interSemiBold
                                  .copyWith(color: const Color(0xFFD1D3D4))),
                        ),
                      ),
                      IconButton(
                          onPressed: () {
                            setState(() {
                              _obscure = !_obscure;
                            });
                          },
                          icon: (!_obscure)
                              ? const Icon(Icons.visibility)
                              : const Icon(Icons.visibility_off))
                    ],
                  ),
                ),
                SizedBox(
                  height: screenHeight * (60 / 812),
                ),
                BlocConsumer<SignupBloc, SignupState>(
                  listener: (context, state) async {
                    if (state is SignUpFailure) {
                      AppTheme.showSnackBar(context, state.reason);
                    }

                    if (state is SignUpSuccess) {
                      String token = await login(email, password);
                      if (token != 'fail') {
                        SharedPreferences localStorage =
                            await SharedPreferences.getInstance();
                        await localStorage.clear();
                        localStorage.setString('token', token);

                        if (!mounted) return;
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                                builder: (context) => AppNavigationBar()),
                            (Route<dynamic> route) => false);
                      }
                    }
                  },
                  builder: (context, state) {
                    if (state is SignUpInProgress) {
                      return Container(
                        padding: EdgeInsets.symmetric(
                            vertical: screenHeight * (15 / 812)),
                        decoration: BoxDecoration(
                            color: const Color(0xFFEFEFEF),
                            borderRadius: BorderRadius.circular(8)),
                        child:
                            const Center(child: CupertinoActivityIndicator()),
                      );
                    }
                    return GestureDetector(
                      onTap: () {
                        if (firstName == '') {
                          AppTheme.showSnackBar(context, 'firstName_required'.tr());
                          return;
                        }
                        if (lastName == '') {
                          AppTheme.showSnackBar(context, 'lastName_required'.tr());
                          return;
                        }
                        if (email == '') {
                          AppTheme.showSnackBar(context, 'email_required');
                          return;
                        }
                        if (password == '') {
                          AppTheme.showSnackBar(context, 'password_required'.tr());
                          return;
                        }
                        if (birthdate == '') {
                          AppTheme.showSnackBar(context, 'birthdate_required'.tr());
                          return;
                        }
                        if (gender == '') {
                          AppTheme.showSnackBar(context, 'gender_required'.tr());
                          return;
                        }
                        if (phoneNumber == '') {
                          AppTheme.showSnackBar(
                              context, 'phone_number_required'.tr());
                          return;
                        }
                        BlocProvider.of<SignupBloc>(context)
                            .add(SignUpRequested(
                          email: email,
                          password: password,
                          firstName: firstName,
                          lastName: lastName,
                          phoneNumber: phoneNumber,
                          gender: gender,
                          birthDate: birthdate,
                        ));
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            vertical: screenHeight * (15 / 812)),
                        decoration: BoxDecoration(
                            color: const Color(0xFFEFEFEF),
                            borderRadius: BorderRadius.circular(8)),
                        child: Center(
                            child: Text(
                          'sign_up'.tr(),
                          style: AppTheme.interBold.copyWith(fontSize: 15),
                        )),
                      ),
                    );
                  },
                ),
                SizedBox(
                  height: screenHeight * (30 / 812),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'already_have_an_account'.tr(),
                      style: AppTheme.interBold
                          .copyWith(color: const Color(0xFF9A9FA5)),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SigninScreen()));
                      },
                      child: Text(
                        'sign_in'.tr(),
                        style: AppTheme.interBold.copyWith(color: Colors.black),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: screenHeight * (30 / 812),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

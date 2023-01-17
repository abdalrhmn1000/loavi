import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loavi_project/blocs/login/login_bloc.dart';
import 'package:loavi_project/blocs/login/login_event.dart';
import 'package:loavi_project/blocs/login/login_state.dart';
import 'package:loavi_project/frontend/app_theme.dart';
import 'package:loavi_project/frontend/screens/nav_bar.dart';
import 'package:loavi_project/frontend/screens/sign_up_screen.dart';

class SigninScreen extends StatefulWidget {
  const SigninScreen({Key? key}) : super(key: key);

  @override
  State<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  String email = '';
  String password = '';
  bool _obscure = true;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: screenWidth * (20 / 375)),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(child: Image.asset('assets/images/logo 2.png')),
                Text(
                  'sign_in'.tr(),
                  style: AppTheme.interSemiBold
                      .copyWith(fontSize: 32, color: Colors.black),
                ),
                SizedBox(
                  height: screenHeight * (24 / 812),
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
                  height: screenHeight * (20 / 812),
                ),
                BlocProvider(
                  create: (context) => LoginBloc(),
                  child: BlocConsumer<LoginBloc, LoginState>(
                    listener: (context, state) {
                      if (state is LoginSuccess) {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const AppNavigationBar()));
                      }

                      if (state is LoginFailure) {
                        AppTheme.showSnackBar(context, state.reason);
                      }
                    },
                    builder: (context, state) {
                      if (state is LoginInProgress) {
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
                        onTap: () async {
                          BlocProvider.of<LoginBloc>(context).add(
                              LoginRequested(email: email, password: password));
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              vertical: screenHeight * (15 / 812)),
                          decoration: BoxDecoration(
                              color: const Color(0xFFEFEFEF),
                              borderRadius: BorderRadius.circular(8)),
                          child: Center(
                              child: Text(
                            'sign_in'.tr(),
                            style: AppTheme.interBold.copyWith(fontSize: 15),
                          )),
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(
                  height: screenHeight * (20 / 812),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'do_not_have_an_account'.tr(),
                      style: AppTheme.interBold
                          .copyWith(color: const Color(0xFF9A9FA5)),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SignupScreen()));
                      },
                      child: Text(
                        'sign_up'.tr(),
                        style: AppTheme.interBold.copyWith(color: Colors.black),
                      ),
                    )
                  ],
                ),
              ]),
        ),
      ),
    );
  }
}

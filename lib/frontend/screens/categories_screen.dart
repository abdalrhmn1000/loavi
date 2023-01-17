import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loavi_project/blocs/categories/get_catogories_cubit.dart';
import 'package:loavi_project/frontend/app_theme.dart';
import 'package:loavi_project/frontend/screens/customer_check_screen.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    String lang = context.locale.toString() == 'en'?'en':'ar';
    return BlocProvider(
      create: (context) => GetCatogoriesCubit()..getCategories(lang),
      child: Scaffold(
        appBar: AppBar(
          leading: BackButton(),
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: screenWidth * (20 / 375)),
            child: Column(
              children: [
                Center(
                    child: Image.asset(
                  'assets/images/logo 2.png',
                  width: screenWidth * (160 / 375),
                )),
                Text(
                  'maintenance_request'.tr(),
                  style: AppTheme.interBold
                      .copyWith(fontSize: 32, color: const Color(0xFF1A1D1F)),
                ),
                SizedBox(
                  height: screenHeight * (19 / 812),
                ),
                BlocConsumer<GetCatogoriesCubit, GetCatogoriesState>(
                  listener: (context, state) {
                    if (state is GetCatogoriesFailure) {
                      AppTheme.showSnackBar(
                          context, 'error_loading_categories'.tr());
                    }
                  },
                  builder: (context, state) {
                    if (state is GetCatogoriesSuccess) {
                      return SizedBox(
                        height: screenHeight,
                        child: ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: state.categories.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              CustomerCheckScreen(
                                                  category: state.categories
                                                      .elementAt(index))));
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: screenHeight * (10 / 812)),
                                  margin: EdgeInsets.only(
                                      bottom: screenHeight * (10 / 812)),
                                  decoration: BoxDecoration(
                                      color: AppTheme.accent7,
                                      borderRadius: BorderRadius.circular(20)),
                                  child: Center(
                                      child: Text(
                                    state.categories.elementAt(index).name,
                                    style: AppTheme.interSemiBold.copyWith(
                                        color: const Color(0xFFFFFFFF)),
                                  )),
                                ),
                              );
                            }),
                      );
                    }
                    if (state is GetCatogoriesInProgress) {
                      return const Center(
                        child: CupertinoActivityIndicator(),
                      );
                    }
                    return  Center(child: Text('error_loading_categories'.tr()));
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

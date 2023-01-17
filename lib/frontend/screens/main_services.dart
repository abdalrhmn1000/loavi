import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loavi_project/blocs/shared_bloc/shared_bloc.dart';
import 'package:loavi_project/frontend/app_theme.dart';
import 'package:loavi_project/frontend/screens/bundles_screen.dart';
import 'package:loavi_project/frontend/screens/categories_screen.dart';
import 'package:loavi_project/frontend/screens/evacuation_screen.dart';
import 'package:loavi_project/frontend/screens/review_screen.dart';

class MainServices extends StatefulWidget {
  const MainServices({
    Key? key,
  }) : super(key: key);

  @override
  State<MainServices> createState() => _MainServicesState();
}

class _MainServicesState extends State<MainServices> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return BlocListener<SharedBloc , SharedState>(
      listener: (context , state){
        setState(() {

        });
      },
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: screenWidth * (20 / 375)),
            child: Column(children: [
              Center(child: Image.asset('assets/images/logo 2.png')),
              Text(
                'main_services'.tr(),
                style: AppTheme.interBold
                    .copyWith(fontSize: 32, color: const Color(0xFF1A1D1F)),
              ),
              SizedBox(
                height: screenHeight * (81 / 812),
              ),
              SizedBox(
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const CategoriesScreen()));
                      },
                      child: Container(
                        margin:
                            EdgeInsets.only(bottom: screenHeight * (22 / 812)),
                        padding: EdgeInsets.symmetric(
                            vertical: screenHeight * (32 / 812)),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: AppTheme.accent7),
                        child: Center(
                            child: Text(
                          'maintenance_request'.tr(),
                          style: AppTheme.interBold.copyWith(
                              color: const Color(0xFFFFFFFF), fontSize: 25),
                        )),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const BundlesScreen()));
                      },
                      child: Container(
                        margin:
                            EdgeInsets.only(bottom: screenHeight * (22 / 812)),
                        padding: EdgeInsets.symmetric(
                            vertical: screenHeight * (32 / 812)),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: AppTheme.accent7,
                        ),
                        child: Center(
                            child: Text(
                          'gulf_sky_packages_bundles'.tr(),
                          style: AppTheme.interBold.copyWith(
                              color: const Color(0xFFFFFFFF), fontSize: 20),
                        )),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const ReviewScreen()));
                      },
                      child: Container(
                        margin:
                            EdgeInsets.only(bottom: screenHeight * (22 / 812)),
                        padding: EdgeInsets.symmetric(
                            vertical: screenHeight * (32 / 812)),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: AppTheme.accent7,
                        ),
                        child: Center(
                            child: Text(
                          'review'.tr(),
                          style: AppTheme.interBold.copyWith(
                              color: const Color(0xFFFFFFFF), fontSize: 24),
                        )),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const EvacuationScreen()));
                      },
                      child: Container(
                        margin:
                            EdgeInsets.only(bottom: screenHeight * (22 / 812)),
                        padding: EdgeInsets.symmetric(
                            vertical: screenHeight * (32 / 812)),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: AppTheme.accent7,
                        ),
                        child: Center(
                            child: Text(
                          'evacuation'.tr(),
                          style: AppTheme.interBold.copyWith(
                              color: const Color(0xFFFFFFFF), fontSize: 24),
                        )),
                      ),
                    ),
                  ],
                ),
              )
            ]),
          ),
        ),
      ),
    );
  }
}

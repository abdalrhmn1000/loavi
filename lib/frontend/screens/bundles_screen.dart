import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loavi_project/blocs/bundles/bundles_cubit.dart';
import 'package:loavi_project/blocs/join_bundle/join_bundle_cubit.dart';
import 'package:loavi_project/frontend/app_theme.dart';
import 'package:loavi_project/frontend/screens/bundle_feature_screen.dart';
import 'package:loavi_project/models/bundle.dart';

class BundlesScreen extends StatefulWidget {
  const BundlesScreen({Key? key}) : super(key: key);

  @override
  State<BundlesScreen> createState() => _BundlesScreenState();
}

class _BundlesScreenState extends State<BundlesScreen> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    String lang = context.locale.toString() == 'en' ? 'en' : 'ar';
    return BlocProvider(
      create: (context) => BundlesCubit()..getBundles(lang),
      child: Scaffold(
        appBar: AppBar(
          leading: BackButton(),
        ),
        body: SingleChildScrollView(
          child: Container(
              padding:
                  EdgeInsets.symmetric(horizontal: screenWidth * (20 / 375)),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [
                    Center(
                        child: Image.asset(
                      'assets/images/logo 2.png',
                      height: screenHeight * (200 / 812),
                    )),
                    Text(
                      'gulf_sky_packages_bundles'.tr(),
                      textAlign: TextAlign.center,
                      style: AppTheme.interBold.copyWith(
                          fontSize: 32, color: const Color(0xFF1A1D1F)),
                    ),
                    SizedBox(
                      height: screenHeight * (30 / 812),
                    ),
                    BlocConsumer<BundlesCubit, BundlesState>(
                      listener: (context, state) {
                        if (state is BundlesFailure) {
                          AppTheme.showSnackBar(
                              context, 'error_loading_bundles'.tr());
                        }
                      },
                      builder: (context, state) {
                        if (state is BundlesInProgress) {
                          return const Center(
                            child: CupertinoActivityIndicator(),
                          );
                        }
                        if (state is BundlesSuccess) {
                          return Container(
                              padding: const EdgeInsets.all(10),
                              child: ListView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: state.bundles.length,
                                  itemBuilder: (context, index) {
                                    return GestureDetector(
                                      onTap: () {
                                        if (state.bundles[index].features
                                                ?.isNotEmpty ??
                                            false) {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      BundleFeatureScreen(
                                                        id: state
                                                            .bundles[index].id,
                                                        name: state
                                                            .bundles[index]
                                                            .name,
                                                        features: state
                                                            .bundles[index]
                                                            .features!,
                                                      )));
                                        }
                                      },
                                      child: Column(
                                        children: [
                                          SizedBox(
                                            height: screenHeight * (20 / 812),
                                          ),
                                          BundleCard(
                                            bundle:
                                                state.bundles.elementAt(index),
                                          ),
                                          SizedBox(
                                            height: screenHeight * (20 / 812),
                                          ),
                                        ],
                                      ),
                                    );
                                  }));
                        }
                        return Container();
                      },
                    ),
                  ],
                ),
              )),
        ),
      ),
    );
  }
}

class BundleCard extends StatefulWidget {
  final Bundle bundle;

  const BundleCard({
    Key? key,
    required this.bundle,
  }) : super(key: key);

  @override
  State<BundleCard> createState() => _BundleCardState();
}

class _BundleCardState extends State<BundleCard> {
  @override
  Widget build(BuildContext context) {
    Future<bool> _showMaterialDialog(Bundle bundle) async {
      return await showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: Center(child: Text('attention').tr()),
                content: Text(
                    '${'are_you_sure_you_want_to_Join_gulf_sky'.tr()} ${bundle.name} ${'for'.tr()} ${bundle.price} ${'aed'.tr()}?'),
                actions: <Widget>[
                  TextButton(
                    child: const Text('no').tr(),
                    onPressed: () {
                      Navigator.of(context).pop(false);
                    },
                  ),
                  TextButton(
                    child: const Text('yes').tr(),
                    onPressed: () async {
                      Navigator.of(context).pop(true);
                    },
                  ),
                ],
              ));
    }

    void _showCupertinoLogoutDialog(Bundle bundle) {
      showCupertinoModalPopup<void>(
        context: context,
        builder: (BuildContext context) => CupertinoAlertDialog(
          title: Text('attention'.tr()),
          content: Text(
              '${'are_you_sure_you_want_to_Join_gulf_sky'.tr()} ${bundle.name} ${'for'.tr()} ${bundle.price} ${'aed'.tr()}?'),
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
              onPressed: () async {},
              child: const Text('yes').tr(),
            ),
          ],
        ),
      );
    }

    // ignore: unused_local_variable
    double screenWidth = MediaQuery.of(context).size.width;

    return BlocProvider(
      create: (context) => JoinBundleCubit(),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: AppTheme.accent7)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Text(
                  widget.bundle.name,
                  style: AppTheme.interBold,
                ),
              ),
            ),
            const Divider(
              color: AppTheme.accent7,
              height: 0,
              thickness: 1,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                child: Text(
                  widget.bundle.description,
                  style: AppTheme.interMedium,
                ),
              ),
            ),
            const Divider(
              color: AppTheme.accent7,
              height: 0,
              thickness: 1,
            ),
            BlocConsumer<JoinBundleCubit, JoinBundleState>(
              listener: (context, state) {
                if (state is JoinBundleFailure) {
                  AppTheme.showSnackBar(context, state.reason);
                }

                if (state is JoinBundleSuccess) {
                  AppTheme.showSnackBar(context,
                      '${widget.bundle.name} ${'joined_for_aed_you_will_be_contacted_for_payment'.tr()}');
                }
              },
              builder: (context, state) {
                if (state is JoinBundleInProgress) {
                  return Container(
                    padding: const EdgeInsets.all(8.0),
                    decoration: const BoxDecoration(
                        color: AppTheme.accent7,
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(8),
                            bottomRight: Radius.circular(8))),
                    child: const Center(
                      child: CupertinoActivityIndicator(),
                    ),
                  );
                }
                return GestureDetector(
                  onTap: () async {
                    if (Platform.isIOS) {
                      _showCupertinoLogoutDialog(widget.bundle);
                    }
                    bool answer = await _showMaterialDialog(widget.bundle);
                    if (answer) {
                      if (!mounted) return;
                      BlocProvider.of<JoinBundleCubit>(context)
                          .joinBundle(widget.bundle.id);
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.all(8.0),
                    decoration: const BoxDecoration(
                        color: AppTheme.accent7,
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(8),
                            bottomRight: Radius.circular(8))),
                    child: Center(
                      child: Text(
                        '${'join_for'.tr()} ${widget.bundle.price} ${'aed'.tr()}',
                        style: AppTheme.interBold.copyWith(color: Colors.white),
                      ),
                    ),
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:loavi_project/blocs/evacuation_order/evacuation_order_cubit.dart';
import 'package:loavi_project/blocs/get_buildings/get_buildings_cubit.dart';
import 'package:loavi_project/frontend/app_theme.dart';
import 'package:loavi_project/models/building_dart.dart';

class EvacuationScreen extends StatefulWidget {
  const EvacuationScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<EvacuationScreen> createState() => _EvacuationScreenState();
}

class _EvacuationScreenState extends State<EvacuationScreen> {
  DateTime _evacuationDate = DateTime.now();
  String? _chosenBuilding;
  String _roomNumber = '';
  String _reason = '';
  String _isFlatEmpty = 'yes';
  int _tenancyYears = 0;
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    String lang = context.locale.toString() == 'en'?'en':'ar';
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => EvacuationOrderCubit(),
        ),
        BlocProvider(
          create: (context) {
            GetBuildingsCubit c = GetBuildingsCubit();
            c.getBuildings(lang);
            return c;
          } ,
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          leading: BackButton(),
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: screenWidth * (20 / 375)),
            child: Column(children: [
              Center(
                  child: Image.asset(
                'assets/images/logo 2.png',
                width: screenWidth * (160 / 375),
              )),
              Text(
                'evacuation'.tr(),
                style: AppTheme.interBold
                    .copyWith(fontSize: 32, color: const Color(0xFF1A1D1F)),
              ),
              SizedBox(
                height: screenHeight * (36 / 812),
              ),
              Container(
                width: screenWidth,
                padding:
                    EdgeInsets.symmetric(vertical: screenHeight * (15 / 812)),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: const Color(0xFF1D194D)),
                child: Center(
                  child: Text(
                    'evacuation'.tr(),
                    style: AppTheme.interSemiBold
                        .copyWith(color: const Color(0xFFFFFFFF), fontSize: 15),
                  ),
                ),
              ),
              SizedBox(
                height: screenHeight * (36 / 812),
              ),
              Container(
                width: screenWidth,
                padding: EdgeInsets.only(left: screenWidth * (16 / 375)),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: const Color(0xFFCA3939))),
                child: BlocConsumer<GetBuildingsCubit, GetBuildingsState>(
                  listener: (context, state) {
                    // TODO: implement listener
                  },
                  builder: (context, state) {
                    if (state is GetBuildingsInProgress) {
                      return const Center(child: CupertinoActivityIndicator());
                    }
                    if (state is GetBuildingsSuccess) {
                      return DropdownButtonFormField<String>(
                        hint: Text('building_name'.tr(),
                            style: AppTheme.interMedium
                                .copyWith(color: const Color(0xFF1A1B2D))),
                        value: _chosenBuilding,
                        style: const TextStyle(color: Colors.black),
                        icon: const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 12),
                          child: Icon(Icons.keyboard_arrow_down),
                        ),
                        decoration:
                            const InputDecoration(border: InputBorder.none),
                        items: state.buildings
                            .map<DropdownMenuItem<String>>((Building value) {
                          return DropdownMenuItem<String>(
                            value: value.id,
                            child: Text(value.name),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            _chosenBuilding = value;
                          });
                        },
                      );
                    }
                    return Container();
                  },
                ),
              ),
              SizedBox(
                height: screenHeight * (36 / 812),
              ),
              Container(
                width: screenWidth,
                padding: EdgeInsets.only(left: screenWidth * (16 / 375)),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: const Color(0xFFCA3939))),
                child: TextField(
                  onChanged: (value) {
                    _roomNumber = value;
                  },
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(left: 10,right: 10),
                      border: InputBorder.none,
                      hintText: 'number_of_room'.tr(),
                      hintStyle: AppTheme.interMedium
                          .copyWith(color: const Color(0xFF1A1B2D))),
                ),
              ),
              SizedBox(
                height: screenHeight * (36 / 812),
              ),
              Text(
                'is_the_flat_empty'.tr(),
                style: AppTheme.interSemiBold.copyWith(
                  color: const Color(0xFF1A1D1F),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                   Text(
                    'yes'.tr(),
                    style: AppTheme.interSemiBold,
                  ),
                  Radio<String>(
                    activeColor: AppTheme.accent7,
                    value: 'yes'.tr(),
                    groupValue: _isFlatEmpty,
                    onChanged: (value) {
                      setState(() {
                        _isFlatEmpty = value!;
                      });
                    },
                  ),
                  SizedBox(
                    width: screenWidth * (30 / 375),
                  ),
                   Text(
                    'no'.tr(),
                    style: AppTheme.interSemiBold,
                  ),
                  Radio<String>(
                    activeColor: AppTheme.accent7,
                    value: 'no'.tr(),
                    groupValue: _isFlatEmpty,
                    onChanged: (value) {
                      setState(() {
                        _isFlatEmpty = value!;
                      });
                    },
                  ),
                ],
              ),
              SizedBox(
                height: screenHeight * (36 / 812),
              ),
              Container(
                height: screenHeight * (100 / 812),
                padding: EdgeInsets.only(left: screenWidth * (16 / 375)),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: const Color(0xFFCA3939))),
                child: TextField(
                  maxLines: null,
                  onChanged: (value) {
                    setState(() {
                      _reason = value;
                    });
                  },
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'reason'.tr(),
                      hintStyle: AppTheme.interMedium
                          .copyWith(color: const Color(0xFF1A1B2D))),
                ),
              ),
              SizedBox(
                height: screenHeight * (36 / 812),
              ),
              Container(
                width: screenWidth,
                padding: EdgeInsets.only(left: screenWidth * (16 / 375)),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: const Color(0xFFCA3939))),
                child: TextField(
                  onChanged: (value) {
                    _tenancyYears = int.parse(value);
                  },
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'tenancy_years'.tr(),
                      hintStyle: AppTheme.interMedium
                          .copyWith(color: const Color(0xFF1A1B2D))),
                ),
              ),
              SizedBox(
                height: screenHeight * (36 / 812),
              ),
              GestureDetector(
                onTap: () async {
                  _evacuationDate = (await showDatePicker(
                      builder: (context, child) {
                        return Theme(
                          data: ThemeData(
                            colorScheme: ColorScheme.light(
                              primary: AppTheme.accent7,
                            ),
                            //  dialogBackgroundColor: Theme.of(context).cardColor,
                          ),
                          child: child ?? const Text(''),
                        );
                      },
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate: DateTime.now().add(const Duration(days: 30))))!;
                  setState(() {

                  });
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
                        (_evacuationDate.isAfter(DateTime.now()))
                            ? _evacuationDate.toString().substring(0, 10)
                            : 'date_of_evacuation'.tr(),
                        style: AppTheme.interMedium
                            .copyWith(color: const Color(0xFF1A1B2D)),
                      ),
                      SvgPicture.asset('assets/images/dice.svg')
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: screenHeight * (57 / 812),
              ),
              BlocProvider(
                create: (context) => EvacuationOrderCubit(),
                child: BlocConsumer<EvacuationOrderCubit, EvacuationOrderState>(
                  listener: (context, state) {
                    if (state is EvacuationOrderSuccess) {
                      Navigator.pop(context);
                      AppTheme.showSnackBar(context, 'success'.tr());
                    }
                    if (state is EvacuationOrderFailure) {
                      Navigator.pop(context);
                      AppTheme.showSnackBar(
                          context, 'failure_please_try_again'.tr());
                    }
                  },
                  builder: (context, state) {
                    if (state is EvacuationOrderInProgress) {
                      return Container(
                        width: screenWidth,
                        padding: EdgeInsets.symmetric(
                            vertical: screenHeight * (20 / 812)),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: AppTheme.accent7),
                        child:
                            const Center(child: CupertinoActivityIndicator()),
                      );
                    }
                    return GestureDetector(
                      onTap: () {
                        if (_chosenBuilding == null) {
                          AppTheme.showSnackBar(
                              context, 'building_name_is_required'.tr());
                          return;
                        }
                        if (_roomNumber == '') {
                          AppTheme.showSnackBar(
                              context, 'room_number_is_required'.tr());
                          return;
                        }
                        if (_evacuationDate.isBefore(DateTime.now())) {
                          AppTheme.showSnackBar(
                              context, 'please_enter_a_correct_date'.tr());
                          return;
                        }
                        BlocProvider.of<EvacuationOrderCubit>(context)
                            .placeEvacuationOrder(
                                _evacuationDate,
                                int.parse(_chosenBuilding!),
                                _roomNumber,
                                _reason,
                                (_isFlatEmpty == 'yes') ? true : false,
                                _tenancyYears);
                      },
                      child: Container(
                        width: screenWidth,
                        padding: EdgeInsets.symmetric(
                            vertical: screenHeight * (20 / 812)),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: AppTheme.accent7),
                        child: Center(
                            child: Text(
                          'submit'.tr(),
                          style: AppTheme.interRegular
                              .copyWith(color: const Color(0xFFFFFFFF)),
                        )),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(
                height: screenHeight * (57 / 812),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}

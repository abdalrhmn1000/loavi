import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loavi_project/blocs/get_buildings/get_buildings_cubit.dart';
import 'package:loavi_project/frontend/app_theme.dart';
import 'package:loavi_project/frontend/screens/bundles_screen.dart';
import 'package:loavi_project/frontend/screens/maintenance_order_screen.dart';
import 'package:loavi_project/models/building_dart.dart';
import 'package:loavi_project/models/category.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class CustomerCheckScreen extends StatefulWidget {
  final Category category;
  const CustomerCheckScreen({Key? key, required this.category})
      : super(key: key);

  @override
  State<CustomerCheckScreen> createState() => _CustomerCheckScreenState();
}

class _CustomerCheckScreenState extends State<CustomerCheckScreen> {
  String tenant = '';
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    // ignore: unused_local_variable
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.category.name),
        centerTitle: true,
        leading: BackButton(),
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(top: 20),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: const Color(0xFFFFFFFF)),
                  padding: EdgeInsets.symmetric(
                      horizontal: screenWidth * (24 / 375)),
                  child: Column(children: [
                    Row(
                      children: [
                        Container(
                          width: 4,
                          height: 20,
                          decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(4)),
                          child: const Text(''),
                        ),
                        SizedBox(
                          width: screenWidth * (10 / 375),
                        ),
                        Expanded(
                          child: Text(
                            'Are_you_one_of_real_estate_tenants'.tr(),
                            style: AppTheme.interSemiBold.copyWith(
                              color: const Color(0xFF1A1D1F),
                            ),
                          ),
                        ),
                      ],
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
                          groupValue: tenant,
                          onChanged: (value) {
                            setState(() {
                              tenant = value!;
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
                          groupValue: tenant,
                          onChanged: (value) {
                            setState(() {
                              tenant = value!;
                            });
                          },
                        ),
                      ],
                    ),
                    Builder(builder: (context) {
                      if (tenant == 'yes'.tr()) {
                        return TenantCheckForm(
                          category: widget.category,
                        );
                      } else if (tenant == 'no'.tr()) {
                        return NonTenantCheckForm(
                          category: widget.category,
                        );
                      }
                      return Container();
                    })
                  ]),
                )
              ]),
        ),
      ),
    );
  }
}

class TenantCheckForm extends StatefulWidget {
  final Category category;
  const TenantCheckForm({Key? key, required this.category}) : super(key: key);

  @override
  State<TenantCheckForm> createState() => _TenantCheckFormState();
}

class _TenantCheckFormState extends State<TenantCheckForm> {
  Building? _chosenBuilding;
  String _roomNumber = '';
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    String lang = context.locale.toString() == 'en'?'en':'ar';
    return BlocProvider(
      create: (context) => GetBuildingsCubit()..getBuildings(lang),
      child: Column(
        children: [
          SizedBox(
            height: screenHeight * (20 / 812),
          ),
          Container(
            width: screenWidth,
            padding: EdgeInsets.only(left: screenWidth * (16 / 375)),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: const Color(0xFFCA3939))),
            child: BlocConsumer<GetBuildingsCubit, GetBuildingsState>(
              listener: (context, state) {
                if (state is GetBuildingsFailure) {
                  AppTheme.showSnackBar(context, 'Error loading buildings!');
                }
              },
              builder: (context, state) {
                if (state is GetBuildingsInProgress) {
                  return const Center(child: CupertinoActivityIndicator());
                }
                if (state is GetBuildingsSuccess) {
                  return DropdownButtonFormField<Building>(
                    hint: Text('Building Name',
                        style: AppTheme.interMedium
                            .copyWith(color: const Color(0xFF1A1B2D))),
                    value: _chosenBuilding,
                    style: const TextStyle(color: Colors.black),
                    icon: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12),
                      child: Icon(Icons.keyboard_arrow_down),
                    ),
                    decoration: const InputDecoration(border: InputBorder.none),
                    items: state.buildings
                        .map<DropdownMenuItem<Building>>((Building value) {
                      return DropdownMenuItem<Building>(
                        value: value,
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
            height: screenHeight * (20 / 812),
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
                  border: InputBorder.none,
                  hintText: 'Room number',
                  hintStyle: AppTheme.interMedium
                      .copyWith(color: const Color(0xFF1A1B2D))),
            ),
          ),
          SizedBox(
            height: screenHeight * (44 / 812),
          ),
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    padding: EdgeInsets.only(
                        top: screenHeight * (15 / 812),
                        bottom: screenHeight * (15 / 812)),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                            width: 2, color: const Color(0xFFEFEFEF))),
                    child: Center(
                        child: Text(
                      'Discard',
                      style: AppTheme.interBold.copyWith(color: Colors.black),
                    )),
                  ),
                ),
              ),
              SizedBox(
                width: screenWidth * (8 / 375),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    if (_chosenBuilding == null) {
                      AppTheme.showSnackBar(
                          context, 'Building Name is required!');
                      return;
                    }
                    if (_roomNumber == '') {
                      AppTheme.showSnackBar(
                          context, 'Room Number is required!');
                      return;
                    }
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MaintenanceOrderScreen(
                                  category: widget.category,
                                  isTenant: true,
                                  roomNumber: _roomNumber,
                                  buildingId: _chosenBuilding!.id,
                                  address: '',
                                )));
                  },
                  child: Container(
                    padding: EdgeInsets.only(
                        top: screenHeight * (15 / 812),
                        bottom: screenHeight * (15 / 812)),
                    decoration: BoxDecoration(
                        color: AppTheme.accent7,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                            width: 2, color: const Color(0xFFEFEFEF))),
                    child: Center(
                        child: Text(
                      'Continue',
                      style: AppTheme.interBold
                          .copyWith(color: const Color(0xFFFFFFFF)),
                    )),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class NonTenantCheckForm extends StatefulWidget {
  final Category category;

  const NonTenantCheckForm({Key? key, required this.category})
      : super(key: key);

  @override
  State<NonTenantCheckForm> createState() => _NonTenantCheckFormState();
}

class _NonTenantCheckFormState extends State<NonTenantCheckForm> {
  String contract = 'no';
  String contractId = '';
  String address = '';
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Column(
      children: [
        Row(
          children: [
            Container(
              width: 4,
              height: 20,
              decoration: BoxDecoration(
                  color: Colors.black, borderRadius: BorderRadius.circular(4)),
              child: const Text(''),
            ),
            SizedBox(
              width: screenWidth * (10 / 375),
            ),
            Text(
              'Do you have a contract? ',
              style: AppTheme.interSemiBold.copyWith(
                color: const Color(0xFF1A1D1F),
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Yes',
              style: AppTheme.interSemiBold,
            ),
            Radio<String>(
              activeColor: AppTheme.accent7,
              value: 'yes',
              groupValue: contract,
              onChanged: (value) {
                setState(() {
                  contract = value!;
                });
              },
            ),
            SizedBox(
              width: screenWidth * (30 / 375),
            ),
            const Text(
              'No',
              style: AppTheme.interSemiBold,
            ),
            Radio<String>(
              activeColor: AppTheme.accent7,
              value: 'no',
              groupValue: contract,
              onChanged: (value) {
                setState(() {
                  contract = value!;
                });
              },
            ),
          ],
        ),
        Builder(builder: (context) {
          if (contract == 'yes') {
            return Column(
              children: [
                Container(
                  width: screenWidth,
                  padding: EdgeInsets.only(left: screenWidth * (16 / 375)),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: const Color(0xFFCA3939))),
                  child: TextField(
                    onChanged: (value) {
                      contractId = value;
                    },
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Contract ID',
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
                      address = value;
                    },
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Address',
                        hintStyle: AppTheme.interMedium
                            .copyWith(color: const Color(0xFF1A1B2D))),
                  ),
                ),
                SizedBox(
                  height: screenHeight * (44 / 812),
                ),
                Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          padding: EdgeInsets.only(
                              top: screenHeight * (15 / 812),
                              bottom: screenHeight * (15 / 812)),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                  width: 2, color: const Color(0xFFEFEFEF))),
                          child: Center(
                              child: Text(
                            'Discard',
                            style: AppTheme.interBold
                                .copyWith(color: Colors.black),
                          )),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: screenWidth * (8 / 375),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () async {
                          if (contractId == '') {
                            AppTheme.showSnackBar(
                                context, 'Contract ID is required!');
                            return;
                          }
                          if (address == '') {
                            AppTheme.showSnackBar(
                                context, 'Address is required!');
                            return;
                          }
                          SharedPreferences localStorage =
                              await SharedPreferences.getInstance();
                          var loginToken = localStorage.get('token');
                          var response = await http.post(
                            Uri.parse(
                              'https://Skygulfapp.gulfsky-app.website/api/user/checkContract?contract_id=$contractId',
                            ),
                            headers: {
                              'Content-type': 'application/json',
                              'Accept': 'application/json',
                              'Authorization': 'Bearer $loginToken'
                            },
                          );
                          if (response.body == 'false') {
                            if (!mounted) return;

                            AppTheme.showSnackBar(context,
                                'Contract ID doesn\'t match credentials!');
                            return;
                          }
                          if (!mounted) return;
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MaintenanceOrderScreen(
                                        category: widget.category,
                                        isTenant: false,
                                        roomNumber: '',
                                        buildingId: '',
                                        address: address,
                                      )));
                        },
                        child: Container(
                          padding: EdgeInsets.only(
                              top: screenHeight * (15 / 812),
                              bottom: screenHeight * (15 / 812)),
                          decoration: BoxDecoration(
                              color: AppTheme.accent7,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                  width: 2, color: const Color(0xFFEFEFEF))),
                          child: Center(
                              child: Text(
                            'Continue',
                            style: AppTheme.interBold
                                .copyWith(color: const Color(0xFFFFFFFF)),
                          )),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            );
          }
          return Column(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => BundlesScreen()));
                },
                child: Container(
                  margin: EdgeInsets.only(bottom: screenHeight * (22 / 812)),
                  padding:
                      EdgeInsets.symmetric(vertical: screenHeight * (32 / 812)),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: AppTheme.accent7,
                  ),
                  child: Center(
                      child: Text(
                    'Join Gulf Sky Packages & Bundles',
                    textAlign: TextAlign.center,
                    style: AppTheme.interBold
                        .copyWith(color: const Color(0xFFFFFFFF), fontSize: 20),
                  )),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MaintenanceOrderScreen(
                              category: widget.category,
                              address: address,
                              buildingId: '',
                              isTenant: false,
                              roomNumber: '')));
                },
                child: Container(
                  margin: EdgeInsets.only(bottom: screenHeight * (22 / 812)),
                  padding:
                      EdgeInsets.symmetric(vertical: screenHeight * (32 / 812)),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: AppTheme.accent7,
                  ),
                  child: Center(
                      child: Text(
                    'One Time Order',
                    textAlign: TextAlign.center,
                    style: AppTheme.interBold
                        .copyWith(color: const Color(0xFFFFFFFF), fontSize: 20),
                  )),
                ),
              ),
            ],
          );
        })
      ],
    );
  }
}

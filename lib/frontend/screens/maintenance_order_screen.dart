import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loavi_project/blocs/place_order/place_order_cubit.dart';
import 'package:loavi_project/blocs/service_categories/get_service_categories_cubit.dart';
import 'package:loavi_project/blocs/sub_services/get_sub_services_cubit.dart';
import 'package:loavi_project/frontend/app_theme.dart';
import 'package:loavi_project/models/category.dart';
import 'package:loavi_project/models/service.dart';
import 'package:loavi_project/models/sub_service.dart';

class MaintenanceOrderScreen extends StatefulWidget {
  final Category category;
  final bool isTenant;
  final String address;
  final String buildingId;
  final String roomNumber;

  const MaintenanceOrderScreen(
      {Key? key,
      required this.category,
      required this.address,
      required this.buildingId,
      required this.isTenant,
      required this.roomNumber})
      : super(key: key);

  @override
  State<MaintenanceOrderScreen> createState() => _MaintenanceOrderScreenState();
}

class _MaintenanceOrderScreenState extends State<MaintenanceOrderScreen> {
  CategoryService? _chosenService;
  SubService? _chosenSubService;
  String name = '';
  String phone = '';

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => GetServiceCategoriesCubit()
            ..getServiceCategories(widget.category.id),
        ),
        BlocProvider(
          create: (context) => GetSubServicesCubit(),
        )
      ],
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: screenWidth * (24 / 375)),
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
                  height: screenHeight * (20 / 812),
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
                      widget.category.name,
                      style: AppTheme.interSemiBold.copyWith(
                          color: const Color(0xFFFFFFFF), fontSize: 15),
                    ),
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
                  child: BlocConsumer<GetServiceCategoriesCubit,
                      GetServiceCategoriesState>(
                    listener: (context, state) {
                      if (state is GetServiceCategoriesFailure) {
                        AppTheme.showSnackBar(
                            context, 'error_loading_category_services'.tr());
                      }
                    },
                    builder: (context, state) {
                      if (state is GetServiceCategoriesInProgress) {
                        return const Center(
                            child: CupertinoActivityIndicator());
                      }
                      if (state is GetServiceCategoriesSuccess) {
                        return Column(
                          children: [
                            DropdownButtonFormField<CategoryService>(
                              hint: Text('service'.tr(),
                                  style: AppTheme.interMedium.copyWith(
                                      color: const Color(0xFF1A1B2D))),
                              value: _chosenService,
                              style: const TextStyle(color: Colors.black),
                              icon: const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 12),
                                child: Icon(Icons.keyboard_arrow_down),
                              ),
                              decoration: const InputDecoration(
                                  border: InputBorder.none),
                              items: state.services
                                  .map<DropdownMenuItem<CategoryService>>(
                                      (CategoryService value) {
                                return DropdownMenuItem<CategoryService>(
                                  value: value,
                                  child: Text(value.name),
                                );
                              }).toList(),
                              onChanged: (value) {
                                setState(() {
                                  _chosenService = value;
                                });
                                BlocProvider.of<GetSubServicesCubit>(context)
                                    .getSubServices(_chosenService!.id);
                              },
                            ),
                          ],
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
                  child: BlocConsumer<GetSubServicesCubit, GetSubServicesState>(
                    listener: (context, state1) {
                      if (state1 is GetSubServicesFailure) {
                        AppTheme.showSnackBar(
                            context, 'error_loading_category_services'.tr());
                      }
                    },
                    builder: (context, state1) {
                      if (state1 is GetSubServicesInProgress) {
                        return const Center(
                            child: CupertinoActivityIndicator());
                      }
                      if (state1 is GetSubServicesSuccess) {
                        return DropdownButtonFormField<SubService>(
                          hint: Text('sub_service'.tr(),
                              style: AppTheme.interMedium
                                  .copyWith(color: const Color(0xFF1A1B2D))),
                          value: _chosenSubService,
                          style: const TextStyle(color: Colors.black),
                          icon: const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 12),
                            child: Icon(Icons.keyboard_arrow_down),
                          ),
                          decoration:
                              const InputDecoration(border: InputBorder.none),
                          items: state1.subServices
                              .map<DropdownMenuItem<SubService>>(
                                  (SubService value) {
                            return DropdownMenuItem<SubService>(
                              value: value,
                              child: Text(value.name),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              _chosenSubService = value;
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
                BlocProvider(
                  create: (context) => PlaceOrderCubit(),
                  child: BlocConsumer<PlaceOrderCubit, PlaceOrderState>(
                    listener: (context, state) {
                      if (state is PlaceOrderFailure) {
                        AppTheme.showSnackBar(context, 'error_placing_order'.tr());
                      }
                      if (state is PlaceOrderSuccess) {
                        AppTheme.showSnackBar(context, 'success'.tr());
                      }
                    },
                    builder: (context, state) {
                      if (state is PlaceOrderInProgress) {
                        return Row(
                          children: [
                            Expanded(
                              child: Container(
                                padding: EdgeInsets.only(
                                    top: screenHeight * (15 / 812),
                                    bottom: screenHeight * (15 / 812)),
                                decoration: BoxDecoration(
                                    color: const Color(0xFF6759FF),
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(
                                        width: 2,
                                        color: const Color(0xFFEFEFEF))),
                                child: const Center(
                                    child: CupertinoActivityIndicator()),
                              ),
                            ),
                          ],
                        );
                      }
                      return GestureDetector(
                        onTap: () {
                          if (_chosenSubService == null) print('object');
                          if (widget.isTenant) {
                            BlocProvider.of<PlaceOrderCubit>(context)
                                .placeOrder(
                                    widget.isTenant,
                                    name,
                                    widget.address,
                                    phone,
                                    widget.buildingId,
                                    widget.roomNumber,
                                    _chosenService!.id,
                                    (_chosenSubService == null)
                                        ? null
                                        : int.parse(_chosenSubService!.id));
                            return;
                          }
                          BlocProvider.of<PlaceOrderCubit>(context).placeOrder(
                              false,
                              name,
                              widget.address,
                              phone,
                              widget.buildingId,
                              widget.roomNumber,
                              _chosenService!.id,
                              (_chosenSubService == null)
                                  ? null
                                  : int.parse(_chosenSubService!.id));
                        },
                        child: Row(
                          children: [
                            Expanded(
                              child: Container(
                                padding: EdgeInsets.only(
                                    top: screenHeight * (15 / 812),
                                    bottom: screenHeight * (15 / 812)),
                                decoration: BoxDecoration(
                                    color: const Color(0xFF6759FF),
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(
                                        width: 2,
                                        color: const Color(0xFFEFEFEF))),
                                child: Center(
                                    child: Text(
                                  'book_now'.tr(),
                                  style: AppTheme.interBold
                                      .copyWith(color: const Color(0xFFFFFFFF)),
                                )),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(
                  height: screenHeight * (27 / 812),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'dart:developer';

import 'package:aqua_green/core/colors.dart';
import 'package:aqua_green/core/constants.dart';
import 'package:aqua_green/core/responsive_utils.dart';
import 'package:aqua_green/data/area_model.dart';
import 'package:aqua_green/data/route_model.dart';
import 'package:aqua_green/data/unit_model.dart';
import 'package:aqua_green/presentation/blocs/bottom_navigation_bloc/bottom_navigation_bloc.dart';

import 'package:aqua_green/presentation/blocs/fetch_area/fetch_area_bloc.dart';
import 'package:aqua_green/presentation/blocs/fetch_route/fetch_route_bloc.dart';
import 'package:aqua_green/presentation/blocs/fetch_unit/fetch_unit_bloc.dart';
import 'package:aqua_green/presentation/blocs/update_unit/update_units_bloc.dart';
import 'package:aqua_green/presentation/screens/screen_measurepage/widgets/location_class.dart';

import 'package:aqua_green/presentation/screens/screen_updateunits/widgets/disabledropdownbutton.dart';
import 'package:aqua_green/presentation/widgets/custom_drawer.dart';
import 'package:aqua_green/presentation/widgets/custom_snackbar.dart';
import 'package:aqua_green/presentation/widgets/custom_submitbutton.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:geolocator/geolocator.dart';

class ScreenUpdateUnits extends StatefulWidget {
  const ScreenUpdateUnits({super.key});

  @override
  State<ScreenUpdateUnits> createState() => _ScreenUpdateUnitsState();
}

class _ScreenUpdateUnitsState extends State<ScreenUpdateUnits> {
  final TextEditingController routeController = TextEditingController();
  final TextEditingController areaController = TextEditingController();
  final TextEditingController unitController = TextEditingController();

  String? selectedRoute;
  String? selectedArea;
  String? selectedUnit;
  AreaModel? selectedAreaModel;
  UnitModel? selectedUnitModel;
  bool isloading = false;
  bool isLocked = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<FetchRouteBloc>().add(FetchRouteInitialEvent());
    context.read<FetchAreaBloc>().add(FetchAreaInitialEvent());
    context.read<FetchUnitBloc>().add(FetchUnitInitialEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Builder(builder: (context) {
          return IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          );
        }),
        centerTitle: true,
        title: TextStyles.body(
            weight: FontWeight.bold,
            text: 'Update Units',
            color: Appcolors.kprimarycolor),
      ),
      drawer: const CustomDrawer(),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(ResponsiveUtils.wp(4)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextStyles.medium(
                text: 'Route',
                weight: FontWeight.bold,
                color: Appcolors.kdarkbluecolor),
            ResponsiveSizedBox.height5,
            BlocBuilder<FetchRouteBloc, FetchRouteState>(
              builder: (context, state) {
                if (state is FetchRouteLoadingState) {
                  return Container(
                    height: ResponsiveUtils.hp(6),
                    width: ResponsiveUtils.screenWidth,
                    decoration: BoxDecoration(
                        border: Border.all(
                            width: .5, color: Appcolors.kprimarycolor)),
                    child: Center(
                        child: SpinKitWave(
                      color: Appcolors.kprimarycolor,
                      size: ResponsiveUtils.wp(4),
                    )),
                  );
                } else if (state is FetchRouteSuccessState) {
                  return DropdownButtonFormField2<RouteModel>(
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.symmetric(vertical: 5),
                      filled: true,
                      fillColor: Appcolors.kwhiteColor,
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Appcolors.kprimarycolor, width: 0.5),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Appcolors.kprimarycolor, width: 1.5),
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Appcolors.kprimarycolor, width: 0.5),
                      ),
                    ),
                    hint: TextStyles.caption(
                        text: 'Select Route', color: Appcolors.kdarkbluecolor),
                    items: state.routes
                        .map((route) => DropdownMenuItem<RouteModel>(
                              value: route,
                              child: TextStyles.caption(
                                  text: route.routeName,
                                  color: Appcolors.kdarkbluecolor),
                            ))
                        .toList(),
                    onChanged: (RouteModel? route) {
                      setState(() {
                        selectedRoute = route?.routeName;
                        selectedArea = null;
                        selectedAreaModel = null;
                        areaController.clear();
                        selectedUnit = null;
                        selectedUnitModel = null;
                        unitController.clear();
                        if (route != null) {
                          routeController.text = route.routeId;
                          log(routeController.text);
                          // Fetch areas for selected route
                          context.read<FetchAreaBloc>().add(
                              FetchAreaWithRouteId(routeId: route.routeId));
                        }
                      });
                    },
                    buttonStyleData: const ButtonStyleData(),
                    dropdownStyleData: DropdownStyleData(
                      maxHeight: ResponsiveUtils.hp(50),
                      decoration: BoxDecoration(
                        color: Appcolors.kwhiteColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    menuItemStyleData: MenuItemStyleData(
                      height: ResponsiveUtils.hp(5.7),
                    ),
                  );
                } else if (state is FetchRouteErrorState) {
                  return Container(
                    height: ResponsiveUtils.hp(6),
                    width: ResponsiveUtils.screenWidth,
                    decoration: BoxDecoration(
                        color: Appcolors.kwhiteColor,
                        border: Border.all(
                            width: .5, color: Appcolors.kprimarycolor)),
                    child: Center(
                        child: TextStyles.caption(
                            text: state.message, color: Appcolors.kredColor)),
                  );
                } else {
                  return SizedBox.shrink();
                }
              },
            ),
            ResponsiveSizedBox.height20,
            TextStyles.medium(
                text: 'Area',
                weight: FontWeight.bold,
                color: Appcolors.kdarkbluecolor),
            ResponsiveSizedBox.height5,
            BlocBuilder<FetchAreaBloc, FetchAreaState>(
              builder: (context, state) {
                if (selectedRoute == null) {
                  return DisabledDropdown(hintText: 'Select route first');
                }
                if (state is FetchAreaLoadingState) {
                  return Container(
                    height: ResponsiveUtils.hp(6),
                    width: ResponsiveUtils.screenWidth,
                    decoration: BoxDecoration(
                        border: Border.all(
                            width: .5, color: Appcolors.kprimarycolor)),
                    child: Center(
                        child: SpinKitWave(
                      color: Appcolors.kprimarycolor,
                      size: ResponsiveUtils.wp(6),
                    )),
                  );
                }
                if (state is FetchAreaWithRouteIdSuccessState) {
                  if (state.areas.isEmpty) {
                    return DisabledDropdown(hintText: 'No areas Available');
                  }
                  return DropdownButtonFormField2<AreaModel>(
                    value: selectedAreaModel,
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.symmetric(vertical: 5),
                      filled: true,
                      fillColor: Appcolors.kwhiteColor,
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Appcolors.kprimarycolor, width: 0.5),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Appcolors.kprimarycolor, width: 1.5),
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Appcolors.kprimarycolor, width: 0.5),
                      ),
                    ),
                    hint: TextStyles.caption(
                        text: 'Select Area', color: Appcolors.kdarkbluecolor),
                    items: state.areas
                        .map((area) => DropdownMenuItem<AreaModel>(
                              value: area,
                              child: TextStyles.caption(
                                  text: area.areaName,
                                  color: Appcolors.kdarkbluecolor),
                            ))
                        .toList(),
                    onChanged: (AreaModel? area) {
                      setState(() {
                        selectedAreaModel = area;
                        selectedArea = area?.areaName;
                        selectedUnit = null;
                        selectedUnitModel = null;
                        unitController.clear();
                        if (area != null) {
                          areaController.text = area.areaId;
                          context.read<FetchUnitBloc>().add(
                              FetchUnitWithRouteIdandAreaId(
                                  routeId: area.routeId, areaId: area.areaId));
                        } else {
                          areaController.clear();
                        }
                      });
                    },
                    buttonStyleData: const ButtonStyleData(),
                    dropdownStyleData: DropdownStyleData(
                      maxHeight: ResponsiveUtils.hp(50),
                      decoration: BoxDecoration(
                        color: Appcolors.kwhiteColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    menuItemStyleData: MenuItemStyleData(
                      height: ResponsiveUtils.hp(5.7),
                    ),
                  );
                } else if (state is FetchAreaErrorState) {
                  return Container(
                    height: ResponsiveUtils.hp(6),
                    width: ResponsiveUtils.screenWidth,
                    decoration: BoxDecoration(
                        color: Appcolors.kwhiteColor,
                        border: Border.all(
                            width: .5, color: Appcolors.kprimarycolor)),
                    child: Center(
                        child: TextStyles.caption(
                            text: state.message, color: Appcolors.kredColor)),
                  );
                } else {
                  return SizedBox.shrink();
                }
              },
            ),
            ResponsiveSizedBox.height20,
            TextStyles.medium(
                text: 'Unit',
                weight: FontWeight.bold,
                color: Appcolors.kdarkbluecolor),
            ResponsiveSizedBox.height5,
            BlocBuilder<FetchUnitBloc, FetchUnitState>(
              builder: (context, state) {
                if (selectedRoute == null || selectedArea == null) {
                  return DisabledDropdown(
                      hintText: 'Select route and area first');
                }
                if (state is FetchUnitLoadingState) {
                  return Container(
                    height: ResponsiveUtils.hp(6),
                    width: ResponsiveUtils.screenWidth,
                    decoration: BoxDecoration(
                        border: Border.all(
                            width: .5, color: Appcolors.kprimarycolor)),
                    child: Center(
                        child: SpinKitWave(
                      color: Appcolors.kprimarycolor,
                      size: ResponsiveUtils.wp(6),
                    )),
                  );
                }
                if (state is FetchUnitWithRouteIdandAreaIdSuccessState) {
                  if (state.units.isEmpty) {
                    return DisabledDropdown(hintText: 'No units Available');
                  }
                  return DropdownButtonFormField2<UnitModel>(
                    value: selectedUnitModel,
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.symmetric(vertical: 5),
                      filled: true,
                      fillColor: Appcolors.kwhiteColor,
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Appcolors.kprimarycolor, width: 0.5),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Appcolors.kprimarycolor, width: 1.5),
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Appcolors.kprimarycolor, width: 0.5),
                      ),
                    ),
                    hint: TextStyles.caption(
                        text: 'Select Unit', color: Appcolors.kdarkbluecolor),
                    items: state.units
                        .map((unit) => DropdownMenuItem<UnitModel>(
                              value: unit,
                              child: TextStyles.caption(
                                  text: unit.unitName,
                                  color: Appcolors.kdarkbluecolor),
                            ))
                        .toList(),
                    onChanged: (UnitModel? unit) {
                      setState(() {
                        selectedUnitModel = unit;
                        selectedUnit = unit?.unitName;
                        if (unit != null) {
                          unitController.text = unit.unitId;
                        } else {
                          unitController.clear();
                        }
                      });
                    },
                    buttonStyleData: const ButtonStyleData(),
                    dropdownStyleData: DropdownStyleData(
                      maxHeight: ResponsiveUtils.hp(50),
                      decoration: BoxDecoration(
                        color: Appcolors.kwhiteColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    menuItemStyleData: MenuItemStyleData(
                      height: ResponsiveUtils.hp(5.7),
                    ),
                  );
                } else if (state is FetchUnitErrorState) {
                  return Container(
                    height: ResponsiveUtils.hp(6),
                    width: ResponsiveUtils.screenWidth,
                    decoration: BoxDecoration(
                        color: Appcolors.kwhiteColor,
                        border: Border.all(
                            width: .5, color: Appcolors.kprimarycolor)),
                    child: Center(
                        child: TextStyles.caption(
                            text: state.message, color: Appcolors.kredColor)),
                  );
                } else {
                  return SizedBox.shrink();
                }
              },
            ),
            ResponsiveSizedBox.height30,
            BlocConsumer<UpdateUnitsBloc, UpdateUnitsState>(
              listener: (context, state) {
                if (state is UpdateUnitSuccessState) {
                  setState(() {
                    isloading = false;
                    selectedRoute = null;
                    selectedArea = null;
                    selectedUnit = null;
                    selectedAreaModel = null;
                    selectedUnitModel = null;

                    // Clear all controllers
                    unitController.clear();
                    areaController.clear();
                    routeController.clear();
                  });
                                            context.read<BottomNavigationBloc>().add(
                            LockNavigationEvent(isLocked: isLocked = false));
                  CustomSnackBar.show(
                      context: context,
                      title: 'Success',
                      message: state.message,
                      contentType: ContentType.success);
                } else if (state is UpdateUnitErrorState) {
                  setState(() {
                    isloading = false;
                  });
                                          context.read<BottomNavigationBloc>().add(
                            LockNavigationEvent(isLocked: isLocked = false));
                  CustomSnackBar.show(
                      context: context,
                      title: 'Error!!',
                      message: state.message,
                      contentType: ContentType.failure);
                }
              },
              builder: (context, state) {
                if (state is UpdateUnitLoadingState || isloading) {
                  return Container(
                    height: ResponsiveUtils.hp(6),
                    width: ResponsiveUtils.screenWidth,
                    color: Appcolors.kprimarycolor,
                    child: Center(
                        child: SpinKitWave(
                      color: Appcolors.kwhiteColor,
                      size: ResponsiveUtils.wp(6),
                    )),
                  );
                }
                return SubmitButton(
                    ontap: () async {
                      if (unitController.text.isNotEmpty) {
                        setState(() {
                          isloading = true;
                        });
                        context.read<BottomNavigationBloc>().add(
                            LockNavigationEvent(isLocked: isLocked = true));
                        try {
                          Position currentlocation =
                              await LocationService().getCurrentLocation();
                          context.read<UpdateUnitsBloc>().add(
                              UpdateUnitButtonclickEvent(
                                  unitId: unitController.text,
                                  lattitude:
                                      currentlocation.latitude.toString(),
                                  longitude:
                                      currentlocation.longitude.toString()));
                        } catch (e) {
                          setState(() {
                            isloading = false;
                          });
                                                  context.read<BottomNavigationBloc>().add(
                            LockNavigationEvent(isLocked: isLocked = false));
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                  'Error processing images: ${e.toString()}'),
                              backgroundColor: Colors.red,
                            ),
                          );
                        }
                      } else {
                        CustomSnackBar.show(
                            context: context,
                            title: 'Error!!',
                            message: 'Fill all fields',
                            contentType: ContentType.failure);
                      }
                    },
                    text: 'Update location');
              },
            )
          ],
        ),
      ),
    );
  }
}

import 'package:aqua_green/core/colors.dart';
import 'package:aqua_green/core/constants.dart';
import 'package:aqua_green/core/responsive_utils.dart';
import 'package:aqua_green/data/plant_datamodel.dart';
import 'package:aqua_green/data/reports.dart';
import 'package:aqua_green/domain/repositories/measurments_repo.dart';
import 'package:aqua_green/presentation/blocs/fetch_report_offline/fetch_report_offline_bloc.dart';
import 'package:aqua_green/presentation/blocs/fetch_reportbloc/fetch_report_bloc.dart';

import 'package:aqua_green/presentation/widgets/custom_drawer.dart';
import 'package:aqua_green/presentation/widgets/custom_largetextwidget.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';

// class ScreenReportpage extends StatefulWidget {
//   const ScreenReportpage({super.key});

//   @override
//   State<ScreenReportpage> createState() => _ScreenReportpageState();
// }

// class _ScreenReportpageState extends State<ScreenReportpage> {
//   int? expandedIndex; // Track which item is expanded
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     context.read<FetchReportBloc>().add(FetchReportInitialEvent());
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         leading: Builder(builder: (context) {
//           return IconButton(
//             icon: const Icon(Icons.menu),
//             onPressed: () {
//               Scaffold.of(context).openDrawer();
//             },
//           );
//         }),
//         centerTitle: true,
//         title: TextStyles.body(
//             weight: FontWeight.bold,
//             text: 'View Report',
//             color: Appcolors.kprimarycolor),
//       ),
//       drawer: const CustomDrawer(),
//       body: BlocBuilder<FetchReportBloc, FetchReportState>(
//         builder: (context, state) {
//           if (state is FetchReportLoadingState) {
//             return const Center(
//               child: SpinKitWaveSpinner(color: Appcolors.kprimarycolor),
//             );
//           } else if (state is FetchReportSuccessState) {
//             return ListView.builder(
//               itemCount: state.reports.length,
//               itemBuilder: (context, index) {
//                 final report = state.reports[index];
//                 bool isExpanded = expandedIndex == index;

//                 return Padding(
//                   padding: EdgeInsets.only(
//                       left: ResponsiveUtils.wp(4),
//                       right: ResponsiveUtils.wp(4),
//                       top: ResponsiveUtils.wp(4)),
//                   child: InkWell(
//                     onTap: () {
//                       setState(() {
//                         expandedIndex = isExpanded ? null : index;
//                       });
//                     },
//                     child: Container(
//                         color: Colors.white,
//                         child: Column(
//                           children: [
//                             // Existing content
//                             Padding(
//                               padding: const EdgeInsets.all(15),
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Row(
//                                     mainAxisAlignment:
//                                         MainAxisAlignment.spaceBetween,
//                                     children: [
//                                       Expanded(
//                                         child: Container(
//                                           padding: EdgeInsets.all(
//                                               ResponsiveUtils.wp(1.5)),
//                                           decoration: BoxDecoration(
//                                               color: Appcolors.kprimarycolor
//                                                   .withOpacity(.1)),
//                                           child: Text(
//                                             'Area : ${report.areaName}',
//                                             style: TextStyle(
//                                                 fontWeight: FontWeight.w600,
//                                                 color: Appcolors.kblackColor,
//                                                 fontSize: 12),
//                                             maxLines: 2,
//                                             overflow: TextOverflow.ellipsis,
//                                             textAlign: TextAlign.start,
//                                           ),
//                                         ),
//                                       ),
//                                       ResponsiveSizedBox.width50,
//                                       ResponsiveSizedBox.width10,
//                                       Container(
//                                         decoration: BoxDecoration(
//                                             color: Appcolors.kprimarycolor
//                                                 .withOpacity(.1)),
//                                         child: Padding(
//                                           padding: EdgeInsets.symmetric(
//                                               horizontal: ResponsiveUtils.wp(3),
//                                               vertical:
//                                                   ResponsiveUtils.wp(1.5)),
//                                           child: Text(
//                                             'Root : ${report.routeName}',
//                                             style: TextStyle(
//                                                 fontWeight: FontWeight.w600,
//                                                 color: Appcolors.kblackColor,
//                                                 fontSize: 12),
//                                             maxLines: 2,
//                                             overflow: TextOverflow.ellipsis,
//                                             textAlign: TextAlign.start,
//                                           ),
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                   ResponsiveSizedBox.height20,
//                                   ResponsiveSizedBox.height5,
//                                   Row(
//                                     children: [
//                                       TextStyles.caption(
//                                           text:
//                                               'Date  : ${DateFormat('dd-MM-yyyy').format(DateTime.parse(report.createdAt!.date!))}',
//                                           color: Appcolors.kblackColor,
//                                           weight: FontWeight.bold),
//                                       const Spacer(),
//                                       TextStyles.caption(
//                                           text: 'Status :',
//                                           color: Appcolors.kblackColor,
//                                           weight: FontWeight.bold),
//                                       ResponsiveSizedBox.width10,

//                                       Container(
//                                         decoration: BoxDecoration(
//                                             color:report.status=='APPROVED' ? Appcolors.kgreenColor
//                                                 .withOpacity(.6): Appcolors.kredColor) ,
//                                         child: Padding(
//                                           padding: EdgeInsets.symmetric(
//                                             horizontal: ResponsiveUtils.wp(2),
//                                             vertical: ResponsiveUtils.wp(.8),
//                                           ),
//                                           child: TextStyles.caption(
//                                             text: report.status,
//                                             color: Appcolors.kwhiteColor,
//                                             weight: FontWeight.bold,
//                                           ),
//                                         ),
//                                       ),

//                                     ],
//                                   ),
//                                   ResponsiveSizedBox.height10,
//                                   AnimatedContainer(
//                                     duration: const Duration(milliseconds: 300),
//                                     height:
//                                         isExpanded ? ResponsiveUtils.hp(42) : 0,
//                                     curve: Curves.easeInOut,
//                                     child: SingleChildScrollView(
//                                       padding: EdgeInsets.only(
//                                           top: ResponsiveUtils.wp(2)),
//                                       physics:
//                                           const NeverScrollableScrollPhysics(),
//                                       child: Container(
//                                         color: Appcolors.kgreenColor
//                                             .withOpacity(.15),
//                                         child: Column(
//                                           crossAxisAlignment:
//                                               CrossAxisAlignment.start,
//                                           children: [
//                                             ResponsiveSizedBox.height10,
//                                             Row(
//                                               mainAxisAlignment:
//                                                   MainAxisAlignment.center,
//                                               children: [
//                                                 TextStyles.medium(
//                                                   text: 'More Details',
//                                                   color:
//                                                       Appcolors.kprimarycolor,
//                                                   weight: FontWeight.bold,
//                                                 ),
//                                               ],
//                                             ),
//                                             const Divider(
//                                               thickness: .5,
//                                               color: Appcolors.kprimarycolor,
//                                             ),
//                                             CustomLargeTextWidget(
//                                                 context: context,
//                                                 heading: 'Revenue',
//                                                 details: '${report.revenue}'),
//                                             CustomLargeTextWidget(
//                                                 context: context,
//                                                 heading: 'Distance',
//                                                 details: '${report.distance}'),
//                                             CustomLargeTextWidget(
//                                                 context: context,
//                                                 heading: 'Product Flow',
//                                                 details:
//                                                     '${report.productFlow}'),
//                                             CustomLargeTextWidget(
//                                                 context: context,
//                                                 heading: 'Coin Reading',
//                                                 details:
//                                                     '${report.coinMeterReading}'),
//                                             CustomLargeTextWidget(
//                                                 context: context,
//                                                 heading: 'Sand filter pressure',
//                                                 details:
//                                                     '${report.sandFilterPressure}'),
//                                             CustomLargeTextWidget(
//                                                 context: context,
//                                                 heading:
//                                                     'Carbon filter pressure',
//                                                 details:
//                                                     '${report.carbonFilterPressure}'),
//                                             CustomLargeTextWidget(
//                                                 context: context,
//                                                 heading: 'System pressure',
//                                                 details:
//                                                     '${report.systemPressure}'),
//                                             CustomLargeTextWidget(
//                                                 context: context,
//                                                 heading: 'Reject Flow',
//                                                 details:
//                                                     '${report.rejectFlow}'),
//                                             CustomLargeTextWidget(
//                                                 context: context,
//                                                 heading: 'TDS',
//                                                 details: '${report.tds}'),

//                                             CustomLargeTextWidget(
//                                                 context: context,
//                                                 heading: 'KEB meter',
//                                                 details:
//                                                     '${report.kebMeterReading}'),
//                                             ResponsiveSizedBox.height10
//                                           ],
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),

//                             // Expandable section
//                           ],
//                         )),
//                   ),
//                 );
//               },
//             );
//           } else if (state is FetchReportErrorState) {
//             return Center(
//               child: Text(state.message),
//             );
//           } else {
//             return SizedBox.shrink();
//           }
//         },
//       ),
//     );
//   }
// }
//////////////////////////////////
class ScreenReportpage extends StatefulWidget {
  const ScreenReportpage({super.key});

  @override
  State<ScreenReportpage> createState() => _ScreenReportpageState();
}

class _ScreenReportpageState extends State<ScreenReportpage>
    with SingleTickerProviderStateMixin {
  int? expandedIndex; 
  late TabController _tabController;
  @override
  void initState() {
    super.initState();
    context.read<FetchReportBloc>().add(FetchReportInitialEvent());
    BlocProvider.of<FetchReportOfflineBloc>(context)
        .add(FetchReportOfflineInitialEvent());
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      // This forces a rebuild when tab changes
      setState(() {});
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
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
            text: 'View Report',
            color: Appcolors.kprimarycolor),
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Appcolors.kprimarycolor,
          labelColor: Appcolors.kprimarycolor,
          unselectedLabelColor: Colors.grey,
          tabs: const [
            Tab(text: "Online"),
            Tab(text: "Offline"),
          ],
        ),
      ),
      drawer: const CustomDrawer(),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildOnlineReports(),
          _buildOfflineReports(),
        ],
      ),
      floatingActionButton: _tabController.index == 1
          ? FloatingActionButton(
              elevation: 0,
              onPressed: () async{
               await MeasurmentsRepo().syncPendingData();
                  BlocProvider.of<FetchReportOfflineBloc>(context)
        .add(FetchReportOfflineInitialEvent());
              },
              backgroundColor: Appcolors.kgreenColor.withOpacity(.4),
              child: Icon(
                Icons.sync,
                color: Colors.blue,
              ),
            )
          : null,
    );
  }

  /// Online reports fetched from API
  Widget _buildOnlineReports() {
    return BlocBuilder<FetchReportBloc, FetchReportState>(
      builder: (context, state) {
        if (state is FetchReportLoadingState) {
          return const Center(
            child: SpinKitWaveSpinner(color: Appcolors.kprimarycolor),
          );
        } else if (state is FetchReportSuccessState) {
          return _buildReportList(state.reports);
        } else if (state is FetchReportErrorState) {
          return Center(child: Text(state.message));
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }

  /// Offline reports with dummy data
  Widget _buildOfflineReports() {
    return BlocBuilder<FetchReportOfflineBloc, FetchReportOfflineState>(
      builder: (context, state) {
        if (state is FetchReportOfflineLoading) {
          return const Center(
            child: SpinKitWaveSpinner(color: Appcolors.kprimarycolor),
          );
        } else if (state is FetchReportOfflineSuccess) {
          return _buildofflienReportList(state.data);
        } else if (state is FetchReportofflineErrorState) {
          return Center(child: Text(state.message));
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }

  /// Builds the expandable report list
  Widget _buildReportList(List<ReportModel> reports) {
    return ListView.builder(
      itemCount: reports.length,
      itemBuilder: (context, index) {
        final report = reports[index];
        bool isExpanded = expandedIndex == index;

        return Padding(
          padding: EdgeInsets.only(
              left: ResponsiveUtils.wp(4),
              right: ResponsiveUtils.wp(4),
              top: ResponsiveUtils.wp(4)),
          child: InkWell(
            onTap: () {
              setState(() {
                expandedIndex = isExpanded ? null : index;
              });
            },
            child: Container(
                color: Colors.white,
                child: Column(
                  children: [
                    // Existing content
                    Padding(
                      padding: const EdgeInsets.all(15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Container(
                                  padding:
                                      EdgeInsets.all(ResponsiveUtils.wp(1.5)),
                                  decoration: BoxDecoration(
                                      color: Appcolors.kprimarycolor
                                          .withOpacity(.1)),
                                  child: Text(
                                    'Area : ${report.areaName}',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        color: Appcolors.kblackColor,
                                        fontSize: 12),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.start,
                                  ),
                                ),
                              ),
                              ResponsiveSizedBox.width50,
                              ResponsiveSizedBox.width10,
                              Container(
                                decoration: BoxDecoration(
                                    color: Appcolors.kprimarycolor
                                        .withOpacity(.1)),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: ResponsiveUtils.wp(3),
                                      vertical: ResponsiveUtils.wp(1.5)),
                                  child: Text(
                                    'Root : ${report.routeName}',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        color: Appcolors.kblackColor,
                                        fontSize: 12),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.start,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          ResponsiveSizedBox.height20,
                          ResponsiveSizedBox.height5,
                          Row(
                            children: [
                              TextStyles.caption(
                                  text:
                                      'Date  : ${DateFormat('dd-MM-yyyy').format(DateTime.parse(report.createdAt!.date!))}',
                                  color: Appcolors.kblackColor,
                                  weight: FontWeight.bold),
                              const Spacer(),
                              TextStyles.caption(
                                  text: 'Status :',
                                  color: Appcolors.kblackColor,
                                  weight: FontWeight.bold),
                              ResponsiveSizedBox.width10,
                              Container(
                                decoration: BoxDecoration(
                                    color: report.status == 'APPROVED'
                                        ? Appcolors.kgreenColor.withOpacity(.6)
                                        : Appcolors.kredColor),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: ResponsiveUtils.wp(2),
                                    vertical: ResponsiveUtils.wp(.8),
                                  ),
                                  child: TextStyles.caption(
                                    text: report.status,
                                    color: Appcolors.kwhiteColor,
                                    weight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          ResponsiveSizedBox.height10,
                          AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            height: isExpanded ? ResponsiveUtils.hp(42) : 0,
                            curve: Curves.easeInOut,
                            child: SingleChildScrollView(
                              padding:
                                  EdgeInsets.only(top: ResponsiveUtils.wp(2)),
                              physics: const NeverScrollableScrollPhysics(),
                              child: Container(
                                color: Appcolors.kgreenColor.withOpacity(.15),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ResponsiveSizedBox.height10,
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        TextStyles.medium(
                                          text: 'More Details',
                                          color: Appcolors.kprimarycolor,
                                          weight: FontWeight.bold,
                                        ),
                                      ],
                                    ),
                                    const Divider(
                                      thickness: .5,
                                      color: Appcolors.kprimarycolor,
                                    ),
                                    CustomLargeTextWidget(
                                        context: context,
                                        heading: 'Revenue',
                                        details: '${report.revenue}'),
                                    CustomLargeTextWidget(
                                        context: context,
                                        heading: 'Distance',
                                        details: '${report.distance}'),
                                    CustomLargeTextWidget(
                                        context: context,
                                        heading: 'Product Flow',
                                        details: '${report.productFlow}'),
                                    CustomLargeTextWidget(
                                        context: context,
                                        heading: 'Coin Reading',
                                        details: '${report.coinMeterReading}'),
                                    CustomLargeTextWidget(
                                        context: context,
                                        heading: 'Sand filter pressure',
                                        details:
                                            '${report.sandFilterPressure}'),
                                    CustomLargeTextWidget(
                                        context: context,
                                        heading: 'Carbon filter pressure',
                                        details:
                                            '${report.carbonFilterPressure}'),
                                    CustomLargeTextWidget(
                                        context: context,
                                        heading: 'System pressure',
                                        details: '${report.systemPressure}'),
                                    CustomLargeTextWidget(
                                        context: context,
                                        heading: 'Reject Flow',
                                        details: '${report.rejectFlow}'),
                                    CustomLargeTextWidget(
                                        context: context,
                                        heading: 'TDS',
                                        details: '${report.tds}'),
                                    CustomLargeTextWidget(
                                        context: context,
                                        heading: 'KEB meter',
                                        details: '${report.kebMeterReading}'),
                                    ResponsiveSizedBox.height10
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Expandable section
                  ],
                )),
          ),
        );
      },
    );
  }

  //////////////
  ///  /// Builds the expandable report list
  Widget _buildofflienReportList(List<WaterPlantDataModel> reports) {
    return ListView.builder(
      itemCount: reports.length,
      itemBuilder: (context, index) {
        final report = reports[index];
        bool isExpanded = expandedIndex == index;

        return Padding(
          padding: EdgeInsets.only(
              left: ResponsiveUtils.wp(4),
              right: ResponsiveUtils.wp(4),
              top: ResponsiveUtils.wp(4)),
          child: InkWell(
            onTap: () {
              setState(() {
                expandedIndex = isExpanded ? null : index;
              });
            },
            child: Container(
                color: Colors.white,
                child: Column(
                  children: [
                    // Existing content
                    Padding(
                      padding: const EdgeInsets.all(15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Container(
                                  padding:
                                      EdgeInsets.all(ResponsiveUtils.wp(1.5)),
                                  decoration: BoxDecoration(
                                      color: Appcolors.kprimarycolor
                                          .withOpacity(.1)),
                                  child: Text(
                                    'Area Id : ${report.areaId}',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        color: Appcolors.kblackColor,
                                        fontSize: 12),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.start,
                                  ),
                                ),
                              ),
                              ResponsiveSizedBox.width50,
                              ResponsiveSizedBox.width10,
                              Container(
                                decoration: BoxDecoration(
                                    color: Appcolors.kprimarycolor
                                        .withOpacity(.1)),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: ResponsiveUtils.wp(3),
                                      vertical: ResponsiveUtils.wp(1.5)),
                                  child: Text(
                                    'Root Id : ${report.routeId}',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        color: Appcolors.kblackColor,
                                        fontSize: 12),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.start,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          ResponsiveSizedBox.height20,
                          ResponsiveSizedBox.height5,
                          Row(
                            children: [
                              TextStyles.caption(
                                  text:
                                      'Date  : ${DateFormat('dd-MM-yyyy').format(DateTime.parse(report.createdAt))}',
                                  color: Appcolors.kblackColor,
                                  weight: FontWeight.bold),
                              const Spacer(),
                              TextStyles.caption(
                                  text: 'Status :',
                                  color: Appcolors.kblackColor,
                                  weight: FontWeight.bold),
                              ResponsiveSizedBox.width10,
                              Container(
                                decoration:
                                    BoxDecoration(color: Appcolors.kredColor),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: ResponsiveUtils.wp(2),
                                    vertical: ResponsiveUtils.wp(.8),
                                  ),
                                  child: TextStyles.caption(
                                    text: 'Pending',
                                    color: Appcolors.kwhiteColor,
                                    weight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          ResponsiveSizedBox.height10,
                          AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            height: isExpanded ? ResponsiveUtils.hp(42) : 0,
                            curve: Curves.easeInOut,
                            child: SingleChildScrollView(
                              padding:
                                  EdgeInsets.only(top: ResponsiveUtils.wp(2)),
                              physics: const NeverScrollableScrollPhysics(),
                              child: Container(
                                color: Appcolors.kgreenColor.withOpacity(.15),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ResponsiveSizedBox.height10,
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        TextStyles.medium(
                                          text: 'More Details',
                                          color: Appcolors.kprimarycolor,
                                          weight: FontWeight.bold,
                                        ),
                                      ],
                                    ),
                                    const Divider(
                                      thickness: .5,
                                      color: Appcolors.kprimarycolor,
                                    ),
                                    CustomLargeTextWidget(
                                        context: context,
                                        heading: 'Revenue',
                                        details: 'not available'),
                                    CustomLargeTextWidget(
                                        context: context,
                                        heading: 'Distance',
                                        details: 'not available'),
                                    CustomLargeTextWidget(
                                        context: context,
                                        heading: 'Product Flow',
                                        details: '${report.productFlow}'),
                                    CustomLargeTextWidget(
                                        context: context,
                                        heading: 'Coin Reading',
                                        details: '${report.coinMeterReading}'),
                                    CustomLargeTextWidget(
                                        context: context,
                                        heading: 'Sand filter pressure',
                                        details:
                                            '${report.sandFilterPressure}'),
                                    CustomLargeTextWidget(
                                        context: context,
                                        heading: 'Carbon filter pressure',
                                        details:
                                            '${report.carbonFilterPressure}'),
                                    CustomLargeTextWidget(
                                        context: context,
                                        heading: 'System pressure',
                                        details: '${report.systemPressure}'),
                                    CustomLargeTextWidget(
                                        context: context,
                                        heading: 'Reject Flow',
                                        details: '${report.rejectFlow}'),
                                    CustomLargeTextWidget(
                                        context: context,
                                        heading: 'TDS',
                                        details: '${report.tds}'),
                                    CustomLargeTextWidget(
                                        context: context,
                                        heading: 'KEB meter',
                                        details: '${report.kebMeterReading}'),
                                    ResponsiveSizedBox.height10
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Expandable section
                  ],
                )),
          ),
        );
      },
    );
  }
}

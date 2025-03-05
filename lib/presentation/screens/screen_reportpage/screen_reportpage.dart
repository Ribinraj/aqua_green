import 'package:aqua_green/core/colors.dart';
import 'package:aqua_green/core/constants.dart';
import 'package:aqua_green/core/responsive_utils.dart';
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
//       body: ListView.builder(
//         itemCount: 10,
//         itemBuilder: (context, index) {
//           return Padding(
//             padding: EdgeInsets.only(
//                 left: ResponsiveUtils.wp(4),
//                 right: ResponsiveUtils.wp(4),
//                 top: ResponsiveUtils.wp(4)),
//             child: InkWell(
//               onTap: () {
//                 CustomNavigation.push(context, ScreenReportDetailpage());
//               },
//               child: Container(
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                   ),
//                   child: Padding(
//                     padding: const EdgeInsets.all(15),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Expanded(
//                               child: Container(
//                                 padding:
//                                     EdgeInsets.all(ResponsiveUtils.wp(1.5)),
//                                 decoration: BoxDecoration(
//                                     color: Appcolors.kprimarycolor
//                                         .withOpacity(.1)),
//                                 child: const Text(
//                                   'Area : jss layout',
//                                   style: TextStyle(
//                                       fontWeight: FontWeight.w600,
//                                       color: Appcolors.kblackColor,
//                                       fontSize: 12),
//                                   maxLines: 2,
//                                   overflow: TextOverflow.ellipsis,
//                                   textAlign: TextAlign.start,
//                                 ),
//                               ),
//                             ),
//                             ResponsiveSizedBox.width50,
//                             ResponsiveSizedBox.width10,
//                             Container(
//                               decoration: BoxDecoration(
//                                   color:
//                                       Appcolors.kprimarycolor.withOpacity(.1)),
//                               child: Padding(
//                                 padding: EdgeInsets.symmetric(
//                                     horizontal: ResponsiveUtils.wp(3),
//                                     vertical: ResponsiveUtils.wp(1.5)),
//                                 child: const Text(
//                                   'Root : 5',
//                                   style: TextStyle(
//                                       fontWeight: FontWeight.w600,
//                                       color: Appcolors.kblackColor,
//                                       fontSize: 12),
//                                   maxLines: 2,
//                                   overflow: TextOverflow.ellipsis,
//                                   textAlign: TextAlign.start,
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                         ResponsiveSizedBox.height10,
//                         CustomTextWidget(
//                             context: context,
//                             heading: 'Date',
//                             details: '10/12/2024'),
//                         ResponsiveSizedBox.height5,
//                         Row(
//                           children: [
//                             SizedBox(
//                                 width: ResponsiveUtils.wp(22),
//                                 child: TextStyles.caption(
//                                     text: 'Electricity',
//                                     color: Appcolors.kblackColor,
//                                     weight: FontWeight.bold)),
//                             const Text(
//                               ':',
//                               style: TextStyle(
//                                   color: Appcolors.kblackColor,
//                                   fontSize: 10,
//                                   fontWeight: FontWeight.bold),
//                             ),
//                             ResponsiveSizedBox.width10,
//                             GestureDetector(
//                               onTap: () {},
//                               child: Container(
//                                 decoration: BoxDecoration(
//                                     color:
//                                         Appcolors.kgreenColor.withOpacity(.8)),
//                                 child: Padding(
//                                   padding: EdgeInsets.symmetric(
//                                     horizontal: ResponsiveUtils.wp(3),
//                                     vertical: ResponsiveUtils.wp(.8),
//                                   ),
//                                   child: TextStyles.caption(
//                                     text: 'Yes',
//                                     color: Appcolors.kwhiteColor,
//                                     weight: FontWeight.bold,
//                                   ),
//                                 ),
//                               ),
//                             ),

//                             // Container(
//                             //   decoration: BoxDecoration(
//                             //     borderRadius: BorderRadiusStyles.kradius5(),
//                             //     color: Appcolors.kredColor,
//                             //   ),
//                             //   child: Padding(
//                             //     padding: EdgeInsets.symmetric(
//                             //       horizontal: ResponsiveUtils.wp(2),
//                             //       vertical: ResponsiveUtils.wp(1),
//                             //     ),
//                             //     child: TextStyles.caption(
//                             //       text: 'Delete',
//                             //       color: Appcolors.kwhiteColor,
//                             //       weight: FontWeight.bold,
//                             //     ),
//                             //   ),
//                             // ),
//                           ],
//                         ),
//                         ResponsiveSizedBox.height10,
//                         Row(
//                           children: [
//                             TextStyles.caption(
//                                 text: 'Product Flow Reading : 400',
//                                 color: Appcolors.kblackColor,
//                                 weight: FontWeight.bold),
//                             Spacer(),
//                             TextStyles.caption(
//                                 text: 'Coin Reading : 400',
//                                 color: Appcolors.kblackColor,
//                                 weight: FontWeight.bold),

//                           ],
//                         ),
//                         ResponsiveSizedBox.height10,
//                       ],
//                     ),
//                   )),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }

class ScreenReportpage extends StatefulWidget {
  const ScreenReportpage({super.key});

  @override
  State<ScreenReportpage> createState() => _ScreenReportpageState();
}

class _ScreenReportpageState extends State<ScreenReportpage> {
  int? expandedIndex; // Track which item is expanded
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<FetchReportBloc>().add(FetchReportInitialEvent());
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
      ),
      drawer: const CustomDrawer(),
      body: BlocBuilder<FetchReportBloc, FetchReportState>(
        builder: (context, state) {
          if (state is FetchReportLoadingState) {
            return const Center(
              child: SpinKitWaveSpinner(color: Appcolors.kprimarycolor),
            );
          } else if (state is FetchReportSuccessState) {
            return ListView.builder(
              itemCount: state.reports.length,
              itemBuilder: (context, index) {
                final report = state.reports[index];
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
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Container(
                                          padding: EdgeInsets.all(
                                              ResponsiveUtils.wp(1.5)),
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
                                              vertical:
                                                  ResponsiveUtils.wp(1.5)),
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
                                            color:report.status=='APPROVED' ? Appcolors.kgreenColor
                                                .withOpacity(.6): Appcolors.kredColor) ,
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

                                      // Container(
                                      //   decoration: BoxDecoration(
                                      //     borderRadius: BorderRadiusStyles.kradius5(),
                                      //     color: Appcolors.kredColor,
                                      //   ),
                                      //   child: Padding(
                                      //     padding: EdgeInsets.symmetric(
                                      //       horizontal: ResponsiveUtils.wp(2),
                                      //       vertical: ResponsiveUtils.wp(1),
                                      //     ),
                                      //     child: TextStyles.caption(
                                      //       text: 'Delete',
                                      //       color: Appcolors.kwhiteColor,
                                      //       weight: FontWeight.bold,
                                      //     ),
                                      //   ),
                                      // ),
                                    ],
                                  ),
                                  ResponsiveSizedBox.height10,
                                  AnimatedContainer(
                                    duration: const Duration(milliseconds: 300),
                                    height:
                                        isExpanded ? ResponsiveUtils.hp(42) : 0,
                                    curve: Curves.easeInOut,
                                    child: SingleChildScrollView(
                                      padding: EdgeInsets.only(
                                          top: ResponsiveUtils.wp(2)),
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      child: Container(
                                        color: Appcolors.kgreenColor
                                            .withOpacity(.15),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            ResponsiveSizedBox.height10,
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                TextStyles.medium(
                                                  text: 'More Details',
                                                  color:
                                                      Appcolors.kprimarycolor,
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
                                                details:
                                                    '${report.productFlow}'),
                                            CustomLargeTextWidget(
                                                context: context,
                                                heading: 'Coin Reading',
                                                details:
                                                    '${report.coinMeterReading}'),
                                            CustomLargeTextWidget(
                                                context: context,
                                                heading: 'Sand filter pressure',
                                                details:
                                                    '${report.sandFilterPressure}'),
                                            CustomLargeTextWidget(
                                                context: context,
                                                heading:
                                                    'Carbon filter pressure',
                                                details:
                                                    '${report.carbonFilterPressure}'),
                                            CustomLargeTextWidget(
                                                context: context,
                                                heading: 'System pressure',
                                                details:
                                                    '${report.systemPressure}'),
                                            CustomLargeTextWidget(
                                                context: context,
                                                heading: 'Reject Flow',
                                                details:
                                                    '${report.rejectFlow}'),
                                            CustomLargeTextWidget(
                                                context: context,
                                                heading: 'TDS',
                                                details: '${report.tds}'),
                                            // CustomLargeTextWidget(
                                            //     context: context,
                                            //     heading: 'Water Ltrs',
                                            //     details:
                                            //         '${report.waterLtrsReading}'),
                                            CustomLargeTextWidget(
                                                context: context,
                                                heading: 'KEB meter',
                                                details:
                                                    '${report.kebMeterReading}'),
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
          } else if (state is FetchReportErrorState) {
            return Center(
              child: Text(state.message),
            );
          } else {
            return SizedBox.shrink();
          }
        },
      ),
    );
  }
}

import 'package:aqua_green/core/colors.dart';
import 'package:aqua_green/core/constants.dart';
import 'package:aqua_green/core/responsive_utils.dart';
import 'package:aqua_green/presentation/widgets/custom_largetextwidget.dart';

import 'package:aqua_green/presentation/widgets/custom_textwidget.dart';
import 'package:flutter/material.dart';

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
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
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
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
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
                                    child: const Text(
                                      'Area : jss layout',
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
                                    child: const Text(
                                      'Root : 5',
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
                            ResponsiveSizedBox.height10,
                            CustomTextWidget(
                                context: context,
                                heading: 'Date',
                                details: '10/12/2024'),
                            ResponsiveSizedBox.height5,
                            Row(
                              children: [
                                SizedBox(
                                    width: ResponsiveUtils.wp(22),
                                    child: TextStyles.caption(
                                        text: 'Electricity',
                                        color: Appcolors.kblackColor,
                                        weight: FontWeight.bold)),
                                const Text(
                                  ':',
                                  style: TextStyle(
                                      color: Appcolors.kblackColor,
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold),
                                ),
                                ResponsiveSizedBox.width10,
                                Container(
                                  decoration: BoxDecoration(
                                      color: Appcolors.kgreenColor
                                          .withOpacity(.8)),
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: ResponsiveUtils.wp(3),
                                      vertical: ResponsiveUtils.wp(.8),
                                    ),
                                    child: TextStyles.caption(
                                      text: 'Yes',
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
                            Row(
                              children: [
                                TextStyles.caption(
                                    text: 'Product Flow Reading : 400',
                                    color: Appcolors.kblackColor,
                                    weight: FontWeight.bold),
                                Spacer(),
                                TextStyles.caption(
                                    text: 'Coin Reading : 400',
                                    color: Appcolors.kblackColor,
                                    weight: FontWeight.bold),
                              ],
                            ),
                            ResponsiveSizedBox.height10,
                            AnimatedContainer(
                              duration: const Duration(milliseconds: 300),
                              height: isExpanded
                                  ? 200
                                  : 0, // Adjust height as needed
                              curve: Curves.easeInOut,
                              child: SingleChildScrollView(
                                physics: const NeverScrollableScrollPhysics(),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        TextStyles.medium(
                                          text: 'Pressure Details',
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
                                        heading: 'Sand filter pressure',
                                        details: '500'),
                                    CustomLargeTextWidget(
                                        context: context,
                                        heading: 'Carbon filter pressure',
                                        details: '500'),
                                    CustomLargeTextWidget(
                                        context: context,
                                        heading: 'System pressure',
                                        details: '500'),
                                  ],
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
      ),
    );
  }
}

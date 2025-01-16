import 'package:aqua_green/core/colors.dart';
import 'package:aqua_green/core/constants.dart';
import 'package:aqua_green/core/responsive_utils.dart';
import 'package:aqua_green/data/area_model.dart';
import 'package:aqua_green/data/plant_datamodel.dart';
import 'package:aqua_green/data/route_model.dart';
import 'package:aqua_green/data/unit_model.dart';
import 'package:aqua_green/presentation/blocs/add_measurment/add_measurment_bloc.dart';
import 'package:aqua_green/presentation/blocs/fetch_area/fetch_area_bloc.dart';
import 'package:aqua_green/presentation/blocs/fetch_route/fetch_route_bloc.dart';
import 'package:aqua_green/presentation/blocs/fetch_unit/fetch_unit_bloc.dart';
import 'package:aqua_green/presentation/blocs/image_picker/image_picker_bloc.dart';
import 'package:aqua_green/presentation/screens/screen_measurepage/widgets/image_compressor.dart';
import 'package:aqua_green/presentation/screens/screen_measurepage/widgets/location_class.dart';
import 'package:aqua_green/presentation/screens/screen_updateunits/widgets/disabledropdownbutton.dart';

import 'package:aqua_green/presentation/widgets/custom_drawer.dart';
import 'package:aqua_green/presentation/widgets/custom_imagecontainer.dart';
import 'package:aqua_green/presentation/widgets/custom_multiimage_container.dart';
import 'package:aqua_green/presentation/widgets/custom_snackbar.dart';
import 'package:aqua_green/presentation/widgets/custom_submitbutton.dart';
import 'package:aqua_green/presentation/widgets/custom_textfield_addmeasure.dart';
import 'package:aqua_green/presentation/widgets/customrout_mainpage.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:geolocator/geolocator.dart';

import 'package:url_launcher/url_launcher.dart';

class ScreenMeasurepage extends StatefulWidget {
  const ScreenMeasurepage({super.key});

  @override
  State<ScreenMeasurepage> createState() => _ScreenMeasurepageState();
}

class _ScreenMeasurepageState extends State<ScreenMeasurepage> {
  final LocationService _locationService = LocationService();
  double? _distance;

  Future<void> _updateDistance(double? latitude, double? longitude) async {
    if (latitude == null || longitude == null) {
      setState(() {
        _distance = null; // Reset distance when coordinates are null
      });
      return;
    }

    try {
      double distance = await _locationService.calculateDistance(
        latitude,
        longitude,
      );
      setState(() {
        _distance = distance;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString())),
      );
    }
  }

///////////////////////////
  final List<String> productflow =
      List.generate(20, (index) => ((index + 1) * 100).toString());
  final List<String> sandcarbonfilterPressure =
      List.generate(20, (index) => ((index + 1) * 100).toString());
  final List<String> rejuctflow =
      List.generate(40, (index) => ((index + 1) * 100).toString());
  final List<String> systempressure =
      List.generate(15, (index) => (index + 1).toString());

  final List<String> yesNoOptions = [
    'YES',
    'NO',
  ];
  final TextEditingController routeController = TextEditingController();
  final TextEditingController areaController = TextEditingController();
  final TextEditingController unitController = TextEditingController();
  final TextEditingController yesNoController = TextEditingController();
  final TextEditingController productFlowController = TextEditingController();
  final TextEditingController rejectflowController = TextEditingController();
  final TextEditingController sandfilterPressureController =
      TextEditingController();
  final TextEditingController carbonfilterPressureController =
      TextEditingController();
  final TextEditingController systemPressureController =
      TextEditingController();
  final TextEditingController tdsController = TextEditingController();
  final TextEditingController waterlittersReadingController =
      TextEditingController();
  // ignore: non_constant_identifier_names
  final TextEditingController coin_roWateterReadingController =
      TextEditingController();
  final TextEditingController kebmeterReadingController =
      TextEditingController();

  final _formKey = GlobalKey<FormState>();
  String? selectedRoute;
  String? selectedUnit;
  String? selectedArea;
  String selectedYesNo = 'Yes';
  String? selectedProductFlow;
  String? selectedRejectFlow;
  String? selectedSandFilterPressure;
  String? selectedCarbonFilterPressure;
  String? selectedSystemPressure;
  AreaModel? selectedAreaModel;
  UnitModel? selectedUnitModel;
  double? selectedLatitude;
  double? selectedLongitude;
  bool isloading = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    yesNoController.text = selectedYesNo;
    context.read<FetchRouteBloc>().add(FetchRouteInitialEvent());
    context.read<FetchAreaBloc>().add(FetchAreaInitialEvent());
    context.read<FetchUnitBloc>().add(FetchUnitInitialEvent());
    context.read<ImagePickerBloc>().add(ClearAllImagesEvent());
  }

  Widget buildYesContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextStyles.medium(
            text: 'Product Flow',
            weight: FontWeight.bold,
            color: Appcolors.kdarkbluecolor),
        ResponsiveSizedBox.height5,
        dropdownTexfield(
            hintText: 'Select Product flow',
            onChanged: (value) {
              setState(() {
                selectedProductFlow = value;
                productFlowController.text = value!;
              });
            },
            list: productflow),
        ResponsiveSizedBox.height20,
        TextStyles.medium(
            text: 'Reject Flow',
            weight: FontWeight.bold,
            color: Appcolors.kdarkbluecolor),
        ResponsiveSizedBox.height5,
        dropdownTexfield(
            hintText: 'Select Reject flow',
            onChanged: (value) {
              setState(() {
                selectedRejectFlow = value;
                rejectflowController.text = value!;
              });
            },
            list: rejuctflow),
        ResponsiveSizedBox.height20,
        Container(
          color: Appcolors.kwhiteColor,
          padding: EdgeInsets.all(ResponsiveUtils.wp(3)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ResponsiveSizedBox.height10,
              TextStyles.medium(
                  text: 'Sand Filter Pressure',
                  weight: FontWeight.bold,
                  color: Appcolors.kdarkbluecolor),
              ResponsiveSizedBox.height5,
              dropdownTexfield(
                  hintText: 'Select Sand Filter Pressure',
                  onChanged: (value) {
                    setState(() {
                      selectedSandFilterPressure = value;
                      sandfilterPressureController.text = value!;
                    });
                  },
                  list: sandcarbonfilterPressure),
              ResponsiveSizedBox.height20,
              TextStyles.medium(
                  text: 'Carbon Filter Pressure',
                  weight: FontWeight.bold,
                  color: Appcolors.kdarkbluecolor),
              ResponsiveSizedBox.height5,
              dropdownTexfield(
                  hintText: 'Select carbon Filter Pressure',
                  onChanged: (value) {
                    setState(() {
                      selectedCarbonFilterPressure = value;
                      carbonfilterPressureController.text = value!;
                    });
                  },
                  list: sandcarbonfilterPressure),
              ResponsiveSizedBox.height20,
              TextStyles.medium(
                  text: 'System Pressure',
                  weight: FontWeight.bold,
                  color: Appcolors.kdarkbluecolor),
              ResponsiveSizedBox.height5,
              dropdownTexfield(
                  hintText: 'Select System Pressure',
                  onChanged: (value) {
                    setState(() {
                      selectedSystemPressure = value;
                      systemPressureController.text = value!;
                    });
                  },
                  list: systempressure),
              ResponsiveSizedBox.height20,
            ],
          ),
        ),
        ResponsiveSizedBox.height20,
        TextStyles.medium(
            text: 'TDS',
            weight: FontWeight.bold,
            color: Appcolors.kdarkbluecolor),
        ResponsiveSizedBox.height5,
        CustomTextfieldaddmeasure(
            textInputType: TextInputType.number,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'TDS cannot be empty';
              }
              return null;
            },
            controller: tdsController,
            hinttext: 'Enter TDS'),
        ResponsiveSizedBox.height20,
        TextStyles.medium(
            text: 'Water Litters Reading',
            weight: FontWeight.bold,
            color: Appcolors.kdarkbluecolor),
        ResponsiveSizedBox.height5,
        CustomTextfieldaddmeasure(
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Water litters reading cannot be empty';
              }
              return null;
            },
            textInputType: TextInputType.number,
            controller: waterlittersReadingController,
            hinttext: 'Enter Water Litters Reading'),
        ResponsiveSizedBox.height20,
        TextStyles.medium(
            text: 'Coin RO Water Reading',
            weight: FontWeight.bold,
            color: Appcolors.kdarkbluecolor),
        ResponsiveSizedBox.height5,
        CustomTextfieldaddmeasure(
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Coin RO water reading cannot be empty';
              }
              return null;
            },
            textInputType: TextInputType.number,
            controller: coin_roWateterReadingController,
            hinttext: 'Enter coin RO Water Reading'),
        ResponsiveSizedBox.height20,
        TextStyles.medium(
            text: 'Keb meter Reading',
            weight: FontWeight.bold,
            color: Appcolors.kdarkbluecolor),
        ResponsiveSizedBox.height5,
        CustomTextfieldaddmeasure(
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'KEB meter reading cannot be empty';
              }
              return null;
            },
            textInputType: TextInputType.number,
            controller: kebmeterReadingController,
            hinttext: 'Enter keb meter Reading'),
        ResponsiveSizedBox.height20,
        Container(
          color: Appcolors.kwhiteColor,
          padding: EdgeInsets.all(ResponsiveUtils.wp(5)),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextStyles.medium(
                          text: 'Keb Meter Image',
                          weight: FontWeight.bold,
                          color: Appcolors.kdarkbluecolor),
                      ResponsiveSizedBox.height10,
                      // Add your No-specific widgets here
                      ReusableImageContainer(
                          source: 'Meter Image',
                          height: ResponsiveUtils.hp(15),
                          width: ResponsiveUtils.wp(35))
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextStyles.medium(
                          text: 'Flow Range Image',
                          weight: FontWeight.bold,
                          color: Appcolors.kdarkbluecolor),
                      ResponsiveSizedBox.height10,
                      // Add your No-specific widgets here
                      ReusableImageContainer(
                          source: 'Flow Range Image',
                          height: ResponsiveUtils.hp(15),
                          width: ResponsiveUtils.wp(35))
                    ],
                  ),
                ],
              ),
              ResponsiveSizedBox.height20,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextStyles.medium(
                          text: 'Filter Chemical Image',
                          weight: FontWeight.bold,
                          color: Appcolors.kdarkbluecolor),
                      ResponsiveSizedBox.height10,
                      // Add your No-specific widgets here
                      ReusableImageContainer(
                          source: 'Filter Chemical Image',
                          height: ResponsiveUtils.hp(15),
                          width: ResponsiveUtils.wp(35))
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextStyles.medium(
                          text: 'Coin Reading Image',
                          weight: FontWeight.bold,
                          color: Appcolors.kdarkbluecolor),
                      ResponsiveSizedBox.height10,
                      // Add your No-specific widgets here
                      ReusableImageContainer(
                          source: 'Coin Reading Image',
                          height: ResponsiveUtils.hp(15),
                          width: ResponsiveUtils.wp(35))
                    ],
                  ),
                ],
              ),
              ResponsiveSizedBox.height20,
              TextStyles.body(
                  text: 'Plant Images',
                  weight: FontWeight.bold,
                  color: Appcolors.kprimarycolor),
              ResponsiveSizedBox.height5,
              const Divider(
                thickness: .5,
                color: Appcolors.kprimarycolor,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextStyles.medium(
                          text: 'Front Image',
                          weight: FontWeight.bold,
                          color: Appcolors.kdarkbluecolor),
                      ResponsiveSizedBox.height10,
                      // Add your No-specific widgets here
                      ReusableImageContainer(
                          source: 'Plant Front Image',
                          height: ResponsiveUtils.hp(12),
                          width: ResponsiveUtils.wp(25))
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextStyles.medium(
                          text: 'Back Image',
                          weight: FontWeight.bold,
                          color: Appcolors.kdarkbluecolor),
                      ResponsiveSizedBox.height10,
                      // Add your No-specific widgets here
                      ReusableImageContainer(
                          source: 'Plant Back Image',
                          height: ResponsiveUtils.hp(12),
                          width: ResponsiveUtils.wp(25))
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextStyles.medium(
                          text: 'Inside Image',
                          weight: FontWeight.bold,
                          color: Appcolors.kdarkbluecolor),
                      ResponsiveSizedBox.height10,
                      // Add your No-specific widgets here
                      ReusableImageContainer(
                          source: 'Plant Inside Image',
                          height: ResponsiveUtils.hp(12),
                          width: ResponsiveUtils.wp(25))
                    ],
                  ),
                ],
              ),
              ResponsiveSizedBox.height20,
              TextStyles.body(
                  text: 'Additional Images',
                  weight: FontWeight.bold,
                  color: Appcolors.kprimarycolor),
              ResponsiveSizedBox.height5,
              const Divider(
                thickness: .5,
                color: Appcolors.kprimarycolor,
              ),
              ResponsiveSizedBox.height20,
              MultiImagePickerContainer(
                  source: 'Additional Images',
                  containerHeight: ResponsiveUtils.hp(12),
                  containerWidth: ResponsiveUtils.wp(25))
            ],
          ),
        ),
        ResponsiveSizedBox.height30,
        BlocConsumer<AddMeasurmentBloc, AddMeasurmentState>(
          listener: (context, state) {
            if (state is AddMeasurmentSuccessState) {
              setState(() {
                isloading = false;
                // Reset selected values
                selectedRoute = null;
                selectedArea = null;
                selectedUnit = null;
                selectedAreaModel = null;
                selectedUnitModel = null;
                selectedProductFlow = null;
                selectedRejectFlow = null;
                selectedSandFilterPressure = null;
                selectedCarbonFilterPressure = null;
                selectedSystemPressure = null;

                // Clear all controllers
                unitController.clear();
                areaController.clear();
                routeController.clear();
                productFlowController.clear();
                rejectflowController.clear();
                sandfilterPressureController.clear();
                carbonfilterPressureController.clear();
                systemPressureController.clear();
                tdsController.clear();
                waterlittersReadingController.clear();
                coin_roWateterReadingController.clear();
                kebmeterReadingController.clear();
              });

              // Clear all images
              context.read<ImagePickerBloc>().add(ClearAllImagesEvent());

              // Reset form
              _formKey.currentState?.reset();
              CustomSnackBar.show(
                  context: context,
                  title: 'Success',
                  message: 'Measurement recorded successfully',
                  contentType: ContentType.success);
            } else if (state is AddMeasurmentErrorState) {
              setState(() {
                isloading = false;
              });
              CustomSnackBar.show(
                  context: context,
                  title: 'Error',
                  message: state.message,
                  contentType: ContentType.failure);
            }
          },
          builder: (context, state) {
            if (state is AddMeasurmentLoadingState || isloading) {
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
                  if (_formKey.currentState!.validate()) {
                    if (!validateCommonFields()) return;

                    if (!validateYesFields()) return;
                    if (!validateYesImages()) return;
                    // Set processing state before starting image processing
                    setState(() {
                      isloading = true;
                    });

                    try {
                      Position currentlocation =
                          await LocationService().getCurrentLocation();
                      final imagePickerState =
                          context.read<ImagePickerBloc>().state;

                      // Get all images from their respective states
                      final meterImages = (imagePickerState['Meter Image']
                              as ImagePickerSuccessState)
                          .images;
                      final flowrangeImages =
                          (imagePickerState['Flow Range Image']
                                  as ImagePickerSuccessState)
                              .images;
                      final filterChemicalImages =
                          (imagePickerState['Filter Chemical Image']
                                  as ImagePickerSuccessState)
                              .images;
                      final coinreadingImages =
                          (imagePickerState['Coin Reading Image']
                                  as ImagePickerSuccessState)
                              .images;
                      final plantFrontImages =
                          (imagePickerState['Plant Front Image']
                                  as ImagePickerSuccessState)
                              .images;
                      final plantBackImages =
                          (imagePickerState['Plant Back Image']
                                  as ImagePickerSuccessState)
                              .images;
                      final plantInsideImages =
                          (imagePickerState['Plant Inside Image']
                                  as ImagePickerSuccessState)
                              .images;
                      final additionalImages =
                          (imagePickerState['Additional Images']
                                  as ImagePickerSuccessState)
                              .images;

                      final processedMeterImage =
                          await ImageProcessor.processImage(meterImages.first);
                      final processedFilterChemicalImage =
                          await ImageProcessor.processImage(
                              filterChemicalImages.first);
                      final processedCoinReadingImage =
                          await ImageProcessor.processImage(
                              coinreadingImages.first);
                      final processedFlowRangeImage =
                          await ImageProcessor.processImage(
                              flowrangeImages.first);
                      final processedPlantFrontImage =
                          await ImageProcessor.processImage(
                              plantFrontImages.first);
                      final processedPlantBackImage =
                          await ImageProcessor.processImage(
                              plantBackImages.first);
                      final processedPlantInsideImage =
                          await ImageProcessor.processImage(
                              plantInsideImages.first);

                      // Process additional images
                      final processedAdditionalImages =
                          await ImageProcessor.processMultipleImages(
                              additionalImages);
                      ////////////////
                      final List<Picture> pictures = [
                        Picture(
                          imageName: ImageProcessor.generateImageName('Meter'),
                          pictureType: 'Meter',
                          image: processedMeterImage,
                        ),
                        Picture(
                          imageName:
                              ImageProcessor.generateImageName('FlowRange'),
                          pictureType: 'FlowRange',
                          image: processedFlowRangeImage,
                        ),
                        Picture(
                          imageName: ImageProcessor.generateImageName(
                              'FilterChemical'),
                          pictureType: 'FilterChemical',
                          image: processedFilterChemicalImage,
                        ),
                        Picture(
                          imageName:
                              ImageProcessor.generateImageName('CoinReading'),
                          pictureType: 'CoinReading',
                          image: processedCoinReadingImage,
                        ),
                        Picture(
                          imageName:
                              ImageProcessor.generateImageName('PlantFront'),
                          pictureType: 'PlantFront',
                          image: processedPlantFrontImage,
                        ),
                        Picture(
                          imageName:
                              ImageProcessor.generateImageName('PlantBack'),
                          pictureType: 'PlantBack',
                          image: processedPlantBackImage,
                        ),
                        Picture(
                          imageName:
                              ImageProcessor.generateImageName('PlantInside'),
                          pictureType: 'PlantInside',
                          image: processedPlantInsideImage,
                        ),
                        // Handle additional images with index
                        ...List.generate(
                            processedAdditionalImages.length,
                            (index) => Picture(
                                  imageName: ImageProcessor.generateImageName(
                                      'Additional_$index'),
                                  pictureType: 'Additional',
                                  image: processedAdditionalImages[index],
                                )),
                      ];
                      if (!mounted) return;
                      //////////////
                      context.read<AddMeasurmentBloc>().add(
                          AddMeasurmentButtonclickEvent(
                              datas:
                                  WaterPlantDataModel(
                                      unitId: unitController.text,
                                      areaId: areaController.text,
                                      routeId: routeController.text,
                                      latt: currentlocation.latitude.toString(),
                                      long:
                                          currentlocation.longitude.toString(),
                                      powerSupply: yesNoController.text,
                                      productFlow: productFlowController.text,
                                      rejectFlow: rejectflowController.text,
                                      sandFilterPressure:
                                          sandfilterPressureController.text,
                                      carbonFilterPressure:
                                          carbonfilterPressureController.text,
                                      systemPressure:
                                          systemPressureController.text,
                                      tds: tdsController.text,
                                      waterLtrsReading:
                                          waterlittersReadingController.text,
                                      coinMeterReading:
                                          coin_roWateterReadingController.text,
                                      kebMeterReading:
                                          kebmeterReadingController.text,
                                      pictures: pictures)));
                    } catch (e) {
                      setState(() {
                        isloading = false;
                      });
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content:
                              Text('Error processing images: ${e.toString()}'),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                  } else {
                    CustomSnackBar.show(
                        context: context,
                        title: 'Error',
                        message: 'fill all fields',
                        contentType: ContentType.failure);
                  }
                },
                text: 'Submit');
          },
        )
      ],
    );
  }

  // Widget to show when No is selected
  Widget buildNoContent() {
    return Column(
      children: [
        Container(
          color: Appcolors.kwhiteColor,
          padding: EdgeInsets.all(ResponsiveUtils.wp(6)),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextStyles.medium(
                          text: 'Meter Image',
                          weight: FontWeight.bold,
                          color: Appcolors.kdarkbluecolor),
                      ResponsiveSizedBox.height10,
                      // Add your No-specific widgets here
                      ReusableImageContainer(
                          source: 'Meter Image',
                          height: ResponsiveUtils.hp(15),
                          width: ResponsiveUtils.wp(35))
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextStyles.medium(
                          text: 'Plant Front Image',
                          weight: FontWeight.bold,
                          color: Appcolors.kdarkbluecolor),
                      ResponsiveSizedBox.height10,
                      // Add your No-specific widgets here
                      ReusableImageContainer(
                          source: 'Plant Front Image',
                          height: ResponsiveUtils.hp(15),
                          width: ResponsiveUtils.wp(35))
                    ],
                  ),
                ],
              ),
              ResponsiveSizedBox.height20,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextStyles.medium(
                          text: 'Plant Back Image',
                          weight: FontWeight.bold,
                          color: Appcolors.kdarkbluecolor),
                      ResponsiveSizedBox.height10,
                      // Add your No-specific widgets here
                      ReusableImageContainer(
                          source: 'Plant Back Image',
                          height: ResponsiveUtils.hp(15),
                          width: ResponsiveUtils.wp(35))
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextStyles.medium(
                          text: 'Plant Inside Image',
                          weight: FontWeight.bold,
                          color: Appcolors.kdarkbluecolor),
                      ResponsiveSizedBox.height10,
                      // Add your No-specific widgets here
                      ReusableImageContainer(
                          source: 'Plant Inside Image',
                          height: ResponsiveUtils.hp(15),
                          width: ResponsiveUtils.wp(35))
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
        ResponsiveSizedBox.height30,
        BlocConsumer<AddMeasurmentBloc, AddMeasurmentState>(
          listener: (context, state) {
            if (state is AddMeasurmentSuccessState) {
              setState(() {
                isloading = false;
                // Reset selected values
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

              // Clear all images
              context.read<ImagePickerBloc>().add(ClearAllImagesEvent());

              // Reset form
              _formKey.currentState?.reset();
              CustomSnackBar.show(
                  context: context,
                  title: 'Success',
                  message: 'Measurement recorded successfully',
                  contentType: ContentType.success);
            } else if (state is AddMeasurmentErrorState) {
              setState(() {
                isloading = false;
              });
              CustomSnackBar.show(
                  context: context,
                  title: 'Error',
                  message: state.message,
                  contentType: ContentType.failure);
            }
          },
          builder: (context, state) {
            if (state is AddMeasurmentLoadingState || isloading) {
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
                if (_formKey.currentState!.validate()) {
                  if (!validateCommonFields()) return;
                  if (!validateNOImages()) return;
                  setState(() {
                    isloading = true;
                  });
                  try {
                    Position currentlocation =
                        await LocationService().getCurrentLocation();
                    final imagePickerState =
                        context.read<ImagePickerBloc>().state;

                    // Get all images from their respective states
                    final meterImages = (imagePickerState['Meter Image']
                            as ImagePickerSuccessState)
                        .images;

                    final plantFrontImages =
                        (imagePickerState['Plant Front Image']
                                as ImagePickerSuccessState)
                            .images;
                    final plantBackImages =
                        (imagePickerState['Plant Back Image']
                                as ImagePickerSuccessState)
                            .images;
                    final plantInsideImages =
                        (imagePickerState['Plant Inside Image']
                                as ImagePickerSuccessState)
                            .images;

                    final processedMeterImage =
                        await ImageProcessor.processImage(meterImages.first);

                    final processedPlantFrontImage =
                        await ImageProcessor.processImage(
                            plantFrontImages.first);
                    final processedPlantBackImage =
                        await ImageProcessor.processImage(
                            plantBackImages.first);
                    final processedPlantInsideImage =
                        await ImageProcessor.processImage(
                            plantInsideImages.first);

                    ////////////////
                    final List<Picture> pictures = [
                      Picture(
                        imageName: ImageProcessor.generateImageName('Meter'),
                        pictureType: 'Meter',
                        image: processedMeterImage,
                      ),
                      Picture(
                        imageName:
                            ImageProcessor.generateImageName('PlantFront'),
                        pictureType: 'PlantFront',
                        image: processedPlantFrontImage,
                      ),
                      Picture(
                        imageName:
                            ImageProcessor.generateImageName('PlantBack'),
                        pictureType: 'PlantBack',
                        image: processedPlantBackImage,
                      ),
                      Picture(
                        imageName:
                            ImageProcessor.generateImageName('PlantInside'),
                        pictureType: 'PlantInside',
                        image: processedPlantInsideImage,
                      ),
                    ];
                    if (!mounted) return;
                    //////////////
                    context.read<AddMeasurmentBloc>().add(
                        AddMeasurmentButtonclickEvent(
                            datas: WaterPlantDataModel(
                                unitId: unitController.text,
                                areaId: areaController.text,
                                routeId: routeController.text,
                                latt: currentlocation.latitude.toString(),
                                long: currentlocation.longitude.toString(),
                                powerSupply: yesNoController.text,
                                pictures: pictures)));
                  } catch (e) {
                    setState(() {
                      isloading = false;
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content:
                            Text('Error processing images: ${e.toString()}'),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                } else {
                  CustomSnackBar.show(
                      context: context,
                      title: 'Error',
                      message: 'fill all fields',
                      contentType: ContentType.failure);
                }
              },
              text: 'Submit',
            );
          },
        )
      ],
    );
  }

/////////////validation/////////////
  // Validation function for common fields
  bool validateCommonFields() {
    if (selectedRoute == null || selectedArea == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select both Route and Area'),
          backgroundColor: Colors.red,
        ),
      );
      return false;
    }
    return true;
  }

  // Validation function for Yes case
  bool validateYesFields() {
    if (selectedProductFlow == null ||
        selectedRejectFlow == null ||
        selectedSandFilterPressure == null ||
        selectedCarbonFilterPressure == null ||
        selectedSystemPressure == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select both Product Flow and Reject Flow'),
          backgroundColor: Colors.red,
        ),
      );
      return false;
    }
    return true;
  }

  bool validateNOImages() {
    final imagePickerState = context.read<ImagePickerBloc>().state;
    final meterImageState = imagePickerState['Meter Image'];
    final plantFrontImageState = imagePickerState['Plant Front Image'];
    final plantBackImageState = imagePickerState['Plant Back Image'];
    final plantInsideImageState = imagePickerState['Plant Inside Image'];

    // Check if states exist and have images
    final hasMeterImage = meterImageState is ImagePickerSuccessState &&
        (meterImageState).images.isNotEmpty;
    final hasPlantFrontImage =
        plantFrontImageState is ImagePickerSuccessState &&
            (plantFrontImageState).images.isNotEmpty;
    final hasPlantBackImage = plantBackImageState is ImagePickerSuccessState &&
        (plantBackImageState).images.isNotEmpty;
    final hasPlantInsideImage =
        plantInsideImageState is ImagePickerSuccessState &&
            (plantInsideImageState).images.isNotEmpty;

    if (!hasMeterImage ||
        !hasPlantFrontImage ||
        !hasPlantBackImage ||
        !hasPlantInsideImage) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please capture both Meter and Plant images'),
          backgroundColor: Colors.red,
        ),
      );
      return false;
    }
    return true;
  }

  bool validateYesImages() {
    final imagePickerState = context.read<ImagePickerBloc>().state;
    final meterImageState = imagePickerState['Meter Image'];
    final flowrangeImageState = imagePickerState['Flow Range Image'];
    final filterChemicalImageState = imagePickerState['Filter Chemical Image'];
    final coinReadingImageState = imagePickerState['Coin Reading Image'];
    final plantFrontImageState = imagePickerState['Plant Front Image'];
    final plantBackImageState = imagePickerState['Plant Back Image'];
    final plantInsideImageState = imagePickerState['Plant Inside Image'];

    // Check if states exist and have images
    final hasMeterImage = meterImageState is ImagePickerSuccessState &&
        (meterImageState).images.isNotEmpty;
    final hasflowrangeImage = flowrangeImageState is ImagePickerSuccessState &&
        (flowrangeImageState).images.isNotEmpty;
    final hasfilterChemicalImage =
        filterChemicalImageState is ImagePickerSuccessState &&
            (filterChemicalImageState).images.isNotEmpty;
    final hascoinReadingImage =
        coinReadingImageState is ImagePickerSuccessState &&
            (coinReadingImageState).images.isNotEmpty;
    final hasPlantFrontImage =
        plantFrontImageState is ImagePickerSuccessState &&
            (plantFrontImageState).images.isNotEmpty;
    final hasPlantBackImage = plantBackImageState is ImagePickerSuccessState &&
        (plantBackImageState).images.isNotEmpty;
    final hasPlantInsideImage =
        plantInsideImageState is ImagePickerSuccessState &&
            (plantInsideImageState).images.isNotEmpty;

    if (!hasMeterImage ||
        !hasPlantFrontImage ||
        !hasPlantBackImage ||
        !hasPlantInsideImage ||
        !hasflowrangeImage ||
        !hasfilterChemicalImage ||
        !hascoinReadingImage) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please capture both Meter and Plant images'),
          backgroundColor: Colors.red,
        ),
      );
      return false;
    }
    return true;
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
            text: 'Add measure',
            color: Appcolors.kprimarycolor),
      ),
      drawer: const CustomDrawer(),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
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
                          text: 'Select Route',
                          color: Appcolors.kdarkbluecolor),
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
                                    routeId: area.routeId,
                                    areaId: area.areaId));
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
                    return Column(
                      children: [
                        DropdownButtonFormField2<UnitModel>(
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
                              text: 'Select Unit',
                              color: Appcolors.kdarkbluecolor),
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
                                _updateDistance(unit.latitude, unit.longitude);
                              } else {
                                unitController.clear();
                                _distance = null;
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
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: ResponsiveUtils.wp(4)),
                          child: buildDistanceDisplay(),
                        )
                      ],
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
              if (selectedUnit == null)
                SizedBox.shrink()
              else if (selectedUnitModel?.latitude == null ||
                  selectedUnitModel?.longitude == null)
                Column(
                  children: [
                    ResponsiveSizedBox.height20,
                    SubmitButton(
                        ontap: () {
                          navigateToMainPage(context, 1);
                        },
                        text: 'Update Location'),
                  ],
                )
              else
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ResponsiveSizedBox.height20,
                    TextStyles.medium(
                        text: 'Is there Power supply?',
                        weight: FontWeight.bold,
                        color: Appcolors.kdarkbluecolor),
                    ResponsiveSizedBox.height5,
                    dropdownTexfield(
                        hintText: 'Yes/No',
                        onChanged: (value) {
                          setState(() {
                            selectedYesNo = value!;
                            yesNoController.text = value;
                          });
                        },
                        list: yesNoOptions,
                        isYesNo: true),
                    ResponsiveSizedBox.height30,
                    selectedYesNo == 'Yes'
                        ? buildYesContent()
                        : buildNoContent(),
                  ],
                )
            ],
          ),
        ),
      ),
    );
  }

  DropdownButtonFormField2<String> dropdownTexfield({
    required void Function(String?) onChanged,
    required List<dynamic> list,
    required String hintText,
    bool isYesNo = false,
    //String?initialValue
  }) {
    return DropdownButtonFormField2<String>(
      decoration: const InputDecoration(
        contentPadding: EdgeInsets.symmetric(vertical: 5),
        filled: true,
        fillColor: Appcolors.kwhiteColor,
        // contentPadding:
        //     const EdgeInsets.symmetric(horizontal: 0, vertical: 5),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Appcolors.kprimarycolor, width: 0.5),
          // borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Appcolors.kprimarycolor, width: 1.5),
          // borderRadius: BorderRadius.circular(10),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Appcolors.kprimarycolor, width: 0.5),
          // borderRadius: BorderRadius.circular(10),
        ),
      ),
      hint: TextStyles.caption(text: hintText, color: Appcolors.kdarkbluecolor),
      value: isYesNo ? selectedYesNo : null,
      items: list
          .map((item) => DropdownMenuItem<String>(
                value: item,
                child: TextStyles.caption(
                    text: item, color: Appcolors.kdarkbluecolor),
              ))
          .toList(),
      validator: (value) {
        if (value == null) {
          return 'Please select a status';
        }
        return null;
      },
      onChanged: onChanged,
      buttonStyleData: const ButtonStyleData(
          // padding: EdgeInsets.only(left: 10, right: 10),
          ),
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
  }

//////////////////
// First create a separate widget for the distance display outside the unit builder
  Widget buildDistanceDisplay() {
    if (selectedUnit == null) {
      return TextStyles.medium(
        text: 'Select a unit to view distance',
        weight: FontWeight.bold,
        color: Appcolors.kdarkbluecolor,
      );
    }

    if (selectedUnitModel?.latitude == null ||
        selectedUnitModel?.longitude == null) {
      return TextStyles.medium(
        text: 'GPS coordinates for this unit is not set',
        weight: FontWeight.bold,
        color: Appcolors.kredColor,
      );
    }

    return Row(
      children: [
        TextStyles.medium(
          text: _distance != null
              ? 'Distance from current location: ${_distance!.toStringAsFixed(2)} km'
              : 'Calculating distance...',
          weight: FontWeight.bold,
          color: Appcolors.kgreenColor,
        ),
        Spacer(),
        if (_distance != null)
          GestureDetector(
            onTap: () {
              if (selectedUnitModel?.latitude != null &&
                  selectedUnitModel?.longitude != null) {
                openGoogleMaps(selectedUnitModel!.latitude!,
                    selectedUnitModel!.longitude!);
              }
            },
            child: Container(
              padding: EdgeInsets.all(ResponsiveUtils.wp(1.5)),
              decoration: BoxDecoration(
                color: Appcolors.kprimarycolor.withOpacity(.7),
                borderRadius: BorderRadius.circular(3),
              ),
              child: TextStyles.caption(
                text: 'Locate',
                color: Appcolors.kwhiteColor,
                weight: FontWeight.bold,
              ),
            ),
          ),
      ],
    );
  }
  ///////////////

  Future<void> openGoogleMaps(double latitude, double longitude) async {
    String googleMapsUrl =
        "https://www.google.com/maps/dir/?api=1&destination=$latitude,$longitude&travelmode=driving";

    if (await canLaunchUrl(Uri.parse(googleMapsUrl))) {
      await launchUrl(Uri.parse(googleMapsUrl));
    } else {
      throw "Could not open Google Maps.";
    }
  }
}

/////////////

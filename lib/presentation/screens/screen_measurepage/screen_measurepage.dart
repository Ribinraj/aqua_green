import 'package:aqua_green/core/colors.dart';
import 'package:aqua_green/core/constants.dart';
import 'package:aqua_green/core/responsive_utils.dart';
import 'package:aqua_green/presentation/blocs/image_picker/image_picker_bloc.dart';

import 'package:aqua_green/presentation/widgets/custom_drawer.dart';
import 'package:aqua_green/presentation/widgets/custom_imagecontainer.dart';
import 'package:aqua_green/presentation/widgets/custom_multiimage_container.dart';
import 'package:aqua_green/presentation/widgets/custom_submitbutton.dart';
import 'package:aqua_green/presentation/widgets/custom_textfield_addmeasure.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';

class ScreenMeasurepage extends StatefulWidget {
  const ScreenMeasurepage({super.key});

  @override
  State<ScreenMeasurepage> createState() => _ScreenMeasurepageState();
}

class _ScreenMeasurepageState extends State<ScreenMeasurepage> {
  final List<String> routes = [
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9',
    '10',
  ];
  // final List<String> areas = [
  //   'Area 1',
  //   'Area 2',
  //   'Area 3',
  //   'Area 4',
  //   'Area 5',
  //   'Area 6',
  //   'Area 7',
  //   'Area 8',
  //   'Area 9',
  //   'Area 10',
  // ];
  ////////////////////
  final LocationService _locationService = LocationService();
  double? _distance;
  final List<String> areas = sampleAreaCoordinates.keys.toList();
  Future<void> _updateDistance(String selectedArea) async {
    try {
      double distance = await _locationService.calculateDistance(selectedArea);
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
    'Yes',
    'No',
  ];
  final TextEditingController routeController = TextEditingController();
  final TextEditingController areaController = TextEditingController();
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
  String? selectedArea;
  String selectedYesNo = 'Yes';
  String? selectedProductFlow;
  String? selectedRejectFlow;
  String? selectedSandFilterPressure;
  String? selectedCarbonFilterPressure;
  String? selectedSystemPressure;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    yesNoController.text = selectedYesNo;
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
        SubmitButton(
            ontap: () {
              if (_formKey.currentState!.validate()) {
                if (!validateCommonFields()) return;

                if (!validateYesFields()) return;
                if (!validateYesImages()) return;
                final imagePickerState = context.read<ImagePickerBloc>().state;

                // Get all images from their respective states
                final meterImages =
                    (imagePickerState['Meter Image'] as ImagePickerSuccessState)
                        .images;
                final flowrangeImages = (imagePickerState['Flow Range Image']
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
                final plantFrontImages = (imagePickerState['Plant Front Image']
                        as ImagePickerSuccessState)
                    .images;
                final plantBackImages = (imagePickerState['Plant Back Image']
                        as ImagePickerSuccessState)
                    .images;
                final plantInsideImages =
                    (imagePickerState['Plant Inside Image']
                            as ImagePickerSuccessState)
                        .images;
                final additionalImages = (imagePickerState['Additional Images']
                        as ImagePickerSuccessState)
                    .images;

                // Since these are single-image containers, we take the first image
                final meterImage = meterImages.first;
                final filterchemicalImage = filterChemicalImages.first;
                final coinreadingImage = coinreadingImages.first;
                final flowrangeImage = flowrangeImages.first;
                final plantFrontImage = plantFrontImages.first;
                final plantBackImage = plantBackImages.first;
                final plantInsideImage = plantInsideImages.first;
                debugPrint('Submitting Yes case with:');
                debugPrint('Route: $selectedRoute');
                debugPrint('Area: $selectedArea');
                debugPrint('Product Flow: $selectedProductFlow');
                debugPrint('Reject Flow: $selectedRejectFlow');
              }
            },
            text: 'Submit')
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
        // SubmitButton(
        //   ontap: () {
        //     if (_formKey.currentState!.validate()) {
        //       if (!validateCommonFields()) return;
        //       if (!validateNOImages()) return;
        //       final imagePickerState = context.read<ImagePickerBloc>().state;
        //       final meterImageState =
        //           imagePickerState['Meter Image'] as ImagePickerSuccessState;
        //       final plantImageState =
        //           imagePickerState['Plant Image'] as ImagePickerSuccessState;

        //       final meterImage = meterImageState.imageFile;
        //       final plantImage = plantImageState.imageFile;

        //       debugPrint('Submitting No case with:');
        //       debugPrint('Route: $selectedRoute');
        //       debugPrint('Area: $selectedArea');
        //       debugPrint('Meter Image: ${meterImage!.path}');
        //       debugPrint('Plant Image: ${plantImage!.path}');
        //     }
        //   },
        //   text: 'Submit',
        // )
        SubmitButton(
          ontap: () {
            if (_formKey.currentState!.validate()) {
              if (!validateCommonFields()) return;
              if (!validateNOImages()) return;

              final imagePickerState = context.read<ImagePickerBloc>().state;

              // Get all images from their respective states
              final meterImages =
                  (imagePickerState['Meter Image'] as ImagePickerSuccessState)
                      .images;
              final plantFrontImages = (imagePickerState['Plant Front Image']
                      as ImagePickerSuccessState)
                  .images;
              final plantBackImages = (imagePickerState['Plant Back Image']
                      as ImagePickerSuccessState)
                  .images;
              final plantInsideImages = (imagePickerState['Plant Inside Image']
                      as ImagePickerSuccessState)
                  .images;

              // Since these are single-image containers, we take the first image
              final meterImage = meterImages.first;
              final plantFrontImage = plantFrontImages.first;
              final plantBackImage = plantBackImages.first;
              final plantInsideImage = plantInsideImages.first;

              debugPrint('Submitting No case with:');
              debugPrint('Route: $selectedRoute');
              debugPrint('Area: $selectedArea');
              debugPrint('Meter Image: ${meterImage.path}');
              debugPrint('Plant Front Image: ${plantFrontImage.path}');
              debugPrint('Plant Back Image: ${plantBackImage.path}');
              debugPrint('Plant Inside Image: ${plantInsideImage.path}');

              // Add your submission logic here
            }
          },
          text: 'Submit',
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

  // Validation function for images in No case
  // bool validateNOImages() {
  //   final imagePickerState = context.read<ImagePickerBloc>().state;

  //   final meterImageState = imagePickerState['Meter Image'];
  //   final plantFrontImageState = imagePickerState['Plant Front Image'];
  //   final plantBackImageState = imagePickerState['Plant Back Image'];
  //   final plantInsideImageState = imagePickerState['Plant Inside Image'];

  //   final hasMeterImage = meterImageState is ImagePickerSuccessState;
  //   final hasPlantFrontImage = plantFrontImageState is ImagePickerSuccessState;
  //   final hasPlantBackImage = plantBackImageState is ImagePickerSuccessState;
  //   final hasPlantInsideImage =
  //       plantInsideImageState is ImagePickerSuccessState;

  //   if (!hasMeterImage ||
  //       !hasPlantFrontImage ||
  //       !hasPlantBackImage ||
  //       !hasPlantInsideImage) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       const SnackBar(
  //         content: Text('Please capture both Meter and Plant images'),
  //         backgroundColor: Colors.red,
  //       ),
  //     );
  //     return false;
  //   }
  //   return true;
  // }
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
              dropdownTexfield(
                  hintText: 'Select Route',
                  onChanged: (value) {
                    setState(() {
                      selectedRoute = value;
                      routeController.text = value!;
                    });
                  },
                  list: routes),
              ResponsiveSizedBox.height20,
              TextStyles.medium(
                  text: 'Area',
                  weight: FontWeight.bold,
                  color: Appcolors.kdarkbluecolor),
              ResponsiveSizedBox.height5,
              dropdownTexfield(
                  hintText: 'Select Select Area',
                  onChanged: (value) {
                    setState(() {
                      selectedArea = value;
                      areaController.text = value!;
                      _updateDistance(value);
                    });
                  },
                  list: areas),
              if (_distance != null)
                Padding(
                  padding: EdgeInsets.only(top: ResponsiveUtils.wp(4)),
                  child: TextStyles.medium(
                      text:
                          'Distance from current location: ${_distance!.toStringAsFixed(2)} km',
                      weight: FontWeight.bold,
                      color: Appcolors.kgreenColor),
                ),
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
              selectedYesNo == 'Yes' ? buildYesContent() : buildNoContent(),
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
}

/////////////
class LocationService {
  Future<Position> getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw 'Location services are disabled.';
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw 'Location permissions are denied';
      }
    }

    if (permission == LocationPermission.deniedForever) {
      throw 'Location permissions are permanently denied';
    }

    return await Geolocator.getCurrentPosition();
  }

  Future<double> calculateDistance(String selectedArea) async {
    try {
      Position currentLocation = await getCurrentLocation();

      // Get coordinates for selected area
      final areaCoords = sampleAreaCoordinates[selectedArea];
      if (areaCoords == null) {
        throw 'Area coordinates not found';
      }

      double distanceInMeters = Geolocator.distanceBetween(
        currentLocation.latitude,
        currentLocation.longitude,
        areaCoords['latitude']!,
        areaCoords['longitude']!,
      );

      return distanceInMeters / 1000; // Convert to kilometers
    } catch (e) {
      throw 'Error calculating distance: $e';
    }
  }
}

final Map<String, Map<String, double>> sampleAreaCoordinates = {
  'Calicut': {
    'latitude': 11.2588,
    'longitude': 75.7804,
  },
  'Kochi': {
    'latitude': 9.9312,
    'longitude': 76.2673,
  },
  'Trivandrum': {
    'latitude': 8.5241,
    'longitude': 76.9366,
  },
  'Thrissur': {
    'latitude': 10.5276,
    'longitude': 76.2144,
  },
};

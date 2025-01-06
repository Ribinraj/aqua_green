import 'package:aqua_green/core/colors.dart';
import 'package:aqua_green/core/constants.dart';
import 'package:aqua_green/core/responsive_utils.dart';
import 'package:aqua_green/presentation/blocs/image_picker/image_picker_bloc.dart';
import 'package:aqua_green/presentation/screens/screen_reset_password/screen_reset_passwordpage.dart';
import 'package:aqua_green/presentation/widgets/custom_drawer.dart';
import 'package:aqua_green/presentation/widgets/custom_imagecontainer.dart';
import 'package:aqua_green/presentation/widgets/custom_textfield_addmeasure.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
  final List<String> productflow =
      List.generate(20, (index) => ((index + 1) * 100).toString());
  final List<String> rejuctflow =
      List.generate(40, (index) => ((index + 1) * 100).toString());
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
                  list: routes),
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
                  list: routes),
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
                  list: routes),
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
            controller: tdsController,
            hinttext: 'Enter TDS'),
        ResponsiveSizedBox.height20,
        TextStyles.medium(
            text: 'Water Litters Reading',
            weight: FontWeight.bold,
            color: Appcolors.kdarkbluecolor),
        ResponsiveSizedBox.height5,
        CustomTextfieldaddmeasure(
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
            textInputType: TextInputType.number,
            controller: kebmeterReadingController,
            hinttext: 'Enter keb meter Reading'),
        ResponsiveSizedBox.height30,
        SubmitButton(
            ontap: () {
              if (_formKey.currentState!.validate()) {
                if (!validateCommonFields()) return;
                if (!validateYesFields()) return;
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
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextStyles.medium(
                    text: 'Upload Meter Image',
                    weight: FontWeight.bold,
                    color: Appcolors.kdarkbluecolor),
                ResponsiveSizedBox.height10,
                // Add your No-specific widgets here
                ReusableImageContainer(source: 'Meter Image')
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextStyles.medium(
                    text: 'Upload Plant Image',
                    weight: FontWeight.bold,
                    color: Appcolors.kdarkbluecolor),
                ResponsiveSizedBox.height10,
                // Add your No-specific widgets here
                ReusableImageContainer(source: 'Plant Image')
              ],
            ),
          ],
        ),
        ResponsiveSizedBox.height30,
        SubmitButton(
          ontap: () {
            if (_formKey.currentState!.validate()) {
              if (!validateCommonFields()) return;
              if (!validateImages()) return;
              final imagePickerState = context.read<ImagePickerBloc>().state;
              final meterImageState =
                  imagePickerState['Meter Image'] as ImagePickerSuccessState;
              final plantImageState =
                  imagePickerState['Plant Image'] as ImagePickerSuccessState;

              final meterImage = meterImageState.imageFile;
              final plantImage = plantImageState.imageFile;

              debugPrint('Submitting No case with:');
              debugPrint('Route: $selectedRoute');
              debugPrint('Area: $selectedArea');
              debugPrint('Meter Image: ${meterImage!.path}');
              debugPrint('Plant Image: ${plantImage!.path}');
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
    if (selectedProductFlow == null || selectedRejectFlow == null) {
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
  bool validateImages() {
    final imagePickerState = context.read<ImagePickerBloc>().state;

    final meterImageState = imagePickerState['Meter Image'];
    final plantImageState = imagePickerState['Plant Image'];

    final hasMeterImage = meterImageState is ImagePickerSuccessState;
    final hasPlantImage = plantImageState is ImagePickerSuccessState;

    if (!hasMeterImage || !hasPlantImage) {
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
            text: 'Add measurement',
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
                    });
                  },
                  list: routes),
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
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      menuItemStyleData: MenuItemStyleData(
        height: ResponsiveUtils.hp(5.7),
      ),
    );
  }
}

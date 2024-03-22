import 'package:ecommerce_app/blocs/addresses_bloc/addresses_bloc.dart';
import 'package:ecommerce_app/common_widgets/fill_information_text_field.dart';
import 'package:ecommerce_app/common_widgets/loading_manager.dart';
import 'package:ecommerce_app/common_widgets/my_app_bar.dart';
import 'package:ecommerce_app/common_widgets/my_icon.dart';
import 'package:ecommerce_app/common_widgets/screen_name_section.dart';
import 'package:ecommerce_app/config/app_config.dart';
import 'package:ecommerce_app/constants/app_assets.dart';
import 'package:ecommerce_app/constants/app_dimensions.dart';
import 'package:ecommerce_app/models/shipping_address.dart';
import 'package:ecommerce_app/repositories/address_repository.dart';
import 'package:ecommerce_app/screens/add_address_screen/add_address_confirm_button.dart';
import 'package:ecommerce_app/utils/location_util.dart';
import 'package:ecommerce_app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AddAddressScreen extends StatefulWidget {
  final ShippingAddress? address;

  const AddAddressScreen({
    super.key,
    this.address,
  });

  static const String routeName = "/add-address-screen";

  @override
  State<AddAddressScreen> createState() => _AddAddressScreenState();
}

class _AddAddressScreenState extends State<AddAddressScreen> {
  bool isLoading = false;
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController countryController = TextEditingController();
  final TextEditingController stateController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController streetController = TextEditingController();
  final TextEditingController zipCodeController = TextEditingController();
  final TextEditingController callingCodeController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  bool setAsDefaultAddress = true;
  final formState = GlobalKey<FormState>();
  LatLng? coordinates;
  final MapController mapController = MapController();

  @override
  void initState() {
    super.initState();
    if (widget.address != null) {
      fullNameController.text = widget.address!.recipientName;
      countryController.text = widget.address!.country;
      stateController.text = widget.address!.state;
      cityController.text = widget.address!.city;
      streetController.text = widget.address!.street;
      zipCodeController.text = widget.address!.zipCode;
      callingCodeController.text = widget.address!.countryCallingCode;
      phoneNumberController.text = widget.address!.phoneNumber;
    } else {
      _getPosition();
    }

    KeyboardVisibilityController().onChange.listen((event) {
      if (event) {
        setState(() {
          coordinates = null;
        });
      } else {
        _getCoordinatesFromAddress();
      }
    });
  }

  @override
  void dispose() {
    countryController.dispose();
    stateController.dispose();
    cityController.dispose();
    streetController.dispose();
    zipCodeController.dispose();
    callingCodeController.dispose();
    phoneNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LoadingManager(
      isLoading: isLoading,
      child: Scaffold(
        appBar: const MyAppBar(),
        body: KeyboardDismissOnTap(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ScreenNameSection(
                  label: AppLocalizations.of(context)!.addNewAddress),
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: AppDimensions.defaultPadding),
                    child: Form(
                      key: formState,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (coordinates != null)
                            SizedBox(
                              height: 300,
                              child: Stack(
                                children: [
                                  FlutterMap(
                                    mapController: mapController,
                                    options: MapOptions(
                                      minZoom: 5,
                                      maxZoom: 30,
                                      zoom: 18,
                                      center: coordinates,
                                      interactiveFlags: InteractiveFlag.all,
                                    ),
                                    children: [
                                      TileLayer(
                                        urlTemplate: AppConfig.mapUrlTemplate,
                                        additionalOptions: const {
                                          'mapStyleId': AppConfig.mapBoxStyleId,
                                          'accessToken':
                                              AppConfig.mapBoxAccessToken,
                                        },
                                      ),
                                      MarkerLayer(
                                        markers: [
                                          Marker(
                                              point: coordinates!,
                                              builder: (_) {
                                                return const MyIcon(
                                                    icon: AppAssets.icLocation);
                                              })
                                        ],
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          const SizedBox(height: 20),
                          FillInformationTextField(
                            label: "Full name",
                            controller: fullNameController,
                            validator: _validator,
                          ),
                          FillInformationTextField(
                            label: "Country",
                            controller: countryController,
                            validator: _validator,
                          ),
                          FillInformationTextField(
                            label: "State/Province/Region",
                            controller: stateController,
                            validator: _validator,
                          ),
                          FillInformationTextField(
                            label: "City",
                            controller: cityController,
                            validator: _validator,
                          ),
                          FillInformationTextField(
                            label: "Street",
                            controller: streetController,
                            validator: _validator,
                          ),
                          FillInformationTextField(
                            label: "Zip code",
                            controller: zipCodeController,
                            validator: _validator,
                          ),
                          FillInformationTextField(
                            label: "Country calling code",
                            controller: callingCodeController,
                            validator: _validator,
                          ),
                          FillInformationTextField(
                            label: "Phone number",
                            controller: phoneNumberController,
                            validator: _validator,
                          ),
                          Row(
                            children: [
                              Checkbox(
                                  checkColor: Theme.of(context)
                                      .colorScheme
                                      .onPrimaryContainer,
                                  activeColor: Theme.of(context)
                                      .colorScheme
                                      .primaryContainer,
                                  side: BorderSide(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .primaryContainer,
                                  ),
                                  value: setAsDefaultAddress,
                                  onChanged: (value) {
                                    if (value != null) {
                                      setState(() {
                                        setAsDefaultAddress = value;
                                      });
                                    }
                                  }),
                              Text("Use as default address.",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall!
                                      .copyWith(
                                        color: Theme.of(context).primaryColor,
                                      ))
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              AddAddressConfirmButton(onPressed: _onConfirmPressed),
            ],
          ),
        ),
      ),
    );
  }

  String? _validator(String? value) {
    if (value == null || value.isEmpty) {
      return "This information is required";
    }
    return null;
  }

  _onConfirmPressed() async {
    if (formState.currentState!.validate()) {
      _changeLoadingState(true);

      final ShippingAddress newAddress = ShippingAddress(
        id: widget.address != null ? widget.address!.id : "",
        recipientName: fullNameController.text,
        street: streetController.text,
        city: cityController.text,
        state: stateController.text,
        country: countryController.text,
        zipCode: zipCodeController.text,
        countryCallingCode: callingCodeController.text,
        phoneNumber: phoneNumberController.text,
        latitude: widget.address != null
            ? widget.address!.latitude
            : coordinates?.latitude,
        longitude: widget.address != null
            ? widget.address!.longitude
            : coordinates?.longitude,
      );
      if (widget.address == null) {
        await AddressRepository().addShippingAddress(
          address: newAddress,
          setAsDefault: setAsDefaultAddress,
        );
      } else {
        await AddressRepository().updateShippingAddress(
          address: newAddress,
          setAsDefault: setAsDefaultAddress,
        );
      }

      if (!mounted) return;
      context.read<AddressesBloc>().add(LoadAddresses());
      Navigator.pop(context);

      _changeLoadingState(false);
    }
  }

  _getPosition() async {
    _changeLoadingState(true);

    coordinates = await LocationUtil().getCurrentPosition(context: context);
    if (coordinates == null) {
      return;
    }
    final location =
        await LocationUtil().getLocationFromLatLng(latLng: coordinates!);
    countryController.text = location.country ?? "";
    stateController.text = location.administrativeArea ?? "";
    cityController.text = location.locality ?? "";
    streetController.text = location.street ?? "";
    zipCodeController.text = location.postalCode ?? "";

    _changeLoadingState(false);
  }

  _getCoordinatesFromAddress() async {
    final String fullAddress =
        "${streetController.text},  ${cityController.text},  ${stateController.text},  ${countryController.text}";
    final newLatLng =
        await LocationUtil().getCoordinatesFromAddress(fullAddress);
    if (newLatLng == null && mounted) {
      Utils.showSnackBar(context: context, message: "Can't get location");
    }
    setState(() {
      coordinates = newLatLng;
    });
  }

  _changeLoadingState(bool isLoading) {
    setState(() {
      this.isLoading = isLoading;
    });
  }
}

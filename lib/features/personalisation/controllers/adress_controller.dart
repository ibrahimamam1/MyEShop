import 'package:e_shop/common/widgets/loaders/loaders.dart';
import 'package:e_shop/common/widgets/text/section_heading.dart';
import 'package:e_shop/data/repositories/personalisation/address_repository.dart';
import 'package:e_shop/features/personalisation/models/adress_model.dart';
import 'package:e_shop/features/personalisation/views/addresses/widgets/add_new_adress.dart';
import 'package:e_shop/features/personalisation/views/addresses/widgets/signle_user_adress.dart';
import 'package:e_shop/utils/constants/image_strings.dart';
import 'package:e_shop/utils/constants/sizes.dart';
import 'package:e_shop/utils/helpers/cloud_helper_functions.dart';
import 'package:e_shop/utils/network/network_manager.dart';
import 'package:e_shop/utils/popups/full_screen_loader.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddressController extends GetxController {
  static AddressController get instance => Get.find();

  final Rx<AddressModel> selectedAddress = AddressModel.empty().obs;
  final addressRepository = Get.put(AddressRepository());

  final name = TextEditingController();
  final phoneNumber = TextEditingController();
  final street = TextEditingController();
  final postalCode = TextEditingController();
  final city = TextEditingController();
  final state = TextEditingController();
  final country = TextEditingController();
  GlobalKey<FormState> addressFormKey = GlobalKey<FormState>();

  RxBool refreshData = true.obs;

  //Fetch all address of user
  Future<List<AddressModel>> getAllUserAddresses() async {
    try {
      final addresses = await addressRepository.fetchUserAddresses();
      selectedAddress.value = addresses.firstWhere(
          (element) => element.selectedAddress,
          orElse: () => AddressModel.empty());
      return addresses;
    } catch (e) {
      AppLoaders.errorSnackBar(
          title: 'Address not found', message: e.toString());
      return [];
    }
  }

  Future selectAddress(AddressModel newSelectedAddress) async {
    try {
      //clear the selected field
      if (selectedAddress.value.id.isNotEmpty) {
        await addressRepository.updateSelectedField(
            selectedAddress.value.id, false);
      }

      //Assign selected address
      newSelectedAddress.selectedAddress = true;
      selectedAddress.value = newSelectedAddress;

      //set the selected field to true for the newly selected address
      await addressRepository.updateSelectedField(
          selectedAddress.value.id, true);
    } catch (e) {
      AppLoaders.errorSnackBar(
          title: 'Error in Selection', message: e.toString());
    }
  }

  ///Show Address ModalBottomSheet at Checkout
  Future<dynamic> selectNewAddressPopup(BuildContext context) {
    return showModalBottomSheet(
        context: context,
        builder: (_) => Container(
              padding: const EdgeInsets.all(AppSizes.lg),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const AppSectionHeading(title: 'Select Address'),
                  FutureBuilder(
                      future: getAllUserAddresses(),
                      builder: (_, snapshot) {
                        final widget =
                            AppCloudHelperFunctions.checkMultiRecordState(
                                snapshot: snapshot);

                        if (widget != null) return widget;

                        //otherwise dataFound
                        return ListView.builder(
                            shrinkWrap: true,
                            itemCount: snapshot.data!.length,
                            itemBuilder: (_, index) => AppSingleUserAdress(
                                address: snapshot.data![index],
                                onTap: () async {
                                  selectedAddress(snapshot.data![index]);
                                  Get.back();
                                }));
                      }),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                        onPressed: () => Get.to(() => const AddNewAdressScreen()),
                        child: const Text('Add new Address')),
                  )
                ],
              ),
            ));
  }

  //Add New Adress
  Future addNewAddresses() async {
    try {
      //start AppLoader
      AppFullscreenLoader.openLoadingDialog(
          'Storing Address', AppImages.docerAnimation);

      //check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        AppFullscreenLoader.stopLoading();
        return;
      }

      //Form Validation
      if (!addressFormKey.currentState!.validate()) {
        AppFullscreenLoader.stopLoading();
        return;
      }

      //save Address data
      final address = AddressModel(
        id: '',
        name: name.text.trim(),
        phoneNumber: phoneNumber.text.trim(),
        street: street.text.trim(),
        city: city.text.trim(),
        state: state.text.trim(),
        postalCode: postalCode.text.trim(),
        country: country.text.trim(),
        selectedAddress: true,
      );

      final id = await addressRepository.addAddress(address);
      address.id = id;

      await selectAddress(address);

      //remove loader
      AppFullscreenLoader.stopLoading();

      //show success nessage
      AppLoaders.sucessSnackBar(
          title: 'Congratulations!',
          message: 'Your adress has been saved succesfully');

      //refresh address data
      refreshData.toggle();

      //reset fields
      resetFormFields();

      //redirect
      Navigator.of(Get.context!).pop();
    } catch (e) {
      AppFullscreenLoader.stopLoading();
      AppLoaders.errorSnackBar(
          title: 'Address not found', message: e.toString());
    }
  }

  void resetFormFields() {
    name.clear();
    phoneNumber.clear();
    street.clear();
    postalCode.clear();
    city.clear();
    state.clear();
    addressFormKey.currentState?.reset();
  }
}

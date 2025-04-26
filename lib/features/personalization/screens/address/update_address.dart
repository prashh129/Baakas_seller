import 'package:baakas_seller/features/personalization/models/address_model.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../common/widgets/appbar/appbar.dart';
import '../../../../utils/validators/validation.dart';
import '../../controllers/address_controller.dart';

class UpdateAddressScreen extends StatelessWidget {
  const UpdateAddressScreen({super.key, required this.address});

  final AddressModel address;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AddressController());
    controller.initUpdateAddressValues(address);
    return Scaffold(
      appBar: const BaakasAppBar(
        showBackArrow: true,
        title: Text('Update Address'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(BaakasSizes.defaultSpace),
          child: Form(
            key: controller.addressFormKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: controller.name,
                  validator:
                      (value) =>
                          BaakasValidator.validateEmptyText('Name', value),
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Iconsax.user),
                    labelText: 'Name',
                  ),
                ),
                const SizedBox(height: BaakasSizes.spaceBtwInputFields),
                TextFormField(
                  controller: controller.phoneNumber,
                  validator:
                      (value) => BaakasValidator.validateEmptyText(
                        'Phone Number',
                        value,
                      ),
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Iconsax.mobile),
                    labelText: 'Phone Number',
                  ),
                ),
                const SizedBox(height: BaakasSizes.spaceBtwInputFields),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: controller.street,
                        validator:
                            (value) => BaakasValidator.validateEmptyText(
                              'Street',
                              value,
                            ),
                        expands: false,
                        decoration: const InputDecoration(
                          labelText: 'Street',
                          prefixIcon: Icon(Iconsax.building_31),
                        ),
                      ),
                    ),
                    const SizedBox(width: BaakasSizes.spaceBtwInputFields),
                    Expanded(
                      child: TextFormField(
                        controller: controller.postalCode,
                        validator:
                            (value) => BaakasValidator.validateEmptyText(
                              'Postal Code',
                              value,
                            ),
                        expands: false,
                        decoration: const InputDecoration(
                          labelText: 'Postal Code',
                          prefixIcon: Icon(Iconsax.code),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: BaakasSizes.spaceBtwInputFields),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: controller.city,
                        validator:
                            (value) => BaakasValidator.validateEmptyText(
                              'City',
                              value,
                            ),
                        expands: false,
                        decoration: const InputDecoration(
                          labelText: 'City',
                          prefixIcon: Icon(Iconsax.building),
                        ),
                      ),
                    ),
                    const SizedBox(width: BaakasSizes.spaceBtwInputFields),
                    Expanded(
                      child: TextFormField(
                        controller: controller.state,
                        expands: false,
                        decoration: const InputDecoration(
                          labelText: 'State',
                          prefixIcon: Icon(Iconsax.activity),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: BaakasSizes.spaceBtwInputFields),
                TextFormField(
                  controller: controller.country,
                  validator:
                      (value) =>
                          BaakasValidator.validateEmptyText('Country', value),
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Iconsax.global),
                    labelText: 'Country',
                  ),
                ),
                const SizedBox(height: BaakasSizes.defaultSpace),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => controller.updateAddress(address),
                    child: const Text('Save'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

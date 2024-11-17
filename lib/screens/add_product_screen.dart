import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shop_ease/controllers/add_product_controller.dart';
import 'package:shop_ease/model/category_model.dart';
import 'package:shop_ease/resources/colors.dart';
import 'package:shop_ease/resources/dimensions.dart';
import 'package:shop_ease/widgets/app_background_widget.dart';
import 'package:shop_ease/widgets/custom_app_bar.dart';
import 'package:shop_ease/widgets/custom_button.dart';

class AddProductScreen extends StatelessWidget {
  final AddProductController controller = Get.put(AddProductController());

  AddProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      appBar: const CustomAppBar(title: "Add Product"),
      body: AppBackground(
        child: Padding(
          padding:   EdgeInsets.all(mobilePadding),
          child: Form(
            key: controller.formKey,
            child: ListView(
              children: [
              DropdownButtonFormField<Category>(
                    // value: controller.selectedCategory.value,
                    decoration: const InputDecoration(
                      labelText: 'Category',
                      border: OutlineInputBorder(),
                    ),
                    items: controller.categories.map((category) {
                      return DropdownMenuItem<Category>(
                        value: category,
                        child: Text(category.name),
                      );
                    }).toList(),
                    onChanged: (value) {
                      if (value != null) {
                        controller.productCodeController.text = value.codeNo;
                        controller.selectedCategory.value = value.name;
                      }
                    },
                    validator: (value) => value == null || value.id.isEmpty
                        ? 'Please select a category'
                        : null,
                  ),

                  SizedBox(height: 16.w),
                TextFormField(
                  controller: controller.productCodeController,
                  decoration: const InputDecoration(
                    labelText: 'Product Code',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) => value == null || value.isEmpty ? 'Please enter a product code' : null,
                ),
                  SizedBox(height: 16.w),
                TextFormField(
                  controller: controller.productNameController,
                  decoration: const InputDecoration(
                    labelText: 'Product Name',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) => value == null || value.isEmpty ? 'Please enter a product name' : null,
                ),
                  SizedBox(height: 16.w
                ),
                TextFormField(
                  controller: controller.productDescriptionController,
                  decoration: const InputDecoration(
                    labelText: 'Product Description',
                    border: OutlineInputBorder(),
                  ),
                  maxLines: 3,
                  validator: (value) => value == null || value.isEmpty ? 'Please enter a product description' : null,
                ),
                  SizedBox(height: 16.w),
                TextFormField(
                  controller: controller.productPriceController,
                  decoration: const InputDecoration(
                    labelText: 'Product Price',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) return 'Please enter a product price';
                    if (double.tryParse(value) == null) return 'Please enter a valid number';
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                Obx(() => Row(
                  children: [
                    ElevatedButton(
                      style: ButtonStyle(
                        foregroundColor: MaterialStateProperty.all(primaryColor),
                      ),  onPressed: controller.pickImage,
                      child: const Text('Upload Image',style: TextStyle(color: colorWhite),),
                    ),
                    const SizedBox(width: 16),
                    controller.productImagePath.isNotEmpty
                        ? Text('Image selected', style: TextStyle(color: Colors.green))
                        : Text('No image selected', style: TextStyle(color: Colors.red)),
                  ],
                )),
                const SizedBox(height: 24),
                InkWell(
                    onTap:  controller.isLoading.value ? null : controller.submitForm,
                    child: CustomButton(title: "Add Product",))
                // Obx(() => ElevatedButton(
                //   onPressed: controller.isLoading.value ? null : controller.submitForm,
                //   child: controller.isLoading.value
                //       ? const CircularProgressIndicator(color: Colors.white)
                //       : const Text('Add Product'),
                // )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

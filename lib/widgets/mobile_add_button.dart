import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shop_ease/controllers/cart_controller.dart';
import 'package:shop_ease/model/product_model.dart';
import 'package:shop_ease/widgets/mobile_button_add.dart';
import '../../resources/colors.dart';
import '../../resources/dimensions.dart';



class MobileAddButton extends StatelessWidget {
  final Product menuItem;


  MobileAddButton({Key? key, required this.menuItem,  })
      : super(key: key);


  @override
  Widget build(BuildContext context) {
    var itemCount = 0.obs;

    return Obx(() {
      return itemCount.value == 0
          ? MobileButtonAdd(onTap: (){})
          : Container(
        padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 8.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.w),
          color: primaryColor,
        ),
        child: Row(
          children: <Widget>[
            InkWell(
              onTap: () {
                if (itemCount.value > 0) {
                  itemCount.value--;
                }
              },
              child: Container(
                padding: EdgeInsets.all(7.w),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 1),
                ),
                child: Text(
                  "−",
                  style: TextStyle(   fontSize: 18.sp,
                    color: colorMediumGrey,)

                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.w),
              child: Text(
                '$itemCount',
                  style: TextStyle(   fontSize: 18.sp,
                    color: colorMediumGrey,)
              ),
            ),
            InkWell(
              onTap: () {
                itemCount.value++;
              },
              child: Container(
                padding: EdgeInsets.all(7.w),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 1),
                ),
                child: Text(
                  "+",
                    style: TextStyle(   fontSize: 18.sp,
                      color: colorMediumGrey,)
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}

class ItemsBottomSheet extends StatelessWidget {
  final Product menuItem;
  final RxInt itemCount;
  final String bookingDate;

  ItemsBottomSheet(
      {Key? key, required this.menuItem, required this.itemCount, this.bookingDate = ''})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(mobilePadding),
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(10))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 60.w),
                Row(
                  children: [
                    const SizedBox(width: 20),
                    Text(
                      menuItem.productName ?? '',
                      maxLines: 1,
                        style: TextStyle(   fontSize: 18.sp,
                          color: colorMediumGrey,)
                    ),
                    const Spacer(),
                    IconButton(
                      onPressed: () {
                        Get.back();
                      },
                      icon: const Icon(Icons.close),
                    ),
                  ],
                ),
                const Divider(color: Colors.grey),
                SizedBox(height: 100.w),
                // You can add more content here if needed
              ],
            ),
          ),
        ),
      ],
    );
  }
}

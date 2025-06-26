import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shopping_app/utils/AppTextFile.dart';
import 'package:shopping_app/utils/appconstant.dart';

import '../Network/CartController.dart';
import '../Screen/User-panel/checkoutbottonSheet.dart';
import '../services/GetCustomerToken.dart';
import '../services/getDeviceToken.dart';
import 'button.dart';

class CartCheckoutBar extends StatefulWidget {
   CartCheckoutBar({super.key});

  @override
  State<CartCheckoutBar> createState() => _CartCheckoutBarState();
}

class _CartCheckoutBarState extends State<CartCheckoutBar> {
  CartController cartController = Get.put(CartController());
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final addressController = TextEditingController();
  bool isNameEmpty = false;
  bool isPhoneEmpty = false;
  bool isAddressEmpty = false;

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    addressController.dispose();
    super.dispose();
  }

  void validateAndSubmit() {
    setState(() {
      isNameEmpty = nameController.text.isEmpty;
      isPhoneEmpty = phoneController.text.isEmpty;
      isAddressEmpty = addressController.text.isEmpty;
    });
    }
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        // Subtotal Row
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Obx(() => RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'Subtotal : ',
                      style: TextStyle(fontSize: 16, color: Colors.black),
                    ),
                    TextSpan(
                      text: '${cartController.sum.value}\n',
                      style: AppTextStyles.priceStyle,
                    ),
                    WidgetSpan(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 70),
                        child: Text(
                          'Shipping from Rs. 420',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )),



              Spacer(),
              CustomButton(
                text: 'Check Out',
                color: Colors.deepOrange,
                onPressed: () {
                  showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      builder: (context) => Padding(
                    padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom,
                      left: 16,
                      right: 16,
                      top: 16,
                    ),
                    child: StatefulBuilder(
                      builder: (context, setModalState) => SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Text('Enter your Payment Details',style: AppTextStyles.priceStyle,),
                            SizedBox(height: 8.0),

                            TextField(
                              controller: nameController,
                              decoration: InputDecoration(
                                labelText: 'Full Name',
                                border: OutlineInputBorder(),
                              ),
                            ),
                            if (isNameEmpty)
                              Text("Name is required", style: TextStyle(color: Colors.red, fontSize: 12)),
                            SizedBox(height: 12),

                            TextField(
                              controller: phoneController,
                              decoration: InputDecoration(
                                labelText: 'Phone Number',
                                border: OutlineInputBorder(),
                              ),
                            ),
                            if (isPhoneEmpty)
                              Text("Phone number is required", style: TextStyle(color: Colors.red, fontSize: 12)),
                            SizedBox(height: 12),

                            TextField(
                              controller: addressController,
                              decoration: InputDecoration(
                                labelText: 'Address',
                                border: OutlineInputBorder(),
                              ),
                            ),
                            if (isAddressEmpty)
                              Text("Address is required", style: TextStyle(color: Colors.red, fontSize: 12)),
                            SizedBox(height: 12),

                            CustomButton(
                              text: 'Place Order',
                              color: Colors.deepOrange,
                              font: 16,
                              width: double.infinity,
                              onPressed: () async {
                                setState(() {
                                  isNameEmpty = nameController.text.isEmpty;
                                  isPhoneEmpty = phoneController.text.isEmpty;
                                  isAddressEmpty = addressController.text.isEmpty;
                                });
                                String tokenId = await CustomerToken().getCustomerDeviceToken();
                                OrderService  _OrderService =  OrderService(customerName: nameController.text.toString(), customerAddress: addressController.text.toString() , customerDeviceToken: tokenId, customerPhone: phoneController.text.toString());
                                _OrderService.placeOrder();
                                validateAndSubmit();

                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ));

                },
                width: 120,
              ),

            ],
          ),
        ),

        // Shipping Fee


        // You can continue with scrollable cart items here
      ],
    );

  }
}


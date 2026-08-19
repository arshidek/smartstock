import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../app/app_navigation.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/utils/validator.dart';
import '../../../core/widgets/buttons/app_button.dart';
import '../../../core/widgets/buttons/app_outline_button.dart';
import '../../../core/widgets/cards/app_card_widget.dart';
import '../../../core/widgets/dropdowns/app_custom_dropdown.dart';
import '../../../core/widgets/textfields/app_custom_text_field.dart';
import '../../../data/models/sale_item_model.dart';
import '../function/sale_functions.dart';
import '../widgets/cart_item_card.dart';
import 'add_product_to_sale_screen.dart';

class AddSaleScreen extends StatefulWidget {
  const AddSaleScreen({super.key});

  @override
  State<AddSaleScreen> createState() => _AddSaleScreenState();
}

class _AddSaleScreenState extends State<AddSaleScreen> {
  final _formKey = GlobalKey<FormState>();
  final SaleFunctions saleFunctions = SaleFunctions();
  final TextEditingController noteController = TextEditingController();
  final TextEditingController customerNameController = TextEditingController();
  final TextEditingController customerPhoneController = TextEditingController();
  final TextEditingController customerEmailController = TextEditingController();
  final TextEditingController customerAddressController =
      TextEditingController();

  // Sample products in cart
  List<SaleItemModel> cartItems = [];
  String? selectedPaymentMethod = "Cash";
  DateTime selectedSaleDate = DateTime.now();
  double discountPercentage = 5.0;

  @override
  void dispose() {
    customerNameController.dispose();
    customerPhoneController.dispose();
    customerEmailController.dispose();
    customerAddressController.dispose();
    noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final subtotal = saleFunctions.getSubtotal(cartItems);

    final discountAmount = saleFunctions.getDiscount(
      cartItems,
      discountPercentage,
    );

    final grandTotal = saleFunctions.getGrandTotal(
      cartItems,
      discountPercentage,
    );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.appBarColor,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: AppColors.black,
            size: AppSizes.size30,
          ),
          onPressed: () => AppNavigation.goBack(context),
        ),
        title: const Text(
          'Add Sale',
          style: TextStyle(
            color: AppColors.black,
            fontWeight: FontWeight.bold,
            fontSize: AppSizes.size25,
          ),
        ),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(gradient: AppColors.background),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Column(
              children: [
                // ==========================
                // Customer Details
                // ==========================
                const SizedBox(height: AppSizes.size20),

                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSizes.padding16,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      FittedBox(
                        fit: BoxFit.scaleDown,
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Products Added (${cartItems.length})",
                          style: const TextStyle(
                            fontSize: AppSizes.font18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: AppSizes.size20),

                // ==========================
                // Cart Items
                // ==========================
                if (cartItems.isEmpty)
                  AppCardWidget(
                    margin: const EdgeInsets.symmetric(
                      horizontal: AppSizes.padding16,
                    ),
                    child: Container(
                      width: double.infinity,
                      child: Column(
                        children: [
                          const Icon(
                            Icons.shopping_cart_outlined,
                            size: AppSizes.size60,
                            color: AppColors.grey,
                          ),

                          const SizedBox(height: AppSizes.size15),

                          const Text(
                            "No Products Added",
                            style: TextStyle(
                              fontSize: AppSizes.font20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          const SizedBox(height: AppSizes.size10),

                          const Text(
                            "Tap the 'Add Product' button below to add products to this sale.",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: AppSizes.font16,
                              color: AppColors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                else
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSizes.padding16,
                    ),
                    itemCount: cartItems.length,
                    itemBuilder: (context, index) {
                      final item = cartItems[index];

                      return Padding(
                        padding: const EdgeInsets.only(
                          bottom: AppSizes.padding10,
                        ),
                        child: CartItemCard(
                          item: item,
                          onQuantityChanged: (change) {
                            setState(() {
                              saleFunctions.updateQuantity(
                                cartItems,
                                index,
                                change,
                              );
                            });
                          },
                          onRemove: () {
                            setState(() {
                              saleFunctions.removeItem(cartItems, index);
                            });
                          },
                        ),
                      );
                    },
                  ),

                // ==========================
                // Add Product
                // ==========================
                const SizedBox(height: AppSizes.size20),

                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSizes.padding16,
                  ),
                  child: AppButton(
                    text: "Add Product",
                    icon: Icons.add,
                    backgroundColor: AppColors.blue,
                    textColor: AppColors.white,
                    iconColor: AppColors.white,
                    onPressed: () async {
                      final result = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              AddProductToSaleScreen(saleItems: cartItems),
                        ),
                      );

                      if (result != null && result is List<SaleItemModel>) {
                        setState(() {
                          cartItems = result;
                        });
                      }
                    },
                  ),
                ),

                const SizedBox(height: AppSizes.size20),

                // ==========================
                // Summary
                // ==========================
                AppCardWidget(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /// Header
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(
                                  Icons.receipt_long_outlined,
                                  color: AppColors.blue,
                                  size: AppSizes.size25,
                                ),
                                const SizedBox(width: AppSizes.size10),
                                Flexible(
                                  child: FittedBox(
                                    fit: BoxFit.scaleDown,
                                    alignment: Alignment.centerLeft,
                                    child: const Text(
                                      "Order Summary",
                                      style: TextStyle(
                                        fontSize: AppSizes.font20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(width: 8),

                          Flexible(
                            child: InkWell(
                              borderRadius: BorderRadius.circular(8),
                              onTap: () async {
                                final pickedDate = await showDatePicker(
                                  context: context,
                                  initialDate: selectedSaleDate,
                                  firstDate: DateTime(2024),
                                  lastDate: DateTime.now(),
                                );

                                if (pickedDate != null) {
                                  setState(() {
                                    selectedSaleDate = pickedDate;
                                  });
                                }
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 8,
                                ),
                                decoration: BoxDecoration(
                                  color: AppColors.blue.withOpacity(.08),
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                    color: AppColors.blue.withOpacity(.25),
                                  ),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Flexible(
                                      child: FittedBox(
                                        fit: BoxFit.scaleDown,
                                        child: Row(
                                          children: [
                                            const Icon(
                                              Icons.calendar_today_outlined,
                                              size: AppSizes.size15,
                                              color: AppColors.blue,
                                            ),
                                            const SizedBox(width: 6),
                                            Text(
                                              "${selectedSaleDate.day}/${selectedSaleDate.month}/${selectedSaleDate.year}",
                                              style: const TextStyle(
                                                color: AppColors.blue,
                                                fontWeight: FontWeight.w600,
                                                fontSize: 13,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: AppSizes.size25),

                      _buildSummaryRow(
                        "Subtotal (${cartItems.length} Items)",
                        "₹${subtotal.toStringAsFixed(0)}",
                      ),

                      const SizedBox(height: AppSizes.size10),

                      _buildSummaryRow(
                        "Discount",
                        "- ₹${discountAmount.toStringAsFixed(0)}",
                        isDiscount: true,
                      ),

                      const Divider(height: AppSizes.size30),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              alignment: Alignment.centerLeft,
                              child: const Text(
                                "Grand Total",
                                style: TextStyle(
                                  fontSize: AppSizes.font20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          Flexible(
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              alignment: Alignment.centerRight,
                              child: Text(
                                "₹${grandTotal.toStringAsFixed(0)}",
                                style: const TextStyle(
                                  color: AppColors.success,
                                  fontSize: AppSizes.font24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: AppSizes.size25),

                      /// Payment Method
                      AppCustomDropdown.dropdown<String>(
                        label: "Payment Method",
                        icon: Icons.payments_outlined,
                        value: selectedPaymentMethod,
                        items: const [
                          DropdownMenuItem(value: "Cash", child: Text("Cash")),
                          DropdownMenuItem(value: "UPI", child: Text("UPI")),
                          DropdownMenuItem(value: "Card", child: Text("Card")),
                        ],
                        onChanged: (value) {
                          setState(() {
                            selectedPaymentMethod = value!;
                          });
                        },
                      ),

                      const SizedBox(height: AppSizes.size20),

                      /// Note
                      AppCustomTextField.textField(
                        controller: noteController,
                        label: "Note",
                        hint: "Add customer note",
                        icon: Icons.edit_note_outlined,
                        maxLines: 3,
                        validator: (value) => null,
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: AppSizes.size30),

                AppCardWidget(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        FittedBox(
                          fit: BoxFit.scaleDown,
                          alignment: Alignment.centerLeft,
                          child: const Row(
                            children: [
                              Icon(
                                Icons.person_outline,
                                color: AppColors.blue,
                                size: AppSizes.size25,
                              ),
                              SizedBox(width: AppSizes.size10),
                              Text(
                                "Customer Details",
                                style: TextStyle(
                                  fontSize: AppSizes.font20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),

                        SizedBox(height: AppSizes.size20),

                        AppCustomTextField.textField(
                          controller: customerNameController,
                          label: "Customer Name",
                          hint: "Enter customer name",
                          icon: Icons.person_outline,
                          validator: (value) => Validator.validateName(
                            value,
                            fieldName: "Customer Name",
                          ),
                        ),

                        SizedBox(height: AppSizes.size15),

                        AppCustomTextField.textField(
                          controller: customerPhoneController,
                          label: "Phone Number",
                          hint: "Enter phone number",
                          icon: Icons.phone_outlined,
                          keyboardType: TextInputType.phone,

                          validator: Validator.validatePhone,

                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            LengthLimitingTextInputFormatter(10),
                          ],
                        ),

                        SizedBox(height: AppSizes.size15),

                        AppCustomTextField.textField(
                          controller: customerEmailController,
                          label: "Email Address",
                          hint: "Enter email (Optional)",
                          icon: Icons.email_outlined,
                          keyboardType: TextInputType.emailAddress,
                          validator: Validator.validateOptionalEmail,
                        ),

                        SizedBox(height: AppSizes.size15),

                        AppCustomTextField.textField(
                          controller: customerAddressController,
                          label: "Address",
                          hint: "Enter customer address",
                          icon: Icons.location_on_outlined,
                          maxLines: 3,
                          validator: (value) => Validator.validateDescription(
                            value,
                            fieldName: "Address",
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: AppSizes.size30),

                // ==========================
                // Buttons
                // ==========================
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSizes.padding16,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: AppOutlineButton(
                          text: "Clear Cart",
                          icon: Icons.delete_outline,
                          borderColor: AppColors.error,
                          textColor: AppColors.error,
                          iconColor: AppColors.error,
                          onPressed: () {
                            saleFunctions.clearCart(
                              context: context,
                              cartItems: cartItems,
                              noteController: noteController,
                              refresh: () {
                                setState(() {});
                              },
                            );
                          },
                        ),
                      ),

                      const SizedBox(width: AppSizes.size10),

                      Expanded(
                        child: AppButton(
                          text: "Save Sale",
                          icon: Icons.shopping_cart_checkout,
                          backgroundColor: AppColors.blue,
                          textColor: AppColors.white,
                          iconColor: AppColors.white,
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              await saleFunctions.saveSale(
                                context: context,
                                cartItems: cartItems,

                                customerNameController: customerNameController,
                                customerPhoneController:
                                    customerPhoneController,
                                customerEmailController:
                                    customerEmailController,
                                customerAddressController:
                                    customerAddressController,

                                noteController: noteController,

                                paymentMethod: selectedPaymentMethod!,
                                saleDate: selectedSaleDate,

                                refresh: () {
                                  setState(() {});
                                },
                              );
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: AppSizes.size25),
              ],
            ),
          ),
        ),
      ),

      // Bottom Bar
    );
  }

  Widget _buildSummaryRow(
    String label,
    String value, {
    bool isDiscount = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: FittedBox(
              fit: BoxFit.scaleDown,
              alignment: Alignment.centerLeft,
              child: Text(label, style: const TextStyle(color: AppColors.grey)),
            ),
          ),
          Flexible(
            child: FittedBox(
              fit: BoxFit.scaleDown,
              alignment: Alignment.centerRight,
              child: Text(
                value,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: isDiscount ? AppColors.success : AppColors.black,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

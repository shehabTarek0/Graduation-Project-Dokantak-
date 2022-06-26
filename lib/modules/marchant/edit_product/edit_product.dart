import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:g_project/layout/appmarchant_layout/cubit/cubit.dart';
import 'package:g_project/layout/appmarchant_layout/cubit/states.dart';
import 'package:g_project/layout/appmarchant_layout/marchant_layout.dart';
import 'package:g_project/shared/component/component.dart';
import 'package:g_project/shared/component/constants.dart';
import 'package:snippet_coder_utils/FormHelper.dart';

class EditProduct extends StatelessWidget {
  const EditProduct(int i, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    List<dynamic> categories =
        MarCubit.get(context).category!.toJson().entries.elementAt(1).value;
    return BlocConsumer<MarCubit, MarStates>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              elevation: 2,
              centerTitle: true,
              title: const Text(
                'Edit Products',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  letterSpacing: 2.5,
                ),
              ),
            ),
            body: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      defaultFormField(
                        text: 'Product Name',
                        controller: productNameController,
                        type: TextInputType.text,
                        validator: (value) {
                          if (value.toString().isEmpty) {
                            return 'please enter your Product Name';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 25),
                      defaultFormField(
                        text: 'Price',
                        controller: productPriceController,
                        type: TextInputType.number,
                        validator: (value) {
                          if (value.toString().isEmpty) {
                            return 'please enter your Product Name';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 25),
                      defaultFormField(
                          text:
                              'Description (Shop Name , phone number , Address , Product description)',
                          controller: productDesController,
                          type: TextInputType.text,
                          validator: (value) {
                            if (value.toString().isEmpty) {
                              return 'please enter your Product Name';
                            }
                            return null;
                          },
                          numOfLines: 5),
                      const SizedBox(height: 30),
                      FormHelper.dropDownWidget(
                          context, 'Select Category Type', idc, categories,
                          (on) {
                        idc = on;
                      }, (val) {
                        if (val == null) {
                          return 'please select Category';
                        }
                        return null;
                      },
                          borderColor: Colors.black,
                          borderRadius: 10,
                          borderWidth: 10,
                          paddingLeft: 0,
                          paddingRight: 0,
                          hintFontSize: 17,
                          contentPadding: 10,
                          borderFocusColor: Colors.grey,
                          textColor: Colors.black),
                      const SizedBox(height: 30),
                      defaultButton(
                          function: () async {
                            if (formKey.currentState!.validate()) {
                              formKey.currentState!.save();
                              MarCubit.get(context).editProduct(
                                  id: 97,
                                  productN: productNameController.text,
                                  productD: productDesController.text,
                                  productP: productPriceController.text,
                                  catId: idc!);
                              navigateAndFinish(context, const MarLayout());
                            }
                          },
                          text: 'Edit Product',
                          isUpperCase: false,
                          background: const Color.fromARGB(255, 86, 127, 113),
                          style: const TextStyle(
                              fontSize: 22,
                              color: Color.fromARGB(255, 255, 254, 254)))
                    ],
                  ),
                ),
              ),
            ),
          );
        },
        listener: (context, state) {});
  }
}

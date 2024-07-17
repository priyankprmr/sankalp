import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sankalp/Auth/Providers/user_id_provider.dart';
import 'package:sankalp/Dispatch/Models/Dispatch/create_dispatch_data.dart';
import 'package:sankalp/Dispatch/Models/get_pack_data_response.dart';
import 'package:sankalp/Dispatch/Models/product.dart';
import 'package:sankalp/Dispatch/Providers/product_list_provider.dart';
import 'package:sankalp/Dispatch/Utils/dispatch_screen_stream_controller.dart';
import 'package:sankalp/Dispatch/Viewmodels/dispatch_viewmodel.dart';
import 'package:sankalp/Dispatch/Providers/has_text_providers.dart';
import 'package:sankalp/Utils/design_const.dart';
import 'package:sankalp/Utils/string_const.dart';
import 'package:simple_barcode_scanner/simple_barcode_scanner.dart';

class CreateDispatchScreen extends ConsumerStatefulWidget {
  const CreateDispatchScreen({super.key});

  @override
  ConsumerState<CreateDispatchScreen> createState() =>
      _CreateDispatchScreenState();
}

class _CreateDispatchScreenState extends ConsumerState<CreateDispatchScreen> {
  final _scrollController = ScrollController();
  TextEditingController barcodeController = TextEditingController();
  TextEditingController typeController = TextEditingController(text: 'Case');
  TextEditingController orderIdController = TextEditingController();
  TextEditingController invoiceNoController = TextEditingController();
  TextEditingController partyNameController = TextEditingController();
  TextEditingController noteController = TextEditingController();
  List<TextEditingController> qtyControllers = [];
  late DispatchScreenStreamController hasTextStreamController;
  Map<String, int> types = {"Case": 0, "Individual": 1};

  @override
  void initState() {
    final controller = StreamController<bool>();
    hasTextStreamController = DispatchScreenStreamController(
      controller: controller,
    );
    super.initState();
  }

  @override
  void dispose() {
    hasTextStreamController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          elevation: 0,
          title: const Text(
            "Create Dispatch",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
            textScaler: TextScaler.linear(1.3),
          ),
        ),
        body: Stack(
          fit: StackFit.expand,
          children: [
            SingleChildScrollView(
              controller: _scrollController,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0)
                    .copyWith(bottom: 70),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(
                      height: 10.0,
                    ),
                    const Text(
                      StringConst.type,
                    ),
                    const SizedBox(
                      height: 5.0,
                    ),
                    DropdownButtonFormField(
                      value: typeController.text,
                      items: types.entries
                          .map(
                            (e) => DropdownMenuItem<String>(
                              value: e.key,
                              child: Text(e.key),
                            ),
                          )
                          .toList(),
                      onChanged: (value) {
                        typeController.text = value ?? '';
                      },
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    const Text(
                      StringConst.orderId,
                    ),
                    const SizedBox(
                      height: 5.0,
                    ),
                    TextFormField(
                      controller: orderIdController,
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    const Text(
                      StringConst.invoiceNO,
                    ),
                    const SizedBox(
                      height: 5.0,
                    ),
                    TextFormField(
                      controller: invoiceNoController,
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    const Text(
                      StringConst.partyName,
                    ),
                    const SizedBox(
                      height: 5.0,
                    ),
                    TextFormField(
                      controller: partyNameController,
                    ),
                    const SizedBox(
                      height: 15.0,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: barcodeController,
                            decoration: const InputDecoration(
                              labelText: StringConst.barcodeScan,
                            ),
                            onChanged: (value) {
                              if (value.isNotEmpty) {
                                hasTextStreamController.add(true);
                              } else {
                                hasTextStreamController.add(false);
                              }
                            },
                          ),
                        ),
                        const SizedBox(
                          width: 10.0,
                        ),
                        Expanded(
                          child: SizedBox(
                            height: 60.0,
                            child: barcodeButton(),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    productList()
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 10.0,
              right: 10.0,
              left: 10.0,
              child: SizedBox(
                height: 60.0,
                child: ElevatedButton(
                  onPressed: () async {
                    showModalBottomSheet(
                      context: context,
                      isDismissible: false,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(15.0),
                        ),
                      ),
                      builder: (context) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0).copyWith(
                              bottom: MediaQuery.of(context).viewInsets.bottom),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Text(
                                "Add Note",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                                textScaler: TextScaler.linear(1.3),
                              ),
                              const SizedBox(
                                height: 10.0,
                              ),
                              TextFormField(
                                controller: noteController,
                                maxLines: 6,
                              ),
                              const SizedBox(
                                height: 10.0,
                              ),
                              ElevatedButton(
                                onPressed: () async {
                                  Navigator.of(context).pop();
                                },
                                child: const Text("Create"),
                              ),
                            ],
                          ),
                        );
                      },
                    ).then(
                      (value) {
                        final userId = ref.read(userIdProvider)!;
                        final productsList =
                            ref.read(productListProvider).productList;
                        final data = CreateDispatchData(
                          type: typeController.text == 'Case' ? 0 : 1,
                          orderId: orderIdController.text,
                          invoiceNo: invoiceNoController.text,
                          partyName: partyNameController.text,
                          barcodeScan: barcodeController.text,
                          id: userId,
                          item: [...productsList.map((e) => e.productCode)],
                          intItemId: [...productsList.map((e) => e.id)],
                          qty: [...qtyControllers.map((e) => e.text)],
                          caseNo: [...productsList.map((e) => e.caseNo)],
                          batchNumber: [...productsList.map((e) => e.batchNo)],
                          note: noteController.text,
                          mode: "add",
                        );
                        noteController.clear();
                        createDispatch(data);
                      },
                    );
                  },
                  child: const Text("Create"),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget productList() {
    return Consumer(
      builder: (context, ref, child) {
        final productList = ref.watch(productListProvider).productList;
        debugPrint("PRODUCT LIST-->$productList");
        if (productList.isEmpty) {
          return const Center(
            child: Text(
              "No data",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
          );
        } else {
          return ListView.builder(
            shrinkWrap: true,
            itemCount: productList.length,
            controller: _scrollController,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (BuildContext context, int index) {
              final product = productList.elementAt(index);
              return Dismissible(
                key: UniqueKey(),
                onDismissed: (direction) {
                  qtyControllers.removeAt(index);
                  ref.read(productListProvider).remove(index);
                },
                child: Card(
                  elevation: 3,
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      DesignConst.borderRadius,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Text(
                                product.productCode,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(
                                height: 5.0,
                              ),
                              Text(
                                product.caseNo,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(
                                height: 5.0,
                              ),
                              Text(
                                product.batchNo,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(
                                height: 5.0,
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: TextFormField(
                            controller: qtyControllers.elementAt(index),
                            decoration: const InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              labelText: StringConst.qty,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        }
      },
    );
  }

  Widget barcodeButton() {
    return ref
        .watch(hasTextStreamProvider(hasTextStreamController.controller))
        .when(
          data: (hasText) {
            if (hasText) {
              return ElevatedButton(
                onPressed: () async {
                  if (barcodeController.text.isNotEmpty) {
                    getPackData(barcodeController.text);
                    barcodeController.clear();
                    hasTextStreamController.add(false);
                  }
                },
                child: const Text("Enter"),
              );
            } else {
              return ElevatedButton(
                onPressed: () async {
                  var res = await Navigator.push<String>(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SimpleBarcodeScannerPage(),
                    ),
                  );
                  debugPrint("Res-->$res");
                  if (res != null && res.isNotEmpty && res != '-1') {
                    barcodeController.text = res;
                    getPackData(res);
                  }
                },
                child: const Icon(
                  Icons.barcode_reader,
                ),
              );
            }
          },
          error: (error, stackTrace) => const SizedBox(),
          loading: () => const CircularProgressIndicator(),
        );
  }

  void getPackData(String barcode) async {
    final packData = await DispatchViewmodel().getPackData(
      barcode: barcode,
    );
    if (packData != null && packData.count != 0) {
      setPackData(packData);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          elevation: 4,
          backgroundColor: Colors.red,
          content: Text(
            "Something went wrong !! Please try again.",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      );
    }
  }

  void setPackData(GetPackDataResponse packData) {
    final product = Product(
      productCode: packData.productName ?? '',
      caseNo: packData.boxCode ?? '',
      batchNo: packData.batchNumber ?? '',
      qty: packData.productQty.toString(),
      id: packData.productId.toString(),
    );
    qtyControllers.add(
      TextEditingController(
        text: packData.productQty.toString(),
      ),
    );
    ref.read(productListProvider.notifier).add(product);
  }

  void createDispatch(CreateDispatchData data) {
    // debugPrint("Data-->${jsonEncode(data)}");
    final viewmodel = DispatchViewmodel();
    viewmodel.createDispatch(createDispatchData: data).then(
      (value) {
        if (value == null) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Something went wrong!!!"),
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(value.message ?? ''),
            ),
          );
          Navigator.of(context).pop();
        }
      },
    );
  }
}

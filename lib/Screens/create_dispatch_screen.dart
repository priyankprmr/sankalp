import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sankalp/Domain/Models/product.dart';
import 'package:sankalp/Domain/Viewmodels/dispatch_viewmodel.dart';
import 'package:sankalp/Providers/has_text_providers.dart';
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
  TextEditingController typeController = TextEditingController();
  TextEditingController orderIdController = TextEditingController();
  TextEditingController invoiceNoController = TextEditingController();
  TextEditingController partyNameController = TextEditingController();
  List<Product> productsList = [];
  StreamController<bool> hasTextStreamController = StreamController<bool>();

  @override
  void initState() {
    hasTextStreamController.sink.add(false);
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
          children: [
            SingleChildScrollView(
              controller: _scrollController,
              child: SizedBox(
                height: MediaQuery.sizeOf(context).height,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
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
                      TextFormField(
                        controller: typeController,
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
                                  hasTextStreamController.sink.add(true);
                                } else {
                                  hasTextStreamController.sink.add(false);
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
                              child: Consumer(
                                builder: (context, ref, child) {
                                  return ref
                                      .watch(
                                        hasTextStreamProvider(
                                          hasTextStreamController,
                                        ),
                                      )
                                      .when(
                                        data: (data) {
                                          debugPrint("Has Text-->$data");
                                          if (data) {
                                            return ElevatedButton(
                                              onPressed: () async {
                                                productsList.add(
                                                  const Product(
                                                    productCode: '123456',
                                                    caseNo: '123',
                                                    batchNo: '456',
                                                    qty: 10,
                                                  ),
                                                );
                                                setState(() {});
                                              },
                                              child: const Text("Enter"),
                                            );
                                          } else {
                                            return ElevatedButton(
                                              onPressed: () async {
                                                var res = await Navigator.push<
                                                    String>(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        const SimpleBarcodeScannerPage(),
                                                  ),
                                                );
                                                if (res != null &&
                                                    res.isNotEmpty) {
                                                final packData = await  DispatchViewmodel()
                                                      .getPackData(
                                                    barcode: res,
                                                  );
                                                  if (packData != null) {
                                                     productsList.add(
                                                       Product(
                                                        productCode: packData.productName??'',
                                                        caseNo: packData.boxCode??'',
                                                        batchNo: packData.batchNumber??'',
                                                        qty: packData.productQty??0,
                                                      ),
                                                    );
                                                    setState(() {});
                                                  }
                                                }
                                                
                                              },
                                              child: const Icon(
                                                Icons.barcode_reader,
                                              ),
                                            );
                                          }
                                        },
                                        error: (error, stackTrace) =>
                                            const SizedBox(),
                                        loading: () =>
                                            const CircularProgressIndicator(),
                                      );
                                },
                              ),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      productsList.isEmpty
                          ? const Center(
                              child: Text(
                                "No data",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            )
                          : ListView.builder(
                              shrinkWrap: true,
                              itemCount: productsList.length,
                              controller: _scrollController,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (BuildContext context, int index) {
                                final product = productsList.elementAt(index);
                                return Card(
                                  elevation: 3,
                                  color: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        DesignConst.borderRadius),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.stretch,
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
                                            controller: TextEditingController(
                                              text: product.qty.toString(),
                                            ),
                                            decoration: const InputDecoration(
                                              filled: true,
                                              fillColor: Colors.white,
                                              labelText: StringConst.qty,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 10.0,
              right: 10.0,
              left: 10.0,
              child: SizedBox(
                height: 50.0,
                child: ElevatedButton(
                  onPressed: () async {},
                  child: const Text("Create"),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:sankalp/Dispatch/Models/Dispatch/create_dispatch_data.dart';
import 'package:sankalp/Dispatch/Models/Dispatch/create_dispatch_response.dart';
import 'package:sankalp/Dispatch/Models/get_pack_data_response.dart';
import 'package:sankalp/Dispatch/Services/dispatch_service.dart';
import 'package:sankalp/Utils/api_result.dart';

class DispatchViewmodel {
  Future<GetPackDataResponse?> getPackData({required String barcode}) async {
    final response = await DispatchService.getPackData(barcode: barcode);
    if (response is Success<GetPackDataResponse>) {
      return response.response;
    } else {
      return null;
    }
  }

  Future<CreateDispatchResponse?> createDispatch({
    required CreateDispatchData createDispatchData,
  }) async {
    final response = await DispatchService.createDispatch(
        createDispatchData: createDispatchData);
       if (response is Success<CreateDispatchResponse>) {
      return response.response;
    } else {
      return null;
    } 
  }
}

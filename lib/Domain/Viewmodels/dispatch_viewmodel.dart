import 'package:sankalp/Domain/Models/get_pack_data_response.dart';
import 'package:sankalp/Domain/Services/dispatch_service.dart';
import 'package:sankalp/Utils/api_result.dart';

class DispatchViewmodel {
  Future<GetPackDataResponse?> getPackData({required String barcode}) async {
    final response = await DispatchService.getPackData(barcode: barcode);
    if (response is Success<GetPackDataResponse>) {
      return response.response;
    }else{
    return null;

    }
  }
}

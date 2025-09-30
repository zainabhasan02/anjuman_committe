import '../../app_url/app_url.dart';
import '../../data/network/network_api_services.dart';

class LoginRepository {
  final apiServices = NetworkApiServices();

  Future<dynamic> loginApi(var data) async {
    final response = await apiServices.postApi(data, AppUrl.loginApi);
    return response;
  }
}

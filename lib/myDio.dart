import 'package:connectivity/connectivity.dart';
import 'package:dio/dio.dart';

myDio({
   String? url,
   String? methodType,
  dynamic dioBody,
  Map<String, dynamic>? dioHeaders,
   String? appLanguage,
}) async {
  var response;
  bool isSocketException = false;

  var connectivityResult = await (Connectivity().checkConnectivity());
  if (connectivityResult == ConnectivityResult.mobile ||
      connectivityResult == ConnectivityResult.wifi) {
    try {
      if (methodType == 'get') {
        response = await Dio()
            .get(
          url!,
          queryParameters: dioBody,
          options: Options(
              headers: dioHeaders,
              validateStatus: (status) => status! >= 200 && status <= 500),
        )
            .catchError((onError) {
          isSocketException = true;
        });

        // print('response is >>> '+response.toString());
      } else if (methodType == 'post') {
        response = await Dio()
            .post(url!,
                queryParameters: dioBody,
                options: Options(
                    headers: dioHeaders,
                    validateStatus: (status) =>
                        status! >= 200 && status <= 500))
            .catchError((onError) {
          isSocketException = true;
        });

        print('Response is >>> ' + response.data.toString());
      }

      if (response.statusCode >= 200 && response.statusCode <= 299) {
        return responsMap(
            status: response.data['status'],
            message: response.data['message'],
            data: response.data['data']);
      } else if (response.statusCode >= 500) {
        return responsMap(
            status: false, message: serverErrorError(appLanguage!));
      } else if (isSocketException) {
        return responsMap(
            status: false, message: weakInternetError(appLanguage!));
      } else if (response.statusCode >= 400 && response.statusCode <= 499) {
        return responsMap(
            status: false,
            message: response.data['message'],
            data: response.data['data']);
      } else {
        return responsMap(
            status: false, message: globalError(appLanguage!), data: null);
      }
    } catch (e) {
      print('its Error Mohamed >>>> ' + e.toString());
      return responsMap(
          status: false, message: globalError(appLanguage!), data: null);
    }
  } else {
    return responsMap(
        status: false, message: noInternetsError(appLanguage!), data: null);
  }
}

String missingParameterError(String appLanguage) {
  return appLanguage == 'ar'
      ? 'يوجد حقل ناقص ومطلوب برجاء مراجعه الداله مره اخري'
      : 'There is an incomplete field and it is required, please check the function again';
}

String globalError(String appLanguage) {
  return appLanguage == 'ar'
      ? '! حدث خطأ يرجي التأكد من الانترنت اولا او مراجعه اداره التطبيق'
      : 'An error occurred, please check the internet first or review the application administration !';
}

String noInternetsError(String appLanguage) {
  return appLanguage == 'ar'
      ? 'برجاء الإتصال بالإنترنت !'
      : 'Please Connect to Internet !';
}

String weakInternetError(String appLanguage) {
  return appLanguage == 'ar'
      ? 'إشارة الإنترنت ضعيفة !'
      : 'Internet signal weak !';
}

String serverErrorError(String appLanguage) {
  return appLanguage == 'ar'
      ? 'يوجد مشكلة فى السيرفر برجاء مراجعة إدارة التطبيق'
      : 'There is a problem with the server, please check the application management';
}

Map<dynamic, dynamic> responsMap(
    {bool? status, String? message, dynamic data}) {
  return {"status": status, "message": message, "data": data};
}

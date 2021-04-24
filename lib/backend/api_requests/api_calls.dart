import 'api_manager.dart';

Future<dynamic> userCall() => ApiManager.instance.makeApiCall(
      callName: 'user',
      apiDomain: 'jsonplaceholder.typicode.com',
      apiEndpoint: 'todos/1',
      callType: ApiCallType.GET,
      headers: {},
      params: {},
      returnResponse: true,
    );

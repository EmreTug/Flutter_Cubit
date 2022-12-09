import 'package:flutter_architecture/core/constants/appconstants/app_constants.dart';
import 'package:flutter_architecture/view/home/homepage/service/IHomeService.dart';

import '../model/news_model.dart';

class HomeService extends IHomeService{
  HomeService(super.dio);

  @override
  Future<NewsModel> fetchData() async {
   var response=await dio.get(QueryPath.EVERYTHING.rawValue,
   queryParameters: {
    "q":QueryParameter.Q.rawValue,
    "apiKey":QueryParameter.APIKEY.rawValue
   }); 
   return NewsModel.fromJson(response.data);
  }
}

enum QueryParameter{
  Q,
  APIKEY
}
extension QueryParameterExtension on QueryParameter{
  String get rawValue{
    switch (this) {
      case QueryParameter.Q:
        return "keyword";
      case QueryParameter.APIKEY:
      return AppConstants.APIKEY;
      default:
      throw("Error");
    }
  }
}
enum QueryPath{
  EVERYTHING
}
extension QueryPathExtension on QueryPath{
  String get rawValue{
    switch (this) {
      case QueryPath.EVERYTHING:
        return "/everything";
      default:
      throw("Error");
    }
  }
}

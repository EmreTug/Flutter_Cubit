import 'package:dio/dio.dart';
import 'package:flutter_architecture/view/home/homepage/model/news_model.dart';

abstract class IHomeService{
  final Dio dio;

  IHomeService(this.dio);
  Future<NewsModel> fetchData();
}
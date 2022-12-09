import 'package:flutter_architecture/view/home/homepage/model/news_model.dart';
import 'package:flutter_architecture/view/home/homepage/service/IHomeService.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewsCubit extends Cubit<NewsState> {
    final IHomeService homeService;

  NewsCubit(this.homeService) : super(NewsInitialState()){
  fetchNews();
  }



  Future<void> fetchNews() async {
    emit(NewsLoadingState());
    final result = await homeService.fetchData();
    if (result != null) {
      emit(NewsCompletedState(result));
    } else {
      emit(NewsErrorState());
    }
  }


}

abstract class NewsState{}

class NewsInitialState extends NewsState{}
class NewsLoadingState extends NewsState{}
class NewsCompletedState extends NewsState{
  final NewsModel model;

  NewsCompletedState(this.model);
}
class NewsErrorState extends NewsState{}
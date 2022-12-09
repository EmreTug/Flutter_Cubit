import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_architecture/view/home/homepage/service/HomeService.dart';
import 'package:flutter_architecture/view/home/homepage/viewmodel/cubit/homestate_cubit.dart';
import 'package:flutter_architecture/view/home/newsdetail/view/newsdetail_view.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:shimmer/shimmer.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = NewsCubit(
        HomeService(Dio(BaseOptions(baseUrl: "https://newsapi.org/v2"))));
    return buildScaffold(cubit);
  }

  Scaffold buildScaffold(NewsCubit cubit) {
    return Scaffold(
    appBar: AppBar(
      title: const Text("NewsApp"),
      leading: Lottie.asset('assets/lottie/news_lottie.json', repeat: false),
    ),
    body: Container(
        color: Colors.white,
        child: BlocProvider(
          create: (context) => cubit,
          child: BlocConsumer<NewsCubit, NewsState>(
            listener: (context, state) {},
            builder: (context, state) {
              if (state is NewsLoadingState) {
                return const LoadingWidget();
              } else if (state is NewsCompletedState) {
                return buildListView(state);
              }
             else  {
                return const ErrorWidget();
              } 
            },
          ),
        )),
  );
  }

  ListView buildListView(NewsCompletedState state) {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: state.model.articles!.length - 1,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => NewsDetail(
                              description: state
                                  .model.articles![index + 1].description
                                  .toString(),
                              imageUrl: state
                                  .model.articles![index + 1].urlToImage
                                  .toString(),
                              title: state.model.articles![index + 1].title
                                  .toString(),
                            )));
              },
              child: CustomNewsCard(
                imageUrl:
                    state.model.articles![index + 1].urlToImage.toString(),
                title: state.model.articles![index + 1].title.toString(),
              ));
        });
  }
}

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.black.withOpacity(0.4),
      highlightColor: Colors.grey,
      child: ListView.builder(
        itemCount: 5,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            height: 200,
            margin: const EdgeInsets.only(
              top: 10,
              left: 10,
              right: 10,
            ),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.4),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              children: [
                Container(
                  height: 120,
                  color: Colors.black.withOpacity(0.4),
                ),
                SizedBox(height: 3,),
                 Container(
                  height: 25,
                  color: Colors.black.withOpacity(0.4),
                ),
                 SizedBox(height: 3,),
                 Container(
                  height: 49,
                  color: Colors.black.withOpacity(0.4),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class ErrorWidget extends StatelessWidget {
  const ErrorWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        "Hata",
        style: TextStyle(decoration: TextDecoration.none),
      ),
    );
  }
}

class CustomNewsCard extends StatelessWidget {
  const CustomNewsCard({
    required this.imageUrl,
    required this.title,
  });
  final String imageUrl;
  final String title;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      margin: const EdgeInsets.only(
        top: 10,
        left: 10,
        right: 10,
      ),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Colors.blue,
            Colors.yellow,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Container(
            height: 120,
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10)),
                image: DecorationImage(
                    image: NetworkImage(imageUrl), fit: BoxFit.cover)),
          ),
          Container(
            padding: const EdgeInsets.only(top: 5, left: 5, right: 5),
            child: Text(
              title,
              maxLines: 2,
              style: const TextStyle(
                  decoration: TextDecoration.none, fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.only(left: 5, right: 5),
            child: Text(
              title,
              maxLines: 2,
              style: const TextStyle(
                  decoration: TextDecoration.none, fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }
}

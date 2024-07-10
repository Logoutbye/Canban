

import 'package:flutter/cupertino.dart';
import 'package:mvvm/data/response/api_response.dart';
import 'package:mvvm/model/movies_model.dart';
import 'package:mvvm/respository/home_repository.dart';

class HomeViewViewModel with ChangeNotifier {

  final _myRepo = HomeRepository();

  ApiResponse<MovieListModel> moviesList = ApiResponse.loading();

  setMoviesList(ApiResponse<MovieListModel> response){
    moviesList = response ;
    notifyListeners();
  }


  Future<void> fetchMoviesListApi ()async{

    setMoviesList(ApiResponse.loading());

    _myRepo.fetchMoviesList().then((value){

      setMoviesList(ApiResponse.completed(value));

    }).onError((error, stackTrace){

      setMoviesList(ApiResponse.error(error.toString()));

    });
  }


}

// class HomeViewModel extends StateNotifier<ApiResponse<MovieListModel>> {
//   final HomeRepository _myRepo = HomeRepository();

//   HomeViewModel() : super(ApiResponse.loading());

//   Future<void> fetchMoviesListApi() async {
//     state = ApiResponse.loading();

//     try {
//       final response = await _myRepo.fetchMoviesList();
//       state = ApiResponse.completed(response);
//     } catch (error) {
//       state = ApiResponse.error(error.toString());
//     }
//   }
// }

// final homeViewModelProvider = StateNotifierProvider<HomeViewModel, ApiResponse<MovieListModel>>((ref) {
//   return HomeViewModel();
// });

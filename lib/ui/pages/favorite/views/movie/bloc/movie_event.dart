part of 'movie_bloc.dart';

abstract class MovieEvent {}

class FetchData extends MovieEvent {
  final String language;
  final int accountId;
  final String sessionId;
  String? sortBy;
  int? page;
  FetchData({
    required this.language,
    required this.accountId,
    required this.sessionId,
    this.sortBy,
     this.page,
  });
}

class LoadMore extends MovieEvent {
  final String language;
  final int accountId;
  final String sessionId;
  String? sortBy;

  LoadMore({
    required this.language,
    required this.accountId,
    required this.sessionId,
    this.sortBy,

  });
}

class DropDown extends MovieEvent {
  bool isDropDown;
  DropDown({
    required this.isDropDown,
  });
}

class Sort extends MovieEvent {
  final int index;
  Sort({
    required this.index,
  });
}

// part of 'movie_bloc.dart';

// abstract class MovieEvent {}

// class FetchData extends MovieEvent {
//   final String language;
//   final int accountId;
//   final String sessionId;
//   String? sortBy;
//   int page;
//   List<MediaSynthesis>? listFavorite;
//   FetchData({
//     required this.language,
//     required this.accountId,
//     required this.sessionId,
//     this.sortBy,
//     required this.page,
//     this.listFavorite,
//   });
// }

// class LoadMore extends MovieEvent {
//   final String language;
//   final int accountId;
//   final String sessionId;
//   String? sortBy;

//   LoadMore({
//     required this.language,
//     required this.accountId,
//     required this.sessionId,
//     this.sortBy,
//   });
// }

// class DropDown extends MovieEvent {
//   bool isDropDown;
//   DropDown({
//     required this.isDropDown,
//   });
// }

// class ChooseSort extends MovieEvent {
//   final int index;
//   ChooseSort({
//     required this.index,
//   });
// }

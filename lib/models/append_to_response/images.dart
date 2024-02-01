import 'package:movie_app/models/models.dart';

class Images {
  List<Profile> profiles;
  Images({
    this.profiles = const [],
  });

  factory Images.fromJson(Map<String, dynamic> json) => Images(
        profiles: json['profiles'] == null
            ? []
            : List<Profile>.from(json['profiles'].map((x) => Profile.fromJson(x))),
      );


}

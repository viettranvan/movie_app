import 'package:movie_app/utils/index.dart';

extension APIKey on Map<String, dynamic>? {
  Map<String, dynamic>? addApiKey() {
    if (this == null) {
      return {'api_key': AppConstants.kApiKey};
    } else {
      this!.addAll({
        'api_key': AppConstants.kApiKey,
      });

      return this;
    }
  }
}

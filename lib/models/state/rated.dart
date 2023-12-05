class Rated {
  int? value;

  Rated({
    required this.value,
  });

  factory Rated.fromJson(Map<String, dynamic> json) => Rated(
        value: json['value'],
      );

  Map<String, dynamic> toJson() => {
        'value': value,
      };
}
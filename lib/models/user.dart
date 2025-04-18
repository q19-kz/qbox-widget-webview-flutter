class User {
  final int? id;
  final String? firstName;
  final String? lastName;
  final String? patronymic;
  final String? birthdate;
  final String? iin;
  final String? phoneNumber;
  final Map<String, dynamic> dynamicAttrs;

  const User({
    this.id,
    this.firstName,
    this.lastName,
    this.patronymic,
    this.birthdate,
    this.iin,
    this.phoneNumber,
    this.dynamicAttrs = const {},
  });

  Map<String, dynamic> toJson() => {
        'user_id': id,
        'first_name': firstName,
        'last_name': lastName,
        'patronymic': patronymic,
        'iin': iin,
        'phone': phoneNumber,
        'birthdate': birthdate,
      }..addAll(dynamicAttrs);
}

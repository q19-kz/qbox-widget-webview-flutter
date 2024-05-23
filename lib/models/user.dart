
class User {
  final int? id;
  final String? firstName;
  final String? lastName;
  final String? patronymic;
  final String? birthDate;
  final String? iin;
  final String? phoneNumber;
  final Map<String, String>? dynamicAttrs;

  User({
    this.id,
    this.firstName,
    this.lastName,
    this.patronymic,
    this.birthDate,
    this.iin,
    this.phoneNumber,
    this.dynamicAttrs
  });
}

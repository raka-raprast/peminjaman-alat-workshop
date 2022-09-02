import 'package:json_annotation/json_annotation.dart';

part 'cart.g.dart';

@JsonSerializable()
class Cart {
  final String name;
  final String image;
  final int qty;
  final String remark;

  Cart(
      {required this.name,
      required this.image,
      required this.qty,
      this.remark = ""});

  /// A necessary factory constructor for creating a new User instance
  /// from a map. Pass the map to the generated `_$UserFromJson()` constructor.
  /// The constructor is named after the source class, in this case, User.
  factory Cart.fromJson(Map<String, dynamic> json) => _$CartFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  Map<String, dynamic> toJson() => _$CartToJson(this);

  @override
  List<Object?> get props => [
        name,
        image,
        qty,
        remark,
      ];
}

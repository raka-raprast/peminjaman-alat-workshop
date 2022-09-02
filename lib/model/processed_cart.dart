part 'processed_cart.g.dart';

class ProcessedCart {
  final String name;
  final String image;
  final int qty;
  final String? remark;
  final String id;

  ProcessedCart({
    required this.name,
    required this.image,
    required this.qty,
    this.remark,
    required this.id,
  });

  /// A necessary factory constructor for creating a new User instance
  /// from a map. Pass the map to the generated `_$UserFromJson()` constructor.
  /// The constructor is named after the source class, in this case, User.
  factory ProcessedCart.fromJson(Map<String, dynamic> json) =>
      _$ProcessedCartFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  Map<String, dynamic> toJson() => _$ProcessedCartToJson(this);

  @override
  List<Object?> get props => [
        name,
        image,
        qty,
        remark,
        id,
      ];
}

import 'package:fall_24_flutter_course/templates/lab5/geo.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'address.freezed.dart';
part 'address.g.dart';

@Freezed()
class Address with _$Address{
  const factory Address({
    required String street,
    required String suite,
    required String city,
    required String zipcode,
    @JsonKey(fromJson: Address.geoFromJson)
    required Geo geo,
  }) = _Address;

  factory Address.fromJson(Map<String, dynamic> json) => _$AddressFromJson(json);

  static Geo geoFromJson(Map<String, dynamic> json) => Geo.fromJson(json);
}

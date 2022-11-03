part of 'add_new_property_bloc.dart';

@freezed
class AddNewPropertyState with _$AddNewPropertyState {
  const factory AddNewPropertyState({
    @Default(ProcessAdd.address) ProcessAdd state,
    @Default(AddressChoosen()) AddressChoosen addressChoosen,
    @Default([]) List<Province> provinces,
    @Default([]) List<District> districts,
    @Default([]) List<Ward> wards,
  }) = _AddNewPropertyState;
}

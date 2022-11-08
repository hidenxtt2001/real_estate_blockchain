import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:real_estate_blockchain/data/real_estate/data.dart';
import 'enums.dart';
import 'validate_subcriber.dart';

part 'house_process_amentity_event.dart';
part 'house_process_amentity_state.dart';
part 'house_process_amentity_bloc.freezed.dart';

@injectable
class HouseProcessAmentityBloc
    extends Bloc<HouseProcessAmentityEvent, HouseProcessAmentityState> {
  final ValidateSubcriber _subcriber;
  HouseProcessAmentityBloc(@factoryParam this._subcriber)
      : super(const HouseProcessAmentityState()) {
    _subcriber.stream.listen((event) {
      event.onValidWithData(
        ProcessState.amenities,
        isValid(),
        [
          ...state.amentities
              .where((element) => element.value2)
              .map((e) => e.value1),
        ],
      );
    });
    on<_Started>((event, emit) {
      emit(
        state.copyWith(
          amentities: event.list.map((e) => Tuple2(e, false)).toList(),
        ),
      );
    });
    on<_OnSelectAmenity>((event, emit) {
      final amenities = state.amentities
          .map(
            (element) => element.value1 == event.amenity
                ? element.copyWith(value2: event.isSelected)
                : element,
          )
          .toList();
      emit(state.copyWith(amentities: amenities));
    });
  }

  void onStart(List<RealEstateAmenity> items) {
    add(HouseProcessAmentityEvent.started(items));
  }

  void onSelectAmenity(RealEstateAmenity amenity, bool isSelected) {
    add(HouseProcessAmentityEvent.onSelectAmenity(amenity, isSelected));
  }

  bool isValid() {
    final isNotNull =
        state.amentities.where((element) => element.value2).isNotEmpty;
    return isNotNull;
  }
}

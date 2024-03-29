import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:real_estate_blockchain/data/real_estate/data.dart';
import 'package:real_estate_blockchain/data/real_estate/domain/entities/real_estate_type.dart';
import 'package:real_estate_blockchain/feature/house_add_new/module.dart';
import 'package:real_estate_blockchain/utils/enums.dart';

import 'enums.dart';
import 'validate_subcriber.dart';

part 'house_process_real_info_event.dart';
part 'house_process_real_info_state.dart';
part 'house_process_real_info_bloc.freezed.dart';

@injectable
class HouseProcessRealInfoBloc
    extends Bloc<HouseProcessRealInfoEvent, HouseProcessRealInfoState> {
  final ValidateSubcriber _subcriber;
  late final StreamSubscription _subscription;
  HouseProcessRealInfoBloc(
    @factoryParam this._subcriber,
  ) : super(const HouseProcessRealInfoState()) {
    _subscription = _subcriber.stream.listen((event) {
      event.onValidWithData(
        ProcessState.realeStateInfo,
        isValid(),
        RealEstateInfo(
          isRent: state.sell == RealEstateSell.rent,
          area: state.area,
          documents: state.documents,
          floors: state.floors,
          noBedroom: state.noBedroom,
          noWc: state.noWc,
          price: state.price,
          builtAt: state.builtAt,
          balconyFacing: state.balcony?.name,
          houseFacing: state.houseFacing?.name,
          interiors: state.furniture,
          name: state.name,
          reTypeId: state.reTypeId,
        ),
      );
    });
    on<_Started>((event, emit) {});
    on<_ChangeTypeSell>((event, emit) {
      emit(state.copyWith(sell: event.sell));
    });
    on<_ChangeRealEstateType>((event, emit) {
      emit(state.copyWith(reTypeId: event.type.id));
    });
    on<_OnAreaChanged>((event, emit) {
      emit(state.copyWith(area: event.area));
    });
    on<_OnPriceChanged>((event, emit) {
      emit(state.copyWith(price: event.price));
    });
    on<_OnNumBedRoomChanged>((event, emit) {
      emit(
        state.copyWith(
          noBedroom: event.isIncrease
              ? state.noBedroom + 1
              : (state.noBedroom - 1 >= 0 ? state.noBedroom - 1 : 0),
        ),
      );
    });
    on<_OnNumFloorChanged>((event, emit) {
      emit(
        state.copyWith(
          floors: event.isIncrease
              ? state.floors + 1
              : (state.floors - 1 >= 0 ? state.floors - 1 : 0),
        ),
      );
    });
    on<_OnNumWcChanged>((event, emit) {
      emit(
        state.copyWith(
          noWc: event.isIncrease
              ? state.noWc + 1
              : (state.noWc - 1 >= 0 ? state.noWc - 1 : 0),
        ),
      );
    });
    on<_OnDocumentAdded>(
      (event, emit) {
        if (state.documents.contains(event.document) != true) {
          final documents = [...state.documents];
          documents.add(event.document);
          emit(
            state.copyWith(
              documents: documents,
            ),
          );
        }
      },
    );
    on<_OnDocumentDeleted>((event, emit) {
      final documents = [...state.documents];
      documents.remove(event.document);
      emit(
        state.copyWith(
          documents: documents,
        ),
      );
    });
    on<_OnBuiltAtChanged>((event, emit) {
      emit(state.copyWith(
        builtAt: event.year,
      ));
    });
    on<_OnHouseDirectionChanged>((event, emit) {
      emit(state.copyWith(
        houseFacing: event.direction,
      ));
    });
    on<_OnBalconyDirectionChanged>((event, emit) {
      emit(state.copyWith(
        balcony: event.direction,
      ));
    });
    on<_OnFurnitureChanged>((event, emit) {
      emit(state.copyWith(furniture: event.note));
    });
    on<_OnRealEstateNameChanged>(
      (event, emit) => emit(state.copyWith(name: event.name)),
    );
  }
  void started() => add(const HouseProcessRealInfoEvent.started());
  void onChangedTypeSell(RealEstateSell sell) =>
      add(HouseProcessRealInfoEvent.changeTypeSell(sell));
  void onChangedRealEstateType(RealEstateType type) =>
      add(HouseProcessRealInfoEvent.changeRealEstateType(type));
  void onAreaChanged(double area) =>
      add(HouseProcessRealInfoEvent.onAreaChanged(area));
  void onPriceChanged(double price) =>
      add(HouseProcessRealInfoEvent.onPriceChanged(price));
  void addDocument(String document) =>
      add(HouseProcessRealInfoEvent.onDocumentsAdded(document));
  void deleteDocument(String document) =>
      add(HouseProcessRealInfoEvent.onDocumentsDeleted(document));

  void onNumberOfBedRoomChanged(bool isIncrease) =>
      add(HouseProcessRealInfoEvent.onNumBedRoomChanged(isIncrease));

  void onNumberOfWcChanged(bool isIncrease) =>
      add(HouseProcessRealInfoEvent.onNumWcChanged(isIncrease));
  void onNumberOfFloorChanged(bool isIncrease) =>
      add(HouseProcessRealInfoEvent.onNumFloorChanged(isIncrease));
  void onBuiltAtChanged(int year) =>
      add(HouseProcessRealInfoEvent.onBuiltAtChanged(year));
  void onHouseFacingChanged(RealEstateDirection direction) =>
      add(HouseProcessRealInfoEvent.onHouseDirectionChanged(direction));
  void onBalconyFacingChanged(RealEstateDirection direction) =>
      add(HouseProcessRealInfoEvent.onBalconyDirectionChanged(direction));
  void onFurnitureChanged(String note) =>
      add(HouseProcessRealInfoEvent.onFurnitureChanged(note));
  void onRealEstateNameChanged(String name) =>
      add(HouseProcessRealInfoEvent.onRealEstateNameChanged(name));

  bool isValid() {
    final isNotNull = (state.area ?? 0) > 0 &&
        (state.price ?? 0) > 0 &&
        state.reTypeId != null &&
        state.houseFacing != null &&
        state.name?.isNotEmpty == true;
    return isNotNull;
  }

  void disposed() {
    _subscription.cancel();
  }
}

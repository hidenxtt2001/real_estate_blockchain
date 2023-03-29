part of 'user_profile_bloc.dart';

@freezed
class UserProfileEvent with _$UserProfileEvent {
  const factory UserProfileEvent.started() = _Started;
  const factory UserProfileEvent.onAvatarChanged({String? path}) =
      UserProfileEventOnAvatarChanged;
  const factory UserProfileEvent.onFullNameChanged({String? fullName}) =
      UserProfileEventOnFullNameChanged;
  const factory UserProfileEvent.onFirstNameChanged({String? firstName}) =
      UserProfileEventOnFirstNameChanged;
  const factory UserProfileEvent.onLastNameChanged({String? lastName}) =
      UserProfileEventOnLastNameChanged;
  const factory UserProfileEvent.onSaveChanged() =
      UserProfileEventOnSaveChanged;
}
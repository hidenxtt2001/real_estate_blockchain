part of 'app_bloc.dart';

@freezed
class AppEvent with _$AppEvent {
  const factory AppEvent.changedLanguage(Locale locale) =
      AppEventChangedLanguage;
  const factory AppEvent.changedThemeMode(ThemeMode mode) =
      AppEventChangedThemeMode;
}

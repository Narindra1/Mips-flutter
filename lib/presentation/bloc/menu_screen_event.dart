part of 'menu_screen_bloc.dart';

@immutable
sealed class MenuScreenEvent {}

class LoadMenuScreenEvent extends MenuScreenEvent {
  final String id;

  LoadMenuScreenEvent({
    required this.id,
  });
}

class MenuLangChangeEvent extends MenuScreenEvent {
  final String lang;

  MenuLangChangeEvent({
    required this.lang,
  });
}

class SetScreenInfoEvent extends MenuScreenEvent {
  final Menu screenInfo;

  SetScreenInfoEvent({required this.screenInfo});
}

class LikeMenuScreenEvent extends MenuScreenEvent {
  final String idMenu;
  final bool isLike;

  LikeMenuScreenEvent({
    required this.idMenu,
    required this.isLike,
  });
}

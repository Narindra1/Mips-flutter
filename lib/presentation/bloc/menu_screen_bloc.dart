import 'package:MIPS/common/common.dart';
import 'package:MIPS/presentation/widgets/message_displayer_utils.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../domain/domain.dart';

part 'menu_screen_event.dart';

part 'menu_screen_state.dart';

class MenuScreenBloc extends Bloc<MenuScreenEvent, MenuScreenState> {
  final GetScreenByIDRouteUseCase getScreenByIDRouteUseCase;
  final LikeScreenUseCase likeScreenUseCase;

  MenuScreenBloc(
      {required this.getScreenByIDRouteUseCase,
      required this.likeScreenUseCase,
      String lang = ""})
      : super(MenuScreenState.initial(lang)) {
    on<LoadMenuScreenEvent>(_onLoadMenuScreenEvent);
    on<SetScreenInfoEvent>(_onSetScreenInfoEvent);
    on<LikeMenuScreenEvent>(_onLikeMenuScreenEvent);
    on<MenuLangChangeEvent>(_onMenuLangChangeEvent);
  }

  _onMenuLangChangeEvent(MenuLangChangeEvent event, Emitter emit) async {
    if (event.lang != state.lang) {
      emit(state.copyWith(lang: event.lang));
      add(LoadMenuScreenEvent(id: state.screenEntity?.id.toString() ?? "0"));
    }
  }

  _onLikeMenuScreenEvent(LikeMenuScreenEvent event, Emitter emit) async {
    var result = await likeScreenUseCase(event.idMenu, event.isLike);
    if (result.isError()) {
      MessageDisplayerUtils.showToastMessageV2(MessageType.errorOperation);
      if (result.getError() is NoConnectionFailure) {
        emit(state.copyWith(
            status: Status.error, failure: NoConnectionFailure()));
      }
    } else {
      Menu? screen = state.screenEntity;
      if (screen != null && result.getSuccess() != null) {
        MessageDisplayerUtils.showToastMessageV2(result.getSuccess()!.isFavs
            ? MessageType.favsAdded
            : MessageType.favsRemoved);
        screen = screen.copyWith(
            isFavs: result.getSuccess()!.isFavs,
            title: result.getSuccess()!.title);
        emit(state.copyWith(screenEntity: screen));
      } else {
        emit(state.copyWith(screenEntity: result.getSuccess()));
      }
    }
  }

  _onSetScreenInfoEvent(SetScreenInfoEvent event, Emitter emit) async {
    emit(state.copyWith(screenEntity: event.screenInfo));
  }

  _onLoadMenuScreenEvent(LoadMenuScreenEvent event, Emitter emit) async {
    emit(state.copyWith(status: Status.loading));
    if (event.id != "7000" /* != my menu id */) {
      var result = await getScreenByIDRouteUseCase(event.id);

      if (result.isError()) {
        if (result.getError() is PageNotFoundFailure) {
          emit(state.copyWith(status: Status.pageNotFound));
        } else if (result.getError() is NoConnectionFailure) {
          emit(state.copyWith(
              status: Status.error, failure: NoConnectionFailure()));
        } else {
          emit(state.copyWith(
              status: Status.error, failure: const ServerFailure()));
        }
      } else {
        emit(state.copyWith(
            screenEntity: result.getSuccess(), status: Status.loaded));
      }
    }
  }
}

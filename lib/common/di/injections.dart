import 'package:MIPS/common/common.dart';
import 'package:MIPS/common/services/environment_wrapper.dart';
import 'package:MIPS/data/data.dart';
import 'package:MIPS/data/repositories/exchange_rate_repository_impl.dart';
import 'package:MIPS/data/repositories/follow_repository_impl.dart';
import 'package:MIPS/data/repositories/kara_partner_repository_impl.dart';
import 'package:MIPS/data/repositories/profil_repository_impl.dart';
import 'package:MIPS/data/repositories/reward_repository_impl.dart';
import 'package:MIPS/data/repositories/update_repository_impl.dart';
import 'package:MIPS/domain/contracts/exchange_rate_repository.dart';
import 'package:MIPS/domain/contracts/follow_repository.dart';
import 'package:MIPS/domain/contracts/kara_partner_repository.dart';
import 'package:MIPS/domain/contracts/profil_repository.dart';
import 'package:MIPS/domain/contracts/reward_repository.dart';
import 'package:MIPS/domain/domain.dart';
import 'package:MIPS/domain/usecases/annonces/get_annonce_with_partner_sponsor_usecase.dart';
import 'package:MIPS/domain/usecases/annonces/get_recents_annonces_usecase.dart';
import 'package:MIPS/domain/usecases/annonces/get_user_annonces_count_usecase.dart';
import 'package:MIPS/domain/usecases/annonces/get_user_favorite_annonces_count_usecase.dart';
import 'package:MIPS/domain/usecases/annonces/get_user_favorite_annonces_usecase.dart';
import 'package:MIPS/domain/usecases/exchange_rate/get_exchange_rate_usecase.dart';
import 'package:MIPS/domain/usecases/follow/check_following_usecase.dart';
import 'package:MIPS/domain/usecases/follow/follow_user_usecase.dart';
import 'package:MIPS/domain/usecases/follow/get_annonces_followed_users_count_usecase.dart';
import 'package:MIPS/domain/usecases/follow/get_annonces_followed_users_usecase.dart';
import 'package:MIPS/domain/usecases/follow/get_followers_usecase.dart';
import 'package:MIPS/domain/usecases/follow/get_following_usecase.dart';
import 'package:MIPS/domain/usecases/follow/unfollow_user_usecase.dart';
import 'package:MIPS/domain/usecases/kara_partner/get_kara_province_list_usecase.dart';
import 'package:MIPS/domain/usecases/kara_partner/kara_subscription_usecase.dart';
import 'package:MIPS/domain/usecases/profil/get_annonces_user_profil_count_usecase.dart';
import 'package:MIPS/domain/usecases/profil/get_annonces_user_profil_usecase.dart';
import 'package:MIPS/domain/usecases/profil/get_user_info_profil_by_id_usecase.dart';
import 'package:MIPS/domain/usecases/reward/get_reward_list_usecase.dart';
import 'package:MIPS/domain/usecases/support/submit_a_sondage_usecase.dart';
import 'package:MIPS/presentation/bloc/follow_bloc.dart';
import 'package:MIPS/presentation/presentation.dart';
import 'package:MIPS/presentation/screens/avatar_faka/bloc/avatar_bloc.dart';
import 'package:MIPS/presentation/screens/avis/bloc/avis_bloc.dart';
import 'package:MIPS/presentation/screens/demande_pub/bloc/demande_pub_bloc.dart';
import 'package:MIPS/presentation/screens/exchange_rate/bloc/exchange_rate_bloc.dart';
import 'package:MIPS/presentation/screens/kara_partner/bloc/kara_partner_bloc.dart';
import 'package:MIPS/presentation/screens/mes_annonces/bloc/mes_annonces_screen_bloc.dart';
import 'package:MIPS/presentation/screens/my_menu_profil/bloc/my_menu_profil_bloc.dart';
import 'package:MIPS/presentation/screens/my_wallet/bloc/rewards_bloc.dart';
import 'package:MIPS/presentation/screens/profil/bloc/profil_bloc.dart';
import 'package:MIPS/presentation/screens/sondage/bloc/sondage_bloc.dart';
import 'package:get_it/get_it.dart';
import '../../presentation/bloc/menu_screen_bloc.dart';
import '../../presentation/screens/maha_partenaire/bloc/maha_partenaire_bloc.dart';
import '../../presentation/screens/password_guard/bloc/password_guard_bloc.dart';

final getIt = GetIt.instance;

Future<void> init() async {
  /// UserPref doit être initialisé pour être prêt à gérer tous les enregistrements.
  UserPrefRepositoryImpl userPrefRepositoryImpl = UserPrefRepositoryImpl();
  await userPrefRepositoryImpl.initUserPref();

  getIt.registerLazySingleton<EnvironmentWrapper>(
      () => EnvironmentWrapper(userPrefRepositoryImpl: userPrefRepositoryImpl));

  /// Service
  getIt.registerLazySingleton<NetworkService>(() => NetworkService(
      userPrefRepositoryImpl: userPrefRepositoryImpl,
      environmentWrapper: getIt()));

  /// Data source
  getIt.registerLazySingleton<RemoteDataSource>(
      () => RemoteDataSource(dio: getIt<NetworkService>().getDioInstance()));

  /// Repositories
  // getIt.registerSingleton<UserPrefRepositoryImpl>(userPrefRepositoryImpl);
  getIt.registerLazySingleton<UserPrefRepositoryImpl>(
      () => userPrefRepositoryImpl);
  getIt.registerLazySingleton<MenuRepository>(
      () => MenuRepositoryImpl(remoteDataSource: getIt()));
  getIt.registerLazySingleton<AnnonceRepository>(
      () => AnnonceRepositoryImpl(remoteDataSource: getIt()));
  getIt.registerLazySingleton<CommentaireRepository>(
      () => CommentaireRepositoryImpl(remoteDataSource: getIt()));
  getIt.registerLazySingleton<UserRepository>(
      () => UserRepositoryImpl(remoteDataSource: getIt()));
  getIt.registerLazySingleton<MahaPartenaireEltRepository>(
      () => MahaPartenaireEltRepositoryImpl(remoteDataSource: getIt()));
  getIt.registerLazySingleton<SondageRepository>(
      () => SondageRepositoryImpl(remoteDataSource: getIt()));
  getIt.registerLazySingleton<AvisRepository>(
      () => AvisRepositoryImpl(remoteDataSource: getIt()));
  getIt.registerLazySingleton<UpdateRepository>(
      () => UpdateRepositoryImpl(remoteDataSource: getIt()));
  getIt.registerLazySingleton<AvatarRepository>(
      () => AvatarRepositoryImpl(remoteDataSource: getIt()));
  getIt.registerLazySingleton<ProfilRepository>(
      () => ProfilRepositoryImpl(remoteDataSource: getIt()));
  getIt.registerLazySingleton<ExchangeRateRepository>(
      () => ExchangeRateRepositoryImpl(remoteDataSource: getIt()));
  getIt.registerLazySingleton<RewardRepository>(
      () => RewardRepositoryImpl(remoteDataSource: getIt()));
  getIt.registerLazySingleton<FollowRepository>(
      () => FollowRepositoryImpl(remoteDataSource: getIt()));
  getIt.registerLazySingleton<KaraPartnerRepository>(
      () => KaraPartnerRepositoryImpl(remoteDataSource: getIt()));

  /// UseCases
  getIt.registerLazySingleton<GetScreenByIDRouteUseCase>(
      () => GetScreenByIDRouteUseCase(screenRepository: getIt()));
  getIt.registerLazySingleton<CreateAnnonceUseCase>(
      () => CreateAnnonceUseCase(annonceRepository: getIt()));
  getIt.registerLazySingleton<DeleteAnnonceUseCase>(
      () => DeleteAnnonceUseCase(annonceRepository: getIt()));
  getIt.registerLazySingleton<GetAllAnnoncesByIdScreenUseCase>(
      () => GetAllAnnoncesByIdScreenUseCase(annonceRepository: getIt()));
  getIt.registerLazySingleton<GetAnnonceUseCase>(
      () => GetAnnonceUseCase(annonceRepository: getIt()));
  getIt.registerLazySingleton<GetUserAnnoncesCountUsecase>(
      () => GetUserAnnoncesCountUsecase(annonceRepository: getIt()));
  getIt.registerLazySingleton<GetUserFavoriteAnnoncesUsecase>(
      () => GetUserFavoriteAnnoncesUsecase(annonceRepository: getIt()));
  getIt.registerLazySingleton<GetUserFavoriteAnnoncesCountUsecase>(
      () => GetUserFavoriteAnnoncesCountUsecase(annonceRepository: getIt()));
  getIt.registerLazySingleton<GetAnnonceWithPartnerSponsorUsecase>(
      () => GetAnnonceWithPartnerSponsorUsecase(annonceRepository: getIt()));
  getIt.registerLazySingleton<GetRecentsAnnoncesUsecase>(
      () => GetRecentsAnnoncesUsecase(annonceRepository: getIt()));
  getIt.registerLazySingleton<MakeFavAnnonceUseCase>(
      () => MakeFavAnnonceUseCase(annonceRepository: getIt()));
  getIt.registerLazySingleton<UpdateAnnonceUseCase>(
      () => UpdateAnnonceUseCase(annonceRepository: getIt()));
  getIt.registerLazySingleton<UploadImageAnnonceUseCase>(
      () => UploadImageAnnonceUseCase(annonceRepository: getIt()));
  getIt.registerLazySingleton<CancelImageUploadUseCase>(
      () => CancelImageUploadUseCase(annonceRepository: getIt()));
  getIt.registerLazySingleton<CreateCommentaireUseCase>(
      () => CreateCommentaireUseCase(commentaireRepository: getIt()));
  getIt.registerLazySingleton<GetCommentaireByAnnonceUseCase>(
      () => GetCommentaireByAnnonceUseCase(commentaireRepository: getIt()));
  getIt.registerLazySingleton<UpdateCommentaireUseCase>(
      () => UpdateCommentaireUseCase(commentaireRepository: getIt()));
  getIt.registerLazySingleton<GetUserInfoUseCase>(
      () => GetUserInfoUseCase(userRepository: getIt()));
  getIt.registerLazySingleton<DeleteUserUseCase>(
      () => DeleteUserUseCase(userRepository: getIt()));
  getIt.registerLazySingleton<LoginUserUseCase>(
      () => LoginUserUseCase(userRepository: getIt()));
  getIt.registerLazySingleton<LogoutUserUseCase>(
      () => LogoutUserUseCase(userRepository: getIt()));
  getIt.registerLazySingleton<RegisterUserUseCase>(
      () => RegisterUserUseCase(userRepository: getIt()));
  getIt.registerLazySingleton<UpdateUserUseCase>(
      () => UpdateUserUseCase(userRepository: getIt()));
  getIt.registerLazySingleton<LikeScreenUseCase>(
      () => LikeScreenUseCase(screenRepository: getIt()));
  getIt.registerLazySingleton<GetUserMenuProfilUseCase>(
      () => GetUserMenuProfilUseCase(userRepository: getIt()));
  getIt.registerLazySingleton<DeleteCommentaireUseCase>(
      () => DeleteCommentaireUseCase(commentaireRepository: getIt()));
  getIt.registerLazySingleton<ResetPasswordUseCase>(
      () => ResetPasswordUseCase(userRepository: getIt()));
  getIt.registerLazySingleton<ForgotPasswordUseCase>(
      () => ForgotPasswordUseCase(userRepository: getIt()));
  getIt.registerLazySingleton<GetParentMenuScreenUseCase>(
      () => GetParentMenuScreenUseCase(screenRepository: getIt()));
  getIt.registerLazySingleton<GetUserAnnoncesUseCase>(
      () => GetUserAnnoncesUseCase(annonceRepository: getIt()));
  getIt.registerLazySingleton<GetMenuTarifOptionsUseCase>(
      () => GetMenuTarifOptionsUseCase(screenRepository: getIt()));
  getIt.registerLazySingleton<TransfertFakaUseCase>(
      () => TransfertFakaUseCase(userRepository: getIt()));
  getIt.registerLazySingleton<CheckPasswordUseCase>(
      () => CheckPasswordUseCase(userRepository: getIt()));
  getIt.registerLazySingleton<ReactToAnnonceUseCase>(
      () => ReactToAnnonceUseCase(annonceRepository: getIt()));
  getIt.registerLazySingleton<ChangePasswordUseCase>(
      () => ChangePasswordUseCase(userRepository: getIt()));
  getIt.registerLazySingleton<GetAllMahaPartenaireUseCase>(
      () => GetAllMahaPartenaireUseCase(mahaPartenaireEltRepository: getIt()));
  getIt.registerLazySingleton<GetAllSondageUseCase>(
      () => GetAllSondageUseCase(sondageRepository: getIt()));
  getIt.registerLazySingleton<SubmitASondageUsecase>(
      () => SubmitASondageUsecase(sondageRepository: getIt()));
  getIt.registerLazySingleton<GetAAvisUseCase>(
      () => GetAAvisUseCase(avisRepository: getIt()));
  getIt.registerLazySingleton<GetAllAvisUseCase>(
      () => GetAllAvisUseCase(avisRepository: getIt()));
  getIt.registerLazySingleton<GetAnnoncePopupUseCase>(() =>
      GetAnnoncePopupUseCase(
          annonceRepository: getIt(), userPrefRepository: getIt()));
  getIt.registerLazySingleton<CheckUpdateUseCase>(
      () => CheckUpdateUseCase(updateRepository: getIt()));
  getIt.registerLazySingleton<BuyAvatarUseCase>(
      () => BuyAvatarUseCase(avatarRepository: getIt()));
  getIt.registerLazySingleton<GetAvatarListUseCase>(
      () => GetAvatarListUseCase(avatarRepository: getIt()));
  getIt.registerLazySingleton<ExtendValidityAnnonceUsecase>(
      () => ExtendValidityAnnonceUsecase(annonceRepository: getIt()));
  getIt.registerLazySingleton<GetTransactionHistoryUsecase>(
      () => GetTransactionHistoryUsecase(userRepository: getIt()));
  getIt.registerLazySingleton<GetUserMessages>(
      () => GetUserMessages(userRepository: getIt()));
  getIt.registerLazySingleton<ViewAMessageUseCase>(
      () => ViewAMessageUseCase(userRepository: getIt()));
  getIt.registerLazySingleton<ViewAllMessageUseCase>(
      () => ViewAllMessageUseCase(userRepository: getIt()));
  getIt.registerLazySingleton<GetUserUnreadMessageCountUsecase>(
      () => GetUserUnreadMessageCountUsecase(userRepository: getIt()));
  getIt.registerLazySingleton<GetUserInfoProfilByIdUsecase>(
      () => GetUserInfoProfilByIdUsecase(profilRepository: getIt()));
  getIt.registerLazySingleton<GetAnnoncesUserProfilCountUsecase>(
      () => GetAnnoncesUserProfilCountUsecase(profilRepository: getIt()));
  getIt.registerLazySingleton<GetAnnoncesUserProfilUsecase>(
      () => GetAnnoncesUserProfilUsecase(profilRepository: getIt()));
  getIt.registerLazySingleton<GetExchangeRateUsecase>(
      () => GetExchangeRateUsecase(exchangeRateRepository: getIt()));
  getIt.registerLazySingleton<GetRewardListUsecase>(
      () => GetRewardListUsecase(rewardRepository: getIt()));
  getIt.registerLazySingleton<CheckFollowingUsecase>(
      () => CheckFollowingUsecase(followRepository: getIt()));
  getIt.registerLazySingleton<FollowUserUsecase>(
      () => FollowUserUsecase(followRepository: getIt()));
  getIt.registerLazySingleton<GetAnnoncesFollowedUsersUsecase>(
      () => GetAnnoncesFollowedUsersUsecase(followRepository: getIt()));
  getIt.registerLazySingleton<GetFollowersUsecase>(
      () => GetFollowersUsecase(followRepository: getIt()));
  getIt.registerLazySingleton<GetFollowingUsecase>(
      () => GetFollowingUsecase(followRepository: getIt()));
  getIt.registerLazySingleton<UnfollowUserUsecase>(
      () => UnfollowUserUsecase(followRepository: getIt()));
  getIt.registerLazySingleton<GetAnnoncesFollowedUsersCountUsecase>(
      () => GetAnnoncesFollowedUsersCountUsecase(followRepository: getIt()));
  getIt.registerLazySingleton<GetKaraProvinceListUsecase>(
      () => GetKaraProvinceListUsecase(karaPartnerRepository: getIt()));
  getIt.registerLazySingleton<KaraSubscriptionUsecase>(
      () => KaraSubscriptionUsecase(karaPartnerRepository: getIt()));

  // BloC
  getIt.registerFactory<AppBloc>(() => AppBloc(
        userPrefRepositoryImpl: getIt(),
        networkService: getIt(),
        getUserInfoUseCase: getIt(),
        registerUserUseCase: getIt(),
        changePasswordUseCase: getIt(),
        updateUserUseCase: getIt(),
        viewAMessageUseCase: getIt(),
        viewAllMessageUseCase: getIt(),
        getUserMessages: getIt(),
        deleteUserUseCase: getIt(),
        loginUserUseCase: getIt(),
        forgotPasswordUseCase: getIt(),
        resetPasswordUseCase: getIt(),
        transfertFakaUseCase: getIt(),
        checkUpdateUseCase: getIt(),
        getAnnoncePopupUseCase: getIt(),
        getTransactionHistoryUsecase: getIt(),
        logoutUserUseCase: getIt(),
        getUserUnreadMessageCountUsecase: getIt(),
      ));

  getIt.registerFactory<DemandePubBloc>(() => DemandePubBloc(
      getParentScreenUseCase: getIt(),
      createAnnonceUseCase: getIt(),
      extendValidityAnnonceUsecase: getIt(),
      uploadImageAnnonceUseCase: getIt(),
      updateAnnonceUseCase: getIt(),
      getMenuTarifOptionsUseCase: getIt()));
  getIt.registerFactory<AnnonceBloc>(() => AnnonceBloc(
        getAllAnnoncesByIdScreenUseCase: getIt(),
        getAnnonceUseCase: getIt(),
        getAnnonceWithPartnerSponsorUsecase: getIt(),
        getRecentsAnnoncesUsecase: getIt(),
        reactToAnnonceUseCase: getIt(),
        createAnnonceUseCase: getIt(),
        deleteAnnonceUseCase: getIt(),
        makeFavAnnonceUseCase: getIt(),
        updateAnnonceUseCase: getIt(),
        deleteCommentaireUseCase: getIt(),
        getAllCommentaireByAnnonceUseCase: getIt(),
        updateCommentaireUseCase: getIt(),
        extendValidityAnnonceUsecase: getIt(),
        createCommentaireUseCase: getIt(),
      ));
  getIt.registerFactory<MenuScreenBloc>(() => MenuScreenBloc(
      getScreenByIDRouteUseCase: getIt(), likeScreenUseCase: getIt()));
  getIt.registerFactory<MyMenuProfilBloc>(() => MyMenuProfilBloc(
        likeScreenUseCase: getIt(),
        likeAnnonceUseCase: getIt(),
        getUserMenuProfilUseCase: getIt(),
        getUserFavoriteAnnoncesUsecase: getIt(),
        getUserFavoriteAnnoncesCountUsecase: getIt(),
      ));
  getIt.registerFactory<MesAnnoncesScreenBloc>(() => MesAnnoncesScreenBloc(
        getUserAnnoncesUseCase: getIt(),
        getUserAnnoncesCountUsecase: getIt(),
      ));
  getIt.registerFactory<PasswordGuardBloc>(
      () => PasswordGuardBloc(checkPasswordUseCase: getIt()));
  getIt.registerFactory<MahaPartenaireBloc>(
      () => MahaPartenaireBloc(getAllMahaPartenaireUseCase: getIt()));
  getIt.registerFactory<SondageBloc>(() => SondageBloc(
      getAllSondageUseCase: getIt(), submitASondageUsecase: getIt()));
  getIt.registerFactory<AvisBloc>(
      () => AvisBloc(getAAvisUseCase: getIt(), getAllAvisUseCase: getIt()));
  getIt.registerFactory<AvatarBloc>(() =>
      AvatarBloc(buyAvatarUseCase: getIt(), getAvatarListUseCase: getIt()));
  getIt.registerFactory<ExchangeRateBloc>(
      () => ExchangeRateBloc(getExchangeRateUsecase: getIt()));
  getIt.registerFactory<RewardsBloc>(
      () => RewardsBloc(getRewardListUsecase: getIt()));
  getIt.registerFactory<ProfilBloc>(() => ProfilBloc(
        getUserInfoProfilByIdUsecase: getIt(),
        getAnnoncesUserProfilCountUsecase: getIt(),
        getAnnoncesUserProfilUsecase: getIt(),
      ));
  getIt.registerFactory<FollowBloc>(() => FollowBloc(
        checkFollowingUsecase: getIt(),
        followUserUsecase: getIt(),
        getFollowersUsecase: getIt(),
        getAnnoncesFollowedUsersUsecase: getIt(),
        getFollowingUsecase: getIt(),
        unfollowUserUsecase: getIt(),
        getAnnoncesFollowedUsersCountUsecase: getIt(),
      ));
  getIt.registerFactory<KaraPartnerBloc>(() => KaraPartnerBloc(
        getKaraProvinceListUsecase: getIt(),
        karaSubscriptionUsecase: getIt(),
      ));
}

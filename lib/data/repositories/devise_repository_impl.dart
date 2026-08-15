// import 'package:mips/common/error/failures.dart';
// import 'package:mips/common/result/results.dart';
// import 'package:mips/data/data.dart';
// import 'package:mips/domain/contracts/devise_repository.dart';
// import 'package:mips/domain/entities/devise.dart';

// import '../../common/error/exceptions.dart';
// import '../../common/utils/app_utils.dart';

// /// Implémentation du dépôt pour la gestion des avatars.
// ///
// /// Utilise une source de données distante ([RemoteDataSource]) pour
// /// récupérer, acheter les avatars des utilisateurs.
// class DeviseRepositoryImpl implements DeviseRepository {
//   final RemoteDataSource remoteDataSource;

//   const DeviseRepositoryImpl({
//     required this.remoteDataSource,
//   });

//   @override
//   Future<Result<Failure, List<Devise>>> getDeviseList() async {
//     try {
//       List<Devise> result = (await remoteDataSource.fetchDevises())
//           .map((e) => e.toEntity())
//           .toList();
//       return Success(result);
//     } on AppException catch (e) {
//       AppUtils.showDebugLog(runtimeType, e.toString());
//       if (e is NoConnectionException) {
//         return Error(NoConnectionFailure());
//       }
//       return Error(ServerFailure(message: e.message));
//     } on Exception catch (e) {
//       return Error(ServerFailure(message: e.toString()));
//     }
//   }
// }

import 'package:MIPS/common/common.dart';
import 'package:MIPS/data/data.dart';

/// Class to handle Pro and PreProd environment
class EnvironmentWrapper {
  final UserPrefRepositoryImpl userPrefRepositoryImpl;

  const EnvironmentWrapper({
    required this.userPrefRepositoryImpl,
  });

  String get baseUrlAPI {
    return userPrefRepositoryImpl.isModPreProd()
        ? baseUrlAPI_Preprod
        : baseUrlAPI_PROD;
  }

  String get baseUrl {
    return userPrefRepositoryImpl.isModPreProd()
        ? baseUrl_Preprod
        : baseUrl_PROD;
  }

  String get hostName {
    return userPrefRepositoryImpl.isModPreProd()
        ? hostName_Preprod
        : hostName_PROD;
  }
}

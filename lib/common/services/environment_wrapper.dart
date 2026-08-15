import 'package:mips/common/common.dart';
import 'package:mips/data/data.dart';

/// Class to handle Pro and PreProd environment
class EnvironmentWrapper {
  final UserPrefRepositoryImpl userPrefRepositoryImpl;

  const EnvironmentWrapper({required this.userPrefRepositoryImpl});

  String get baseUrlAPI {
    return userPrefRepositoryImpl.isModPreProd()
        ? baseUrlAPIPreprod
        : baseUrlApiPROD;
  }

  String get baseUrl {
    return userPrefRepositoryImpl.isModPreProd() ? baseUrlPreprod : baseUrlPROD;
  }

  String get hostName {
    return userPrefRepositoryImpl.isModPreProd()
        ? hostNamePreprod
        : hostNamePROD;
  }
}

import 'package:mips/common/common.dart';
import 'package:encrypt_shared_preferences/provider.dart';

/// Implémentation du dépôt local pour la gestion des préférences utilisateur chiffrées.
///
/// Cette classe permet de stocker et de récupérer les informations de l'utilisateur
/// de manière sécurisée dans les [EncryptedSharedPreferences].
///
/// La clé par défaut est `"MahafDefaultUser"`.
///
/// Avant toute utilisation, il est nécessaire d’appeler [initUserPref]
/// pour initialiser le système de préférences chiffrées.
class UserPrefRepositoryImpl {
  final key = "MahafDefaultUser";

  late final EncryptedSharedPreferences sharedPref;

  UserPrefRepositoryImpl();

  Future<void> initUserPref() async {
    await EncryptedSharedPreferences.initialize(key);
    sharedPref = EncryptedSharedPreferences.getInstance();
  }

  Future<void> setLang(String langCode) async {
    AppUtils.showDebugLog(runtimeType, "new LangCode:$langCode");
    await sharedPref.setString("lang", langCode);
  }

  String getToken() {
    return sharedPref.getString("token") ?? "";
  }

  void setIsMainMenuExpanded(bool expanded) {
    sharedPref.setBoolean("mainMenuExpanded", expanded);
  }

  bool getIsMainMenuExpanded() {
    return sharedPref.getBoolean("mainMenuExpanded") ?? true;
  }

  void setToken(String token) {
    sharedPref.setString("token", token);
  }

  void setIsFirstTime(bool isFirstTime) {
    sharedPref.setBool("isFirstTime", isFirstTime);
  }

  bool getIsFirstTime() {
    return sharedPref.getBool("isFirstTime", defaultValue: true) ?? true;
  }

  String getRefreshToken() {
    return sharedPref.getString("refreshToken") ?? "";
  }

  int getLaunchCount() {
    int count = 0;
    // Get count
    count = sharedPref.getInt("launchCount") ?? 1;
    // save new count
    if (count + 1 == 1000) {
      count = 0;
    }
    sharedPref.setInt("launchCount", count + 1);
    return count;
  }

  bool isModPreProd() {
    return sharedPref.getBoolean("modPreProd") ?? false;
  }

  void setModPreProd(bool modePreProd) {
    sharedPref.setBoolean("modPreProd", modePreProd);
  }

  void setRefreshToken(String refreshToken) {
    sharedPref.setString("refreshToken", refreshToken);
  }

  String getLang() {
    return sharedPref.getString("lang") ?? "fr";
  }

  String getLangHeader() {
    String lang = getLang();
    if (lang == "en") {
      lang = "eng";
    } else if (lang == "ko") {
      lang = "kr";
    } else if (lang == "zh") {
      lang = "cn";
    } else if (lang == "af") {
      lang = "mg";
    }
    return lang;
  }

  String getUserToken() {
    return sharedPref.getString("userToken") ?? "";
  }

  void setUserToken(String token) {
    sharedPref.setString("userToken", token);
  }

  double getTextScale() {
    return sharedPref.getDouble("textScale") ?? 1.0;
  }

  void setTextScale(double textScale) {
    sharedPref.setDouble("textScale", textScale);
  }
}

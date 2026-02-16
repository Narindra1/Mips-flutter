/// Classe permettant de stocker toutes les valeurs constantes.
enum Language { fr, en, mg }

const String baseUrlAPI_PROD = "https://admin.mips.mg/api";
const String baseUrl_PROD = "https://admin.mips.mg/";
const String hostName_PROD = "admin.mips.mg";
// const String baseUrlAPI_PROD = "https://dev.mips.mg/api";
// const String baseUrl_PROD = "https://dev.mips.mg";
// const String hostName_PROD = "dev.mips.mg";

const String baseUrlAPI_Preprod = "https://dev.mips.mg/api";
const String baseUrl_Preprod = "https://dev.mips.mg/";
const String hostName_Preprod = "dev.mips.mg";
const String defaultInternetCheckHostName = "www.google.com";
const String appDateFormat = "dd/MM/yyyy HH:mm:ss";
const double smallPadding = 4.0;
const double mediumPadding = 8.0;
const double largePadding = 16.0;
const int maxImageAnnonceNumber = 3;
const double maxViewWidth = 400.0;
const minMdpLength = 6;
const maxMdpLenght = 8;
const String defaultAnnonceEmptyImageUrl =
    "https://random.imagecdn.app/500/500";

const String urlCUG = "https://admin.mips.mg/CGU";
// const String urlCUG = "https://dev.mips.mg/CGU";
// const String urlDownloadAppUpdate = "https://dev.mips.mg/app/downloadLatest";
const String urlDownloadAppUpdate = "https://admin.mips.mg/app/downloadLatest";
const List<String> mahaNouvelleDefaultImage = [
  'assets/imgs/maha_nouvelle_imgs/001.jpg',
  'assets/imgs/maha_nouvelle_imgs/002.jpg',
  'assets/imgs/maha_nouvelle_imgs/003.jpg',
  'assets/imgs/maha_nouvelle_imgs/004.jpg',
  'assets/imgs/maha_nouvelle_imgs/005.jpg',
  'assets/imgs/maha_nouvelle_imgs/006.jpg',
];
const List<String> conseilDefaultImage = [
  'assets/imgs/conseil_imgs/01.jpg',
  'assets/imgs/conseil_imgs/02.jpg',
  'assets/imgs/conseil_imgs/03.jpg',
  'assets/imgs/conseil_imgs/04.jpg',
  'assets/imgs/conseil_imgs/05.jpg',
  'assets/imgs/conseil_imgs/06.jpg',
  'assets/imgs/conseil_imgs/07.jpg',
  'assets/imgs/conseil_imgs/08.jpg',
  'assets/imgs/conseil_imgs/09.jpg',
  'assets/imgs/conseil_imgs/10.jpg',
];
const String mahaNouvelleMenuRef = "AA";
const String jobOfferMenuRef = "HA";
const String lostAndFoundMenuRef = "HB";
const String blablaZoneMenuRef = "AJ";
const List<String> refFreeAnnonce = [
  mahaNouvelleMenuRef,
  jobOfferMenuRef,
  lostAndFoundMenuRef,
  blablaZoneMenuRef
];
const List<String> provinces = [
  'Antananarivo',
  'Antsiranana',
  'Fianarantsoa',
  'Mahajanga',
  'Toamasina',
  'Toliara',
];
const List<String> imagePaths = [
  'assets/imgs/maha_nouvelle_imgs/001.jpg',
  'assets/imgs/maha_nouvelle_imgs/002.jpg',
  'assets/imgs/maha_nouvelle_imgs/003.jpg',
  'assets/imgs/maha_nouvelle_imgs/004.jpg',
  'assets/imgs/maha_nouvelle_imgs/005.jpg',
  'assets/imgs/maha_nouvelle_imgs/006.jpg',
];

const String iconTonenPath = "assets/imgs/faka_token.png";
const String mipsCoin = "assets/imgs/mips_coin.png";

/// Il faut respecter l'ordre de type dans https://mips.mg/api/annonces-types
enum AnnonceType { premium, sponsor, partenaire, general, vip }

/// Type d'élément de menu.
///
/// Valeurs possibles :
/// - [menuMain] : menu principal.
/// - [menuGroup] : groupe de menus.
/// - [menuPopUp] : menu sous forme de pop-up.
/// - [menu] : élément de menu simple.
enum MenuItemType {
  menuMain,
  menuGroup,
  menuPopUp,
  menu,
}

enum MenuTypeRoute {
  menuScroll,
  menuNotScroll,
  list,
  listBasic,
  listKara,
  page,
  EXCHANGE_RATE,
  MAHA_SONDAGE,
  MAHA_PARTENAIRE,
  MAHA_PLAINTE_SUGGESTION,
  MAHA_AVIS,
  KARA_PARTNER,
  MIPS_INFO,
  none
}

enum AvisType { normal, avisInfo }

enum RewardType {
  popUp,
  pub,
  sondage,
  connexion,
  none,
  // quotidien,
  // particuliers,
  // vehicule,
  // immobilier,
  // shopping,
  // voyage,
  // recherche,
  // divers,
}

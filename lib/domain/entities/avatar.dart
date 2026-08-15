/// Modèle représentant un avatar.
///
/// Contient :
/// - l’identifiant unique de l’avatar ([id])
/// - le prix en FAKA ([priceEnFaka])
/// - le prix en Ariary ([priceFakaAriary])
/// - l’URL de l’image distante ([urlImage])
/// - le chemin de l’image locale ([localImage])
class Avatar {
  final int id;
  final int priceEnFaka;
  final int priceFakaAriary;
  final String urlImage;
  final String localImage;

  const Avatar(
      {required this.id,
      required this.priceEnFaka,
      required this.priceFakaAriary,
      required this.urlImage,
      required this.localImage});
}

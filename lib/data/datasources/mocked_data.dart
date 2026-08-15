import '../../common/constants/constant.dart';

import '../../domain/entities/annonce_tarif_option.dart';

/// Source de données factice utilisée pour les tests et la simulation d'API.
const String annonceTestJson = """
 {
      "id": 13,
      "slug": "nissan-leaf-2025",
      "titre": "Nissan Leaf 2025 - Compacte électrique",
      "lieu": "Clermont-Ferrand, France",
      "contact": "+33 4 73 45 67 89",
      "description_courte": "Nissan Leaf 2025, voiture 100% électrique.",
      "description_detaille": "Nissan Leaf 2025 avec autonomie de 400 km, système ProPILOT, et intérieur spacieux. Disponible en blanc.",
      "created_at": "2025-01-24T10:39:15.000000Z"
    }
""";
final List<AnnonceTarifOption> annonceTarifLocal = [
  const AnnonceTarifOption(
      clientName: "User",
      isAvailable: true,
      dateAvailability: "2029-04-24",
      annonceType: AnnonceType.general,
      tarifTitle: "Général",
      tarifs: [
        Tarif(periode: "1week", priceInFaka: 50000, id: 1),
        Tarif(periode: "1month", priceInFaka: 200000, id: 1),
        Tarif(periode: "3month", priceInFaka: 500000, id: 1)
      ]),
  const AnnonceTarifOption(
      isAvailable: true,
      clientName: "User",
      dateAvailability: "2029-04-24",
      annonceType: AnnonceType.premium,
      tarifTitle: "Premium",
      tarifs: [
        Tarif(periode: "1month", priceInFaka: 400000, id: 1),
        Tarif(periode: "3month", priceInFaka: 1000000, id: 1)
      ]),
];
final List<String> menuDescriptions = [
  "Trouvez des informations utiles pour votre quotidien.",
  "Découvrez des offres uniques.",
  "Vente, location et plus encore.",
  "Vente et location de biens.",
  "Explorez une variété de magasins.",
  "Trouvez les meilleurs services pour vous.",
  "Offres d'emploi et demandes d'achat.",
  "Vos retours pour améliorer l'application.",
];

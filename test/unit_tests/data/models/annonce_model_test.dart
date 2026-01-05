import 'dart:convert';

import 'package:MIPS/data/data.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Create annonce model from Json', () async {
    // act
    final result = AnnonceModel.fromJson(jsonDecode(annonceTestJson));
    // arrange
    // assert
    // expect(
    //     result,
    //     const AnnonceModel(
    //         isFavs: false,
    //         title: "Maison familiale à vendre",
    //         id: "1",
    //         commentaires: [],
    //         description: "",
    //         photos: [
    //           "https://example.com/maison1.jpg",
    //           "https://example.com/maison2.jpg",
    //           "https://example.com/maison2.jpg"
    //         ]));
  });
}

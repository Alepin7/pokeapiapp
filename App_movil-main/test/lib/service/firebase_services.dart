import "package:cloud_firestore/cloud_firestore.dart";

FirebaseFirestore db = FirebaseFirestore.instance;

Future<List> getRank() async {
  List rank = [];
  CollectionReference collectionReferenceRank = db.collection('rank');
  QuerySnapshot queryRank = await collectionReferenceRank.get();
  for (var documento in queryRank.docs) {
    rank.add(documento.data());
  }

  return rank;
}

Future<void> addPokemonV(String name) async {
  await db.collection('rank').add({"name": name, "votos": 1});
}

Future<Map> getUser(String mail) async {
  Map user = {};
  CollectionReference collectionReferenceUser = db.collection('user');
  DocumentSnapshot documentSnapshot =
      await collectionReferenceUser.document(mail).get();
  if (documentSnapshot.exist) {
    user = documentSnapshot.data;
  }
  return user;
}

Future<void> addUserV(String mail, String pokemon) async {
  await db.collection('user').add({
    "mail": mail,
    "favoritos": {"pokemon": pokemon}
  });
}

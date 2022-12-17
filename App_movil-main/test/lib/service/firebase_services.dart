import "package:cloud_firestore/cloud_firestore.dart";

FirebaseFirestore db = FirebaseFirestore.instance;
typedef Json = Map<String, dynamic>;

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
  final voteRef = db.collection('rank').doc(name);
  voteRef.update({"voto": FieldValue.increment(1)});
}

Future<void> removePokemonV(String name) async {
  final voteRef = db.collection('rank').doc(name);
  voteRef.update({"voto": FieldValue.increment(-1)});
}

Stream<Json> getUser(String mail) async* {
  final collectionReferenceUser = db.collection('user');
  final userRef = collectionReferenceUser.doc(mail);
  await for (final doc in userRef.snapshots()) {
    yield doc.data() as Json;
  }
}

Future<void> addUserV(String mail, String pokemon) async {
  final userRef = db.collection('user').doc(mail);
  final user = await userRef.get();
  final favorites = user.data()?["favorito"] as List;
  if (favorites.length > 3) {
    return;
  }

  userRef.update({
    "favorito": FieldValue.arrayUnion([pokemon])
  });
}

Future<void> removeUserV(String mail, String pokemon) async {
  final userRef = db.collection('user').doc(mail);
  userRef.update({
    "favorito": FieldValue.arrayRemove([pokemon])
  });
}

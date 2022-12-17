import "package:cloud_firestore/cloud_firestore.dart";

FirebaseFirestore db = FirebaseFirestore.instance;
typedef Json = Map<String, dynamic>;

Future<Json> getRank() async {
  CollectionReference collectionReferenceRank = db.collection('rank');
  QuerySnapshot queryRank = await collectionReferenceRank.get();
  return {
    for (final documento in queryRank.docs) documento.id: documento.data()
  };
}

Future<void> addPokemonV(String name) async {
  final voteRef =
      db.collection('rank').doc(name).set({"voto": FieldValue.increment(1)});
}

Future<void> removePokemonV(String name) async {
  final voteRef = db.collection('rank').doc(name);
  voteRef.update({"voto": FieldValue.increment(-1)});
}

Stream<Json?> getUser(String mail) async* {
  final collectionReferenceUser = db.collection('user');
  final userRef = collectionReferenceUser.doc(mail);
  await for (final doc in userRef.snapshots()) {
    yield doc.data();
  }
}

Future<void> addUserV(String mail, String pokemon) async {
  db.collection('user').doc(mail).set(
    {
      "favorito": FieldValue.arrayUnion([pokemon])
    },
    SetOptions(merge: true),
  );
}

Future<void> removeUserV(String mail, String pokemon) async {
  db.collection('user').doc(mail).set(
    {
      "favorito": FieldValue.arrayRemove([pokemon])
    },
    SetOptions(merge: true),
  );
}

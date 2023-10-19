import 'package:cloud_firestore/cloud_firestore.dart';

class MyCage {
  var db = FirebaseFirestore.instance;

  Future<bool> insert(
      {required String collectionName,
      required Map<String, dynamic> data}) async {
    try {
      var result = await db.collection(collectionName).add(data);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> delete({required String collectionName, required id}) async {
    try {
      var result = await db.collection(collectionName).doc(id).delete();
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<dynamic> get({
    required String collectionName,
    required String? id,
    required String? filedName,
    required String? filedValue,
  }) async {
    try {
      if (id == null && filedName == null) {
        return db.collection(collectionName).get();
      } else if (id != null) {
        return db.collection(collectionName).doc(id).get();
      } else if (filedName != null) {
        return db
            .collection(collectionName)
            .where(filedName, isEqualTo: filedValue);
      }
    } catch (e) {
      return null;
    }
    return null;
  }
}

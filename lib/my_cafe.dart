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
    String? id,
    String? filedName,
    String? filedValue,
  }) async {
    try {
      if (id == null && filedName == null) {
        return await db.collection(collectionName).get();
      } else if (id != null) {
        return await db.collection(collectionName).doc(id).get();
      } else if (filedName != null) {
        return await db
            .collection(collectionName)
            .where(filedName, isEqualTo: filedValue)
            .get();
      }
    } catch (e) {
      return null;
    }
  }

  Future<bool> update({
    required collectionName,
    required String id,
    required Map<String, dynamic> data,
  }) async {
    try {
      await db.collection(collectionName).doc(id).update(data);
      return true;
    } catch (e) {
      return false;
    }
  }
}

import 'package:chat/src/domain/models/register_user/register_user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<RegisterUserModel>> fetchUsers() async {
    try {
      QuerySnapshot querySnapshot = await _firestore.collection('users').get();
      return querySnapshot.docs.map((doc) => RegisterUserModel.fromFirestore(doc)).toList();
    } catch (e) {
      throw Exception('Failed to fetch users: $e');
    }
  }
}

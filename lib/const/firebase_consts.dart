import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

FirebaseAuth auth = FirebaseAuth.instance;
FirebaseFirestore firestore = FirebaseFirestore.instance;
User? currentUser = auth.currentUser;

//collections
const vendorsCollection = "prodavci";
const productsCollection = "products";
const cartCollection = "karta";
const chatsCollection = "chatovi";
const messagesCollection = "poruke";
const ordersCollection = "Narudžbe";
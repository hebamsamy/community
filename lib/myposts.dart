import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:community/post.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MyPostsScreen extends StatefulWidget {
  const MyPostsScreen({super.key});

  @override
  State<MyPostsScreen> createState() => _MyPostsScreenState();
}

class _MyPostsScreenState extends State<MyPostsScreen> {
  var posts = FirebaseFirestore.instance.collection("posts");
  deletePost(String id){
    posts.doc(id).delete().then((_){

    }).catchError((err){
      print(err);
    });
  }

  @override
  Widget build(BuildContext context) {
        return Scaffold(
      appBar: AppBar(
        title: Text("My Post"),
        actions: [
          ],
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            Navigator.of(context).pushNamed("addpost");
          }),
      body: StreamBuilder(
          stream: posts
          .where("creatorId",isEqualTo: FirebaseAuth.instance.currentUser!.uid)
          // .orderBy("timestamp",descending: true)
          .snapshots(),
          builder: (context, responce) {
            if (responce.connectionState == ConnectionState.done ||
                responce.connectionState == ConnectionState.active) {
              if (responce.data!.docs.isNotEmpty) {
                return ListView(
                    children: responce.data!.docs
                        .map((item) => PostCard(post: item.data(),
                         fristButtonOnPress: (){
                          deletePost(item.id);
                         }, fristIcon: Icon(Icons.delete,color: Colors.red,),
                         secondButtonOnPress: (){}, secondIcon: Icon(Icons.edit, color: Colors.amber,),
                         ))
                        .toList());
              } else {
                return Center(
                  child: Text("NO Data Found"),
                );
              }
            } else {
              return Center(child: CircularProgressIndicator());
            }
          }),
    );
  }
}

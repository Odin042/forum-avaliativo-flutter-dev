import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:forumavalativo/post_detail.dart';
import 'package:forumavalativo/http_service.dart';
import 'package:forumavalativo/post_model.dart';

class PostsPage extends StatelessWidget {
  final HttpService httpService = HttpService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Posts"),
        actions:<Widget> [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => PostDetail(post: Post(
                    userId: 1,
                    id: 1,
                    title: "Forum avaliativo",
                    body: "Trabalho feito!",
                  )),
                ),
              );
            },
          ),]
      ),
       body: FutureBuilder(
        future: httpService.getPosts(),
        builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
          if (snapshot.hasData) {
            List<Post> posts = snapshot.data as List<Post>;
            return ListView(
                children: posts
                    .map(
                      (Post post) => ListTile(
                        title: Text(post.title),
                        subtitle: Text("${post.userId}"),
                        onTap: () => Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => PostDetail(
                              post: post
                            )
                          )
                        )
                      ),
                    )
                    .toList());
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}

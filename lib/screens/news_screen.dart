 import 'package:flutter/material.dart';
 import '../services/api_service.dart';

 class NewsScreen extends StatefulWidget {
   @override
   State<NewsScreen> createState() => _NewsScreenState();
 }

 class _NewsScreenState extends State<NewsScreen> {

   List news = [];
   bool loading = true;
   String error = "";

   @override
   void initState() {
     super.initState();
     loadNews();
   }

   Future<void> loadNews() async {
     try {
       final data = await ApiService.fetchPosts();

       setState(() {
         news = data;
         loading = false;
       });

     } catch (e) {
       setState(() {
         error = e.toString();
         loading = false;
       });
     }
   }

   @override
   Widget build(BuildContext context) {
     return Scaffold(
       appBar: AppBar(title: Text("Election News")),

       body: loading
           ? Center(child: CircularProgressIndicator())

           : error.isNotEmpty
               ? Center(child: Text(error))

               : ListView.builder(
                   itemCount: news.length,
                   itemBuilder: (context, index) {

                     final item = news[index];

                     return Card(
                       margin: EdgeInsets.all(10),
                       child: ListTile(
                         title: Text(
                           item["title"] ?? "No title",
                           maxLines: 2,
                           overflow: TextOverflow.ellipsis,
                         ),
                         subtitle: Text(
                           item["body"] ?? "",
                           maxLines: 2,
                           overflow: TextOverflow.ellipsis,
                         ),
                       ),
                     );
                   },
                 ),
     );
   }
 }
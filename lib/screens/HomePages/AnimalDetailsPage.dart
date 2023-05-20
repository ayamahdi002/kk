

// class AnimalDetailsPage extends StatelessWidget {
//   final Post post;

//   const AnimalDetailsPage({Key? key, required this.post}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(post.name),
//       ),
//       body: Padding(
//         padding: EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             post.photo != null
//                 ? Image.file(
//                     post.photo!,
//                     height: 200.0,
//                     width: double.infinity,
//                     fit: BoxFit.cover,
//                   )
//                 : Icon(Icons.photo),
//             SizedBox(height: 16.0),
//             Text(
//               'Bio:',
//               style: TextStyle(
//                 fontWeight: FontWeight.bold,
//                 fontSize: 16.0,
//               ),
//             ),
//             SizedBox(height: 8.0),
//             Text(
//               post.bio,
//               style: TextStyle(fontSize: 16.0),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
// import 'package:algolia_helper_flutter/algolia_helper_flutter.dart';
// import 'package:flutter/material.dart';
// import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

// void main() {
//   runApp(const MyApp());
// }

// /// A simple class to hold search metadata from the Algolia response.
// class SearchMetadata {
//   final int nbHits;
//   const SearchMetadata(this.nbHits);

//   factory SearchMetadata.fromResponse(SearchResponse response) =>
//       SearchMetadata(response.nbHits);
// }

// /// Data model for a Manual. It maps the JSON fields to Dart types.
// class Manual {
//   final int id;
//   final String title;
//   final String description;
//   final bool pub;
//   final int createdBy;
//   final DateTime createdAt;

//   Manual({
//     required this.id,
//     required this.title,
//     required this.description,
//     required this.pub,
//     required this.createdBy,
//     required this.createdAt,
//   });

//   factory Manual.fromJson(Map<String, dynamic> json) {
//     return Manual(
//       id: json['id'] as int,
//       title: json['title'] as String,
//       description: json['description'] as String,
//       pub: json['public'] as bool,
//       createdBy: json['createdBy'] as int,
//       createdAt: DateTime.parse(json['createdAt'] as String),
//     );
//   }
// }

// /// A helper class that represents a page of search hits.
// class HitsPageManual {
//   final List<Manual> items;
//   final int pageKey;
//   final int? nextPageKey;
//   final bool isLastPage;

//   const HitsPageManual(
//       this.items, this.pageKey, this.nextPageKey, this.isLastPage);

//   factory HitsPageManual.fromResponse(SearchResponse response) {
//     final items = response.hits.map(Manual.fromJson).toList();
//     final isLastPage = response.page + 1 >= response.nbPages;
//     final nextPageKey = isLastPage ? null : response.page + 1;
//     return HitsPageManual(items, response.page, nextPageKey, isLastPage);
//   }
// }

// /// The main application widget.
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Algolia Manuals Search',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: const MyHomePage(title: 'Search Manuals'),
//       debugShowCheckedModeBanner: false,
//     );
//   }
// }

// /// The home page widget that performs the search.
// class MyHomePage extends StatefulWidget {
//   final String title;
//   const MyHomePage({super.key, required this.title});
//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }

// /// State for MyHomePage that handles search requests and pagination.
// class _MyHomePageState extends State<MyHomePage> {
//   final TextEditingController _searchTextController = TextEditingController();

//   // Initialize the Algolia searcher with your credentials and your index name.
//   final HitsSearcher _manualsSearcher = HitsSearcher(
//     applicationID: 'IQD8SWQI6A',
//     apiKey: 'bdca1a0ef1aa36eb8f91a9cb7725a60e',
//     indexName: 'movies_index',
//   );

//   /// Creates a stream mapping search responses to metadata.
//   Stream<SearchMetadata> get _searchMetadata =>
//       _manualsSearcher.responses.map(SearchMetadata.fromResponse);

//   /// Creates a stream mapping search responses to a page of Manuals.
//   Stream<HitsPageManual> get _searchPage =>
//       _manualsSearcher.responses.map(HitsPageManual.fromResponse);

//   /// Paging state is used for the infinite scrolling list.
//   PagingState<int, Manual> _pagingState = PagingState(
//     hasNextPage: true,
//     isLoading: false,
//   );

//   @override
//   void initState() {
//     super.initState();

//     // Listen to text changes and trigger a new search; page resets to 0 on new query.
//     _searchTextController.addListener(() {
//       _manualsSearcher.applyState(
//         (state) => state.copyWith(
//           query: _searchTextController.text,
//           page: 0,
//         ),
//       );
//     });

//     // Listen to search responses and update the pagination state.
//     _searchPage.listen(
//       (page) {
//         setState(() {
//           _pagingState = _pagingState.copyWith(
//             pages: page.pageKey == 0
//                 ? [page.items]
//                 : [...?_pagingState.pages, page.items],
//             keys: page.pageKey == 0
//                 ? [page.pageKey]
//                 : [...?_pagingState.keys, page.pageKey],
//             hasNextPage: !page.isLastPage,
//             isLoading: false,
//           );
//         });
//       },
//       onError: (error) {
//         setState(() => _pagingState = _pagingState.copyWith(error: error));
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.title),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Column(
//           children: [
//             // The search field.
//             SizedBox(
//               height: 44,
//               child: TextField(
//                 controller: _searchTextController,
//                 decoration: const InputDecoration(
//                   border: OutlineInputBorder(),
//                   hintText: 'Search manuals...',
//                   prefixIcon: Icon(Icons.search),
//                 ),
//               ),
//             ),
//             // Display the number of hits.
//             StreamBuilder<SearchMetadata>(
//               stream: _searchMetadata,
//               builder: (context, snapshot) {
//                 if (!snapshot.hasData) return Container();
//                 return Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Text('${snapshot.data!.nbHits} hits found'),
//                 );
//               },
//             ),
//             // The list of results using infinite scroll.
//             Expanded(
//               child: PagedListView<int, Manual>(
//                 state: _pagingState,
//                 fetchNextPage: () async {
//                   _manualsSearcher.applyState(
//                     (state) => state.copyWith(
//                       page: (_pagingState.keys?.last ?? -1) + 1,
//                     ),
//                   );
//                 },
//                 builderDelegate: PagedChildBuilderDelegate<Manual>(
//                   noItemsFoundIndicatorBuilder: (_) => const Center(
//                     child: Text('No manuals found'),
//                   ),
//                   itemBuilder: (context, manual, index) => Card(
//                     margin: const EdgeInsets.symmetric(vertical: 4),
//                     child: ListTile(
//                       title: Text(manual.title),
//                       subtitle: Text(manual.description),
//                       trailing: Text(
//                         manual.createdAt.toLocal().toString().split(' ')[0],
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     _searchTextController.dispose();
//     _manualsSearcher.dispose();
//     super.dispose();
//   }
// }

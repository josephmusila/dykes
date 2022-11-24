// void searchWorkerbyQuery(String query) {
//   setState(() {
//     currentScreen = CurrentScreen.search;
//     searchKeyWord = query.toLowerCase();
//     // var response = searchWorker.getWorkerBySearch(query.toLowerCase());
//
//     print(searchKeyWord);
//   });
//
//   if (query == "") {
//     setState(() {
//       currentScreen = CurrentScreen.couresel;
//     });
//   }
//
//   //   final suggestions = allWorkers.where((worker) {
//   //     final location = worker.location.toLowerCase();
//   //     final input = query.toLowerCase();
//   //     return location.contains(input);
//   //   }).toList();
//   //   print(query);
//
//   //   setState(() {
//   //     worker = suggestions;
//   //   });
// }
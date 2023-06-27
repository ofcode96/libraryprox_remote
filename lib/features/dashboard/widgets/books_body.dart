// ignore_for_file: prefer_is_empty, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:libraryprox_remote/common/widgets/dot_state.dart';
import 'package:libraryprox_remote/common/widgets/loader.dart';
import 'package:libraryprox_remote/features/dashboard/screens/books_actions_screens.dart';
import 'package:libraryprox_remote/features/dashboard/services/books_services.dart';
import 'package:libraryprox_remote/features/dashboard/widgets/custom_search.dart';
import 'package:libraryprox_remote/models/book_model.dart';

class BooksBody extends StatefulWidget {
  const BooksBody({Key? key}) : super(key: key);

  @override
  State<BooksBody> createState() => _BooksBodyState();
}

class _BooksBodyState extends State<BooksBody> {
  final BooksServices booksServices = BooksServices();
  List<Books>? books;
  String strQuiry = "";

  fetchAllBooks() async {
    books = await booksServices.getAllBooks(context, null);

    books?.sort((a, b) => b.id.compareTo(a.id));

    setState(() {});
  }

  searchBook(String query) async {
    strQuiry = query;
    if (strQuiry.isNotEmpty) {
      books = await booksServices.getAllBooks(context, strQuiry);
    } else {
      books = await booksServices.getAllBooks(context, null);
    }

    setState(() {});
  }

  _getData() async {
    await Future.delayed(const Duration(seconds: 1));
    AppLocalizations? local = AppLocalizations.of(context)!;
    if (books == null) {
      throw local.nobooks;
    }
    if (books!.length <= 0) {
      throw local.notfound;
    }
    return;
  }

  @override
  void initState() {
    fetchAllBooks();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(12),
        child: SizedBox(
          height: double.maxFinite,
          child: Column(
            children: [
              // Search Bar
              CustomeSearch(
                onChanged: searchBook,
              ),

              const SizedBox(
                height: 20,
              ),
              // List Of Items

              FutureBuilder(
                  future: _getData(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Loader();
                    }
                    if (snapshot.hasError) {
                      return Center(child: Text(snapshot.error.toString()));
                    } else {
                      return Expanded(
                        child: SingleChildScrollView(
                          child: ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: books?.length,
                            itemBuilder: (context, index) {
                              var book = books![index];

                              return InkWell(
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => BooksActionsScreen(
                                        book: book,
                                      ),
                                    ),
                                  );
                                },
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  elevation: 4,
                                  child: Padding(
                                    padding: const EdgeInsets.all(15),
                                    child: Stack(
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  .7,
                                              child: Text(
                                                book.title,
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 1,
                                                softWrap: true,
                                                style: const TextStyle(
                                                  fontSize: 20,
                                                ),
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 3,
                                            ),
                                            Text(
                                              book.id.toString(),
                                              style: const TextStyle(
                                                  fontStyle: FontStyle.italic,
                                                  fontSize: 14,
                                                  backgroundColor: Colors.grey,
                                                  color: Colors.white),
                                            ),
                                          ],
                                        ),
                                        DotState(isSoccess: book.isAviable)
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      );
                    }
                  })
            ],
          ),
        ));
  }
}

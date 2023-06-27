// ignore_for_file: prefer_is_empty

import 'package:flutter/material.dart';
import 'package:libraryprox_remote/common/helpers/time_converter.dart';
import 'package:libraryprox_remote/common/helpers/transelator.dart';
import 'package:libraryprox_remote/common/widgets/dot_state.dart';
import 'package:libraryprox_remote/common/widgets/loader.dart';
import 'package:libraryprox_remote/features/dashboard/screens/borrows_actions_screens.dart';
import 'package:libraryprox_remote/features/dashboard/services/borrows_services.dart';
import 'package:libraryprox_remote/features/dashboard/widgets/custom_search.dart';
import 'package:libraryprox_remote/models/borrow_model.dart';

class BorrowsBody extends StatefulWidget {
  const BorrowsBody({Key? key}) : super(key: key);

  @override
  State<BorrowsBody> createState() => _BorrowsBodyState();
}

class _BorrowsBodyState extends State<BorrowsBody> {
  final BorrowsServices borrowsServices = BorrowsServices();
  List<Borrow>? borrows;
  String strQuiry = "";

  fetchAllBorrow() async {
    borrows = await borrowsServices.getAllBorrow(context, null);

    borrows?.sort((a, b) => b.id.compareTo(a.id));

    setState(() {});
  }

  searchBorrow(String query) async {
    strQuiry = query;
    if (strQuiry.isNotEmpty) {
      borrows = await borrowsServices.getAllBorrow(context, strQuiry);
    } else {
      borrows = await borrowsServices.getAllBorrow(context, null);
    }

    setState(() {});
  }

  _getData() async {
    await Future.delayed(const Duration(seconds: 1));
    if (borrows == null) {
      throw "Ther Are no Borrow";
    }
    if (borrows!.length <= 0) {
      throw "Ther Are no borrow in Search";
    }
    return;
  }

  @override
  void initState() {
    fetchAllBorrow();
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
                onChanged: searchBorrow,
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
                          child: Column(
                            children: borrows!.map((borrow) {
                              return InkWell(
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          BorrowsActionsScreen(
                                        borrow: borrow,
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
                                            Text(
                                              borrow.id.toString(),
                                              style:
                                                  const TextStyle(fontSize: 20),
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            const Divider(
                                              height: 5,
                                            ),
                                            Row(
                                              children: [
                                                Chip(
                                                  avatar: const CircleAvatar(
                                                    backgroundColor:
                                                        Colors.green,
                                                    child: Icon(
                                                      Icons.event_available,
                                                      color: Colors.white,
                                                      size: 20,
                                                    ),
                                                  ),
                                                  backgroundColor: Colors.green,
                                                  label: Text(
                                                    TimeConverter
                                                        .convertToRealTime(
                                                            borrow.startDate),
                                                    style: const TextStyle(
                                                        fontSize: 15,
                                                        color: Colors.white),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  width: 5,
                                                ),
                                                Chip(
                                                  avatar: const CircleAvatar(
                                                    backgroundColor:
                                                        Colors.redAccent,
                                                    child: Icon(
                                                      Icons.event_busy_rounded,
                                                      color: Colors.white,
                                                      size: 20,
                                                    ),
                                                  ),
                                                  backgroundColor:
                                                      Colors.redAccent,
                                                  label: Text(
                                                    TimeConverter
                                                        .convertToRealTime(
                                                            borrow.endDate),
                                                    style: const TextStyle(
                                                        fontSize: 15,
                                                        color: Colors.white),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 3,
                                            ),
                                            Row(
                                              children: [
                                                Chip(
                                                  avatar: const CircleAvatar(
                                                    backgroundColor:
                                                        Color.fromARGB(
                                                            255, 0, 255, 251),
                                                    child: Icon(
                                                      Icons.data_usage_sharp,
                                                      color: Colors.white,
                                                      size: 20,
                                                    ),
                                                  ),
                                                  backgroundColor:
                                                      const Color.fromARGB(
                                                          255, 0, 115, 255),
                                                  label: Text(
                                                    '${TimeConverter.daysBetween(TimeConverter.convertToRealTime(borrow.startDate), TimeConverter.convertToRealTime(borrow.endDate))} ${transelator(context, "Day")} ',
                                                    style: const TextStyle(
                                                        fontSize: 15,
                                                        color: Colors.white),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  width: 5,
                                                ),
                                                Chip(
                                                  avatar: const CircleAvatar(
                                                    backgroundColor:
                                                        Color.fromARGB(
                                                            255, 0, 255, 251),
                                                    child: Icon(
                                                      Icons.data_array,
                                                      color: Colors.white,
                                                      size: 20,
                                                    ),
                                                  ),
                                                  backgroundColor:
                                                      const Color.fromARGB(
                                                          255, 0, 115, 255),
                                                  label: Text(
                                                    '${TimeConverter.daysBetween(DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day).toString(), TimeConverter.convertToRealTime(borrow.endDate))} ${transelator(context, "Days Left")}',
                                                    style: const TextStyle(
                                                        fontSize: 15,
                                                        color: Colors.white),
                                                  ),
                                                )
                                              ],
                                            )
                                          ],
                                        ),
                                        DotState(
                                          isSoccess: borrow.state == 0,
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            }).toList(),
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

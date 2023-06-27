// ignore_for_file: prefer_is_empty

import 'package:flutter/material.dart';
import 'package:libraryprox_remote/common/widgets/loader.dart';

import '../../../models/logs_model.dart';
import '../services/logs_services.dart';

class LogsBody extends StatefulWidget {
  const LogsBody({Key? key}) : super(key: key);

  @override
  State<LogsBody> createState() => _LogsBodyState();
}

class _LogsBodyState extends State<LogsBody> {
  final LogsServices logsServices = LogsServices();
  List<Logs>? logs;

  fetchAllLogs() async {
    logs = await logsServices.getAllLogs(context);

    setState(() {});
  }

  _getData() async {
    await Future.delayed(const Duration(seconds: 1));
    if (logs == null) {
      throw "Ther Are no Logs";
    }
    if (logs!.length <= 0) {
      throw "Ther Are no Logs";
    }

    return;
  }

  @override
  void initState() {
    fetchAllLogs();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(12),
        child: FutureBuilder(
            future: _getData(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Loader();
              }
              if (snapshot.hasError) {
                return Center(child: Text(snapshot.error.toString()));
              } else {
                return SizedBox(
                  height: double.maxFinite,
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      // List Of Items
                      Expanded(
                        child: SingleChildScrollView(
                          child: ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: logs?.length,
                            itemBuilder: (context, index) {
                              var log = logs![index];
                              return Card(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                elevation: 4,
                                child: Padding(
                                  padding: const EdgeInsets.all(15),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        log.opration,
                                        style: const TextStyle(fontSize: 14),
                                      ),
                                      const SizedBox(
                                        height: 3,
                                      ),
                                      Text(
                                        log.date.toString(),
                                        style: const TextStyle(fontSize: 10),
                                      ),
                                      const SizedBox(
                                        height: 3,
                                      ),
                                      Text(
                                        log.user,
                                        style: const TextStyle(fontSize: 14),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      )
                    ],
                  ),
                );
              }
            }));
  }
}

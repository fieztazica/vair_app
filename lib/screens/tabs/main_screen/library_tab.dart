import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vair_app/controllers/library_tab_controller.dart';

class LibraryTab extends StatelessWidget {
  final LibraryTabController _controller = Get.put(LibraryTabController());

  LibraryTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _controller.obx(
        (state) => GridView.builder(
              itemCount: state!.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 5.0,
                crossAxisSpacing: 5.0,
                childAspectRatio: 1.0,
              ),
              itemBuilder: (BuildContext context, int index) {
                var appInfo = state[index];

                return InkWell(
                  onTap: () =>
                      _controller.onAppInfoTapped(appInfo.packageName!),
                  child: GridTile(
                    header: Container(
                      padding: const EdgeInsets.all(5),
                      color: Colors.teal[900]?.withOpacity(0.8),
                      child: Text(
                        appInfo.name!,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.white),
                      ),
                    ),
                    // footer: Container(
                    //   padding: const EdgeInsets.all(5),
                    //   color: Colors.teal[900]?.withOpacity(0.8),
                    //   child: const Row(
                    //     mainAxisAlignment: MainAxisAlignment.end,
                    //     crossAxisAlignment: CrossAxisAlignment.center,
                    //     children: [
                    //       Text(
                    //         "Installed",
                    //         style: TextStyle(
                    //             fontWeight: FontWeight.bold,
                    //             fontSize: 14,
                    //             color: Colors.white),
                    //       )
                    //     ],
                    //   ),
                    // ),
                    child: Container(
                      color: Colors.teal[300],
                      child: Image.memory(
                        appInfo.icon!,
                        fit: BoxFit.cover,
                        // placeholder: (context, url) =>
                        //     const CircularProgressIndicator(),
                        // errorWidget: (context, url, error) =>
                        //     const Icon(Icons.error)
                      ),
                    ),
                  ),
                );
              },
            ),
        onLoading: ListView(
          children: const [
            Padding(padding: EdgeInsets.all(30), child: Text("Loading..."))
          ],
        ),
        onEmpty: const Text("No apps found"),
        onError: (error) => Text(error!));
  }
}

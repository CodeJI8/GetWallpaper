import 'dart:isolate';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_downloader/flutter_downloader.dart';


class FullScreen extends StatefulWidget {
  final String imgUrl;

  const FullScreen({super.key, required this.imgUrl});

  @override
  State<FullScreen> createState() => _FullScreenState();
}

class _FullScreenState extends State<FullScreen> with SingleTickerProviderStateMixin {
  final ReceivePort _port = ReceivePort();

  @override
  void initState() {
    super.initState();

    IsolateNameServer.registerPortWithName(_port.sendPort, 'downloader_send_port');

    _port.listen((dynamic data) async {
      String id = data[0];
      DownloadTaskStatus status = data[1];
      int progress = data[2];

      if (status == DownloadTaskStatus.complete) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text("Download Complete"),
            action: SnackBarAction(
              label: "Open",
              onPressed: () async {
                final tasks = await FlutterDownloader.loadTasksWithRawQuery(
                  query: "SELECT * FROM task WHERE task_id='$id'",
                );
                if (tasks != null && tasks.isNotEmpty) {
                  OpenFile.open('${tasks.first.savedDir}/${tasks.first.filename}');
                }
              },
            ),
          ),
        );
      }
    });

    FlutterDownloader.registerCallback(downloadCallback);

  }

  @override
  void dispose() {
    IsolateNameServer.removePortNameMapping('downloader_send_port');
    super.dispose();
  }


  Future<void> downloadImage() async {
    final status = await Permission.storage.request();
    if (!status.isGranted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Storage permission denied")),
      );
      return;
    }

    final externalDir = await getExternalStorageDirectory();
    final savedDir = externalDir!.path;

    await FlutterDownloader.enqueue(
      url: widget.imgUrl,
      savedDir: savedDir,
      fileName: "wallpaper_${DateTime.now().millisecondsSinceEpoch}.jpg",
      showNotification: true,
      openFileFromNotification: false,
    );

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Download started...")),
    );
  }

  Future<void> setWallpaper() async {
    // You can implement wallpaper setting using platform channel or a package like wallpaper_manager_flutter
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Set wallpaper tapped")),
    );
  }

  Widget buildGlassButton({required String label, required IconData icon, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        margin: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.15),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.white24),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 8,
              offset: Offset(2, 4),
            )
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: Colors.white),
            const SizedBox(width: 8),
            Text(
              label,
              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background image
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(widget.imgUrl),
                fit: BoxFit.cover,
              ),
            ),
          ),

          // Gradient overlay (for readability)
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.transparent, Colors.black.withOpacity(0.6)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
          ),

          // Buttons
          Positioned(
            bottom: 40,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                buildGlassButton(
                  label: "Download",
                  icon: Icons.download_rounded,
                  onTap: downloadImage,
                ),
                buildGlassButton(
                  label: "Set Wallpaper",
                  icon: Icons.wallpaper,
                  onTap: setWallpaper,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

@pragma('vm:entry-point')
void downloadCallback(String id, int status, int progress) {
  final SendPort? send = IsolateNameServer.lookupPortByName('downloader_send_port');
  send?.send([id, status, progress]);
}



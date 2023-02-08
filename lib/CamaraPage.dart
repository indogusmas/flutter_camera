import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

import 'Utils.dart';

class CameraPage extends StatefulWidget {
  const CameraPage({Key? key}) : super(key: key);

  @override
  State<CameraPage> createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {

  late CameraController _cameraController;
  bool isReadyCamera = false;

  Future initCamera() async {
    //Create a Camera Controller
    CameraDescription description = await getCamera(CameraLensDirection.front);
    _cameraController = CameraController(description, ResolutionPreset.high);

    try {
      await _cameraController.initialize().then((_) {
        if (!mounted) return;
        setState(() {
          isReadyCamera = true;
        });
      });
    } on CameraException catch (e) {
      debugPrint("Camera error $e");
    }
  }

  @override
  void initState() {
    super.initState();
    initCamera();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _cameraController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(children: [
            (isReadyCamera && _cameraController.value.isInitialized)
            ? CameraPreview(_cameraController)
            : Container(
            color: Colors.black,
            child: const Center(child: CircularProgressIndicator())),
        Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: MediaQuery
                  .of(context)
                  .size
                  .height * 0.20,
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                  color: Colors.black),
              child:
              Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
                Expanded(
                    child: IconButton(
                      onPressed: () {

                      },
                      iconSize: 50,
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                      icon: const Icon(Icons.circle, color: Colors.white),
                    )),
                const Spacer(),
              ]),
            ))
      ])
    ));
  }
}

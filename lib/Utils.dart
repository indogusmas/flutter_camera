import 'package:camera/camera.dart';

Future<CameraDescription> getCamera(CameraLensDirection dir) async {
  //There is CameraLensDirection
  //CameraLensDirection.front,
  //CameraLensDirection.back
  //You can custom According to Requirement
  //In sample i use CameraLensDirecrion.front
  return await availableCameras().then(
        (List<CameraDescription> cameras) => cameras.firstWhere(
          (CameraDescription camera) => camera.lensDirection == dir,
    ),
  );
}
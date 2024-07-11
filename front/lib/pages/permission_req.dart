import 'package:flutter/material.dart';
import 'package:food_delivery_app/pages/favorite_page.dart';
// import 'package:food_delivery_app/pages/ar_screen.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionRequestPage extends StatefulWidget {
  @override
  _PermissionRequestPageState createState() => _PermissionRequestPageState();
}

class _PermissionRequestPageState extends State<PermissionRequestPage> {
  PermissionStatus _cameraPermissionStatus = PermissionStatus.denied;

  @override
  void initState() {
    print("object");
    super.initState();
    _checkCameraPermission();
    print("objecx111t");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Camera Permission'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'This app requires camera permission to work with AR.',
              textAlign: TextAlign.center,
            ),
            ElevatedButton(
              onPressed: _requestCameraPermission,
              child: Text('Grant Camera Permission'),
            ),
          ],
        ),
      ),
    );
  }

  // Check camera permission
  Future<void> _checkCameraPermission() async {
    print("void");
    final status = await Permission.camera.request();
    print("status : ${status}");
    setState(() {
      _cameraPermissionStatus = status;
    });
    if (_cameraPermissionStatus.isGranted) {
      // Permission is granted
      print('Camera permission granted');
      _navigateToARView();
    } else {
      // Permission is not granted
      print('Camera permission not granted');
    }
  }

  // Request camera permission
  Future<void> _requestCameraPermission() async {
    final status = await Permission.camera.request();
    setState(() {
      _cameraPermissionStatus = status;
    });
    if (_cameraPermissionStatus.isGranted) {
      // Permission is granted
      print('Camera permission granted');
      _navigateToARView();
    } else {
      // Permission is not granted
      print('Camera permission not granted');
      // Optionally, you can show a message to the user that they need to enable it manually.
    }
  }

  // Navigate to AR view page if permission is granted
  void _navigateToARView() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => FavoritesPage()),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:ar_flutter_plugin/datatypes/node_types.dart';
import 'package:ar_flutter_plugin/managers/ar_anchor_manager.dart';
import 'package:ar_flutter_plugin/managers/ar_location_manager.dart';
import 'package:ar_flutter_plugin/managers/ar_object_manager.dart';
import 'package:ar_flutter_plugin/managers/ar_session_manager.dart';
import 'package:ar_flutter_plugin/models/ar_node.dart';
import 'package:ar_flutter_plugin/ar_flutter_plugin.dart';
import 'package:vector_math/vector_math_64.dart' as vector;
import 'package:permission_handler/permission_handler.dart';

class ARViewPage extends StatefulWidget {
  @override
  _ARViewPageState createState() => _ARViewPageState();
}

class _ARViewPageState extends State<ARViewPage> with WidgetsBindingObserver {
  ARSessionManager? arSessionManager;
  ARObjectManager? arObjectManager;
  ARAnchorManager? arAnchorManager;
  ARLocationManager? arLocationManager;
  PermissionStatus _cameraPermissionStatus = PermissionStatus.denied;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addObserver(this);
    _checkCameraPermission();
  }

  @override
  void dispose() {
    arSessionManager?.dispose();
    WidgetsBinding.instance!.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      // Reinitialize AR session when the app resumes
      if (arSessionManager != null) {
        _initializeARSession();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('AR Furniture Store'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ARView(
            onARViewCreated: _onARViewCreated,
          ),
          ElevatedButton(
            onPressed: _requestCameraPermission,
            child: Text('Grant Camera Permission'),
          ),
        ],
      ),
    );
  }

  void _onARViewCreated(
      ARSessionManager sessionManager,
      ARObjectManager objectManager,
      ARAnchorManager anchorManager,
      ARLocationManager locationManager) {
    setState(() {
      arSessionManager = sessionManager;
      arObjectManager = objectManager;
      arAnchorManager = anchorManager;
      arLocationManager = locationManager;
    });

    // Logging
    print('AR Session Manager Initialized');
    print('AR Object Manager Initialized');
    print('AR Anchor Manager Initialized');
    print('AR Location Manager Initialized');

    _initializeARSession();
  }

  void _initializeARSession() {
    if (arSessionManager == null ||
        arObjectManager == null ||
        arAnchorManager == null ||
        arLocationManager == null) {
      print('AR managers are not initialized yet');
      return;
    }

    // Logging
    print('Initializing AR session');

    arSessionManager!.onInitialize(
      showFeaturePoints: false,
      showPlanes: true,
      customPlaneTexturePath: "path/to/texture.png",
      showWorldOrigin: true,
    );
    arObjectManager!.onInitialize();

    // arAnchorManager!.onInitialize();
    // arLocationManager!.onInitialize();

    _addObjectsToScene();
  }

  void _addObjectsToScene() {
    final node = ARNode(
      type: NodeType.localGLTF2,
      uri: 'assets/model.glb',
      scale: vector.Vector3(0.5, 0.5, 0.5),
    );

    // Logging
    print('Adding object to scene: ${node.uri}');

    arObjectManager!.addNode(node).then((success) {
      if (success == true) {
        print('Object added to scene successfully');
      } else {
        print('Failed to add object to scene');
      }
    }).catchError((error) {
      print('Error adding object to scene: $error');
    });
  }

  // Check camera permission
  Future<void> _checkCameraPermission() async {
    final status = await Permission.camera.request();
    setState(() {
      _cameraPermissionStatus = status;
    });
    if (_cameraPermissionStatus.isGranted) {
      // Permission is granted
      print('Camera permission granted');
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
      _initializeARSession(); // Initialize AR session after permission granted
    } else {
      // Permission is not granted
      print('Camera permission not granted');
      // Optionally, you can show a message to the user that they need to enable it manually.
    }
  }
}

import 'package:flutter/material.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

class MapZoomControls extends StatelessWidget {
  final YandexMapController? controller;

  const MapZoomControls({super.key, required this.controller});

  Future<void> _changeZoom(double delta) async {
    if (controller == null) return;

    final cameraPos = await controller!.getCameraPosition();
    final newZoom = (cameraPos.zoom + delta).clamp(2.0, 20.0);

    await controller!.moveCamera(
      CameraUpdate.newCameraPosition(CameraPosition(target: cameraPos.target, zoom: newZoom)),
      animation: const MapAnimation(type: MapAnimationType.smooth, duration: 0.2),
    );
  }

  Widget _zoomButton(IconData icon, VoidCallback onPressed) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        boxShadow: [BoxShadow(color: Colors.black.withAlpha(25), blurRadius: 6)],
      ),
      child: IconButton(icon: Icon(icon, size: 20), onPressed: onPressed),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _zoomButton(Icons.add, () => _changeZoom(1)),
        const SizedBox(height: 8),
        _zoomButton(Icons.remove, () => _changeZoom(-1)),
      ],
    );
  }
}

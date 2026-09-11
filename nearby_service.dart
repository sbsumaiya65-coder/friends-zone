import 'package:nearby_connections/nearby_connections.dart';

class NearbyService {
  final Strategy strategy = Strategy.P2P_CLUSTER;
  final String userName = "Friends Zone User";

  // Start Advertising to be discovered by nearby users
  Future<void> startAdvertising() async {
    try {
      bool aStarted = await Nearby().startAdvertising(
        userName,
        strategy,
        onConnectionInitiated: (String id, ConnectionInfo info) {
          // Automatically accept connection for smooth pairing
          Nearby().acceptConnection(
            id,
            onPayLoadRecieved: (String endpointId, Payload payload) {
              // Handle incoming data/messages here
            },
          );
        },
        onConnectionResult: (String id, Status status) {
          // Handle connection result (Connected, Rejected, Error)
        },
        onDisconnected: (String id) {
          // Handle disconnection
        },
      );
    } catch (e) {
      // Handle exception
    }
  }

  // Start Discovery to find nearby friends
  Future<void> startDiscovery(Function(String, String) onEndpointFound) async {
    try {
      bool dStarted = await Nearby().startDiscovery(
        userName,
        strategy,
        onEndpointFound: (String endpointId, String name, String serviceId) {
          onEndpointFound(endpointId, name);
        },
        onEndpointLost: (String endpointId) {
          // Handle lost endpoint
        },
      );
    } catch (e) {
      // Handle exception
    }
  }

  // Stop all nearby operations
  void stopAll() {
    Nearby().stopAdvertising();
    Nearby().stopDiscovery();
    Nearby().stopAllEndpoints();
  }
}

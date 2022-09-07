class AppDetails {
  final String pubnubSubscribeKey;
  final String pubnubOrigin;
  final int pubnubHeartbeatInternal;
  final int pubnubPresenceTimeout;

  AppDetails(
      {required this.pubnubSubscribeKey,
        required this.pubnubOrigin,
        required this.pubnubHeartbeatInternal,
        required this.pubnubPresenceTimeout});

  factory AppDetails.fromJson(Map<String, dynamic> json) {
    return AppDetails(
        pubnubSubscribeKey: json['pubnub_subscribe_key'],
        pubnubOrigin: json['pubnub_origin'],
        pubnubHeartbeatInternal: json['pubnub_heartbeat_interval'],
        pubnubPresenceTimeout: json['pubnub_presence_timeout']
    );
  }
}
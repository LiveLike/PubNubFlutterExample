class ChatRoomDetails {
  Channels? channels;

  ChatRoomDetails({this.channels});

  ChatRoomDetails.fromJson(Map<String, dynamic> json) {
    channels = json['channels'] != null
        ? new Channels.fromJson(json['channels'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.channels != null) {
      data['channels'] = this.channels!.toJson();
    }
    return data;
  }
}

class Channels {
  Reactions? reactions;
  Chat? chat;
  Reactions? control;

  Channels({this.reactions, this.chat, this.control});

  Channels.fromJson(Map<String, dynamic> json) {
    reactions = json['reactions'] != null
        ? new Reactions.fromJson(json['reactions'])
        : null;
    chat = json['chat'] != null ? new Chat.fromJson(json['chat']) : null;
    control = json['control'] != null
        ? new Reactions.fromJson(json['control'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.reactions != null) {
      data['reactions'] = this.reactions!.toJson();
    }
    if (this.chat != null) {
      data['chat'] = this.chat!.toJson();
    }
    if (this.control != null) {
      data['control'] = this.control!.toJson();
    }
    return data;
  }
}

class Reactions {
  String? pubnub;

  Reactions({this.pubnub});

  Reactions.fromJson(Map<String, dynamic> json) {
    pubnub = json['pubnub'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pubnub'] = this.pubnub;
    return data;
  }
}

class Chat {
  String pubnub = "";
  String? sendbird;

  Chat({required this.pubnub, this.sendbird});

  Chat.fromJson(Map<String, dynamic> json) {
    pubnub = json['pubnub'];
    sendbird = json['sendbird'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pubnub'] = this.pubnub;
    data['sendbird'] = this.sendbird;
    return data;
  }
}

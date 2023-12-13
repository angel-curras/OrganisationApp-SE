class Module {
  int id;
  int zpaId;
  String name;
  int anzahlSprachen;
  String verantwortlich;
  int sws;
  int ects;
  String sprachen;
  String lehrform;
  String angebot;
  String aufwand;
  String voraussetzungen;
  String ziele;
  String inhalt;
  String medienUndMethoden;
  String literatur;
  String url;

  Module({
    required this.id,
    required this.zpaId,
    required this.name,
    required this.anzahlSprachen,
    required this.verantwortlich,
    required this.sws,
    required this.ects,
    required this.sprachen,
    required this.lehrform,
    required this.angebot,
    required this.aufwand,
    required this.voraussetzungen,
    required this.ziele,
    required this.inhalt,
    required this.medienUndMethoden,
    required this.literatur,
    required this.url,
  });

  // Method to convert Dart object to JSON Map
  Map<String, dynamic> toJson() => {
        'id': id,
        'zpaId': zpaId,
        'name': name,
        'anzahlSprachen': anzahlSprachen,
        'verantwortlich': verantwortlich,
        'sws': sws,
        'ects': ects,
        'sprachen': sprachen,
        'lehrform': lehrform,
        'angebot': angebot,
        'aufwand': aufwand,
        'voraussetzungen': voraussetzungen,
        'ziele': ziele,
        'inhalt': inhalt,
        'medienUndMethoden': medienUndMethoden,
        'literatur': literatur,
        'url': url,
      };

  // Method to create Dart object from JSON Map
  factory Module.fromJson(Map<String, dynamic> json) => Module(
        id: json['id'],
        zpaId: json['zpaId'],
        name: json['name'],
        anzahlSprachen: json['anzahlSprachen'],
        verantwortlich: json['verantwortlich'],
        sws: json['sws'],
        ects: json['ects'],
        sprachen: json['sprachen'],
        lehrform: json['lehrform'],
        angebot: json['angebot'],
        aufwand: json['aufwand'],
        voraussetzungen: json['voraussetzungen'],
        ziele: json['ziele'],
        inhalt: json['inhalt'],
        medienUndMethoden: json['medienUndMethoden'],
        literatur: json['literatur'],
        url: json['url'],
      );
}

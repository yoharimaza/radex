// To parse this JSON data, do
//
//     final pokemonInfo = pokemonInfoFromJson(jsonString);

import 'dart:convert';

PokemonInfo pokemonInfoFromJson(String str) => PokemonInfo.fromJson(json.decode(str));

String pokemonInfoToJson(PokemonInfo data) => json.encode(data.toJson());

class PokemonInfo {
  PokemonInfo({
    required this.abilities,
    this.baseExperience,
    required this.forms,
    required this.gameIndices,
    required this.height,
    required this.heldItems,
    required this.id,
    required this.isDefault,
    required this.locationAreaEncounters,
    required this.moves,
    required this.name,
    required this.order,
    required this.pastTypes,
    required this.species,
    required this.sprites,
    required this.stats,
    required this.types,
    required this.weight,
  });

  List<Ability> abilities;
  dynamic baseExperience;
  List<Species> forms;
  List<dynamic> gameIndices;
  int height;
  List<dynamic> heldItems;
  int id;
  bool isDefault;
  String locationAreaEncounters;
  List<Move> moves;
  String name;
  int order;
  List<dynamic> pastTypes;
  Species species;
  Sprites sprites;
  List<Stat> stats;
  List<Type> types;
  int weight;

  factory PokemonInfo.fromJson(Map<String, dynamic> json) => PokemonInfo(
    abilities: List<Ability>.from(json["abilities"].map((x) => Ability.fromJson(x))),
    baseExperience: json["base_experience"],
    forms: List<Species>.from(json["forms"].map((x) => Species.fromJson(x))),
    gameIndices: List<dynamic>.from(json["game_indices"].map((x) => x)),
    height: json["height"],
    heldItems: List<dynamic>.from(json["held_items"].map((x) => x)),
    id: json["id"],
    isDefault: json["is_default"],
    locationAreaEncounters: json["location_area_encounters"],
    moves: List<Move>.from(json["moves"].map((x) => Move.fromJson(x))),
    name: json["name"],
    order: json["order"],
    pastTypes: List<dynamic>.from(json["past_types"].map((x) => x)),
    species: Species.fromJson(json["species"]),
    sprites: Sprites.fromJson(json["sprites"]),
    stats: List<Stat>.from(json["stats"].map((x) => Stat.fromJson(x))),
    types: List<Type>.from(json["types"].map((x) => Type.fromJson(x))),
    weight: json["weight"],
  );

  Map<String, dynamic> toJson() => {
    "abilities": List<dynamic>.from(abilities.map((x) => x.toJson())),
    "base_experience": baseExperience,
    "forms": List<dynamic>.from(forms.map((x) => x.toJson())),
    "game_indices": List<dynamic>.from(gameIndices.map((x) => x)),
    "height": height,
    "held_items": List<dynamic>.from(heldItems.map((x) => x)),
    "id": id,
    "is_default": isDefault,
    "location_area_encounters": locationAreaEncounters,
    "moves": List<dynamic>.from(moves.map((x) => x.toJson())),
    "name": name,
    "order": order,
    "past_types": List<dynamic>.from(pastTypes.map((x) => x)),
    "species": species.toJson(),
    "sprites": sprites.toJson(),
    "stats": List<dynamic>.from(stats.map((x) => x.toJson())),
    "types": List<dynamic>.from(types.map((x) => x.toJson())),
    "weight": weight,
  };
}

class Ability {
  Ability({
    required this.ability,
    required this.isHidden,
    required this.slot,
  });

  Species ability;
  bool isHidden;
  int slot;

  factory Ability.fromJson(Map<String, dynamic> json) => Ability(
    ability: Species.fromJson(json["ability"]),
    isHidden: json["is_hidden"],
    slot: json["slot"],
  );

  Map<String, dynamic> toJson() => {
    "ability": ability.toJson(),
    "is_hidden": isHidden,
    "slot": slot,
  };
}

class Species {
  Species({
    required this.name,
    required this.url,
  });

  String name;
  String url;

  factory Species.fromJson(Map<String, dynamic> json) => Species(
    name: json["name"],
    url: json["url"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "url": url,
  };
}

class Move {
  Move({
    required this.move,
    required this.versionGroupDetails,
  });

  Species move;
  List<VersionGroupDetail> versionGroupDetails;

  factory Move.fromJson(Map<String, dynamic> json) => Move(
    move: Species.fromJson(json["move"]),
    versionGroupDetails: List<VersionGroupDetail>.from(json["version_group_details"].map((x) => VersionGroupDetail.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "move": move.toJson(),
    "version_group_details": List<dynamic>.from(versionGroupDetails.map((x) => x.toJson())),
  };
}

class VersionGroupDetail {
  VersionGroupDetail({
    required this.levelLearnedAt,
    required this.moveLearnMethod,
    required this.versionGroup,
  });

  int levelLearnedAt;
  Species moveLearnMethod;
  Species versionGroup;

  factory VersionGroupDetail.fromJson(Map<String, dynamic> json) => VersionGroupDetail(
    levelLearnedAt: json["level_learned_at"],
    moveLearnMethod: Species.fromJson(json["move_learn_method"]),
    versionGroup: Species.fromJson(json["version_group"]),
  );

  Map<String, dynamic> toJson() => {
    "level_learned_at": levelLearnedAt,
    "move_learn_method": moveLearnMethod.toJson(),
    "version_group": versionGroup.toJson(),
  };
}

class GenerationV {
  GenerationV({
    required this.blackWhite,
  });

  Sprites blackWhite;

  factory GenerationV.fromJson(Map<String, dynamic> json) => GenerationV(
    blackWhite: Sprites.fromJson(json["black-white"]),
  );

  Map<String, dynamic> toJson() => {
    "black-white": blackWhite.toJson(),
  };
}

class GenerationIv {
  GenerationIv({
    required this.diamondPearl,
    required this.heartgoldSoulsilver,
    required this.platinum,
  });

  Sprites diamondPearl;
  Sprites heartgoldSoulsilver;
  Sprites platinum;

  factory GenerationIv.fromJson(Map<String, dynamic> json) => GenerationIv(
    diamondPearl: Sprites.fromJson(json["diamond-pearl"]),
    heartgoldSoulsilver: Sprites.fromJson(json["heartgold-soulsilver"]),
    platinum: Sprites.fromJson(json["platinum"]),
  );

  Map<String, dynamic> toJson() => {
    "diamond-pearl": diamondPearl.toJson(),
    "heartgold-soulsilver": heartgoldSoulsilver.toJson(),
    "platinum": platinum.toJson(),
  };
}

class Versions {
  Versions({
    required this.generationI,
    required this.generationIi,
    required this.generationIii,
    required this.generationIv,
    required this.generationV,
    required this.generationVi,
    required this.generationVii,
    required this.generationViii,
  });

  GenerationI generationI;
  GenerationIi generationIi;
  GenerationIii generationIii;
  GenerationIv generationIv;
  GenerationV generationV;
  Map<String, Home> generationVi;
  GenerationVii generationVii;
  GenerationViii generationViii;

  factory Versions.fromJson(Map<String, dynamic> json) => Versions(
    generationI: GenerationI.fromJson(json["generation-i"]),
    generationIi: GenerationIi.fromJson(json["generation-ii"]),
    generationIii: GenerationIii.fromJson(json["generation-iii"]),
    generationIv: GenerationIv.fromJson(json["generation-iv"]),
    generationV: GenerationV.fromJson(json["generation-v"]),
    generationVi: Map.from(json["generation-vi"]).map((k, v) => MapEntry<String, Home>(k, Home.fromJson(v))),
    generationVii: GenerationVii.fromJson(json["generation-vii"]),
    generationViii: GenerationViii.fromJson(json["generation-viii"]),
  );

  Map<String, dynamic> toJson() => {
    "generation-i": generationI.toJson(),
    "generation-ii": generationIi.toJson(),
    "generation-iii": generationIii.toJson(),
    "generation-iv": generationIv.toJson(),
    "generation-v": generationV.toJson(),
    "generation-vi": Map.from(generationVi).map((k, v) => MapEntry<String, dynamic>(k, v.toJson())),
    "generation-vii": generationVii.toJson(),
    "generation-viii": generationViii.toJson(),
  };
}

class Sprites {
  Sprites({
    this.backDefault,
    this.backFemale,
    this.backShiny,
    this.backShinyFemale,
    this.frontDefault,
    this.frontFemale,
    this.frontShiny,
    this.frontShinyFemale,
    this.other,
    this.versions,
    this.animated,
  });

  dynamic backDefault;
  dynamic backFemale;
  dynamic backShiny;
  dynamic backShinyFemale;
  String? frontDefault;
  dynamic frontFemale;
  dynamic frontShiny;
  dynamic frontShinyFemale;
  Other? other;
  Versions? versions;
  Sprites? animated;

  factory Sprites.fromJson(Map<String, dynamic> json) => Sprites(
    backDefault: json["back_default"],
    backFemale: json["back_female"],
    backShiny: json["back_shiny"],
    backShinyFemale: json["back_shiny_female"],
    frontDefault: json["front_default"],
    frontFemale: json["front_female"],
    frontShiny: json["front_shiny"],
    frontShinyFemale: json["front_shiny_female"],
    other: json["other"] == null ? null : Other.fromJson(json["other"]),
    versions: json["versions"] == null ? null : Versions.fromJson(json["versions"]),
    animated: json["animated"] == null ? null : Sprites.fromJson(json["animated"]),
  );

  Map<String, dynamic> toJson() => {
    "back_default": backDefault,
    "back_female": backFemale,
    "back_shiny": backShiny,
    "back_shiny_female": backShinyFemale,
    "front_default": frontDefault,
    "front_female": frontFemale,
    "front_shiny": frontShiny,
    "front_shiny_female": frontShinyFemale,
    "other": other?.toJson(),
    "versions": versions?.toJson(),
    "animated": animated?.toJson(),
  };
}

class GenerationI {
  GenerationI({
    required this.redBlue,
    required this.yellow,
  });

  RedBlue redBlue;
  RedBlue yellow;

  factory GenerationI.fromJson(Map<String, dynamic> json) => GenerationI(
    redBlue: RedBlue.fromJson(json["red-blue"]),
    yellow: RedBlue.fromJson(json["yellow"]),
  );

  Map<String, dynamic> toJson() => {
    "red-blue": redBlue.toJson(),
    "yellow": yellow.toJson(),
  };
}

class RedBlue {
  RedBlue({
    this.backDefault,
    this.backGray,
    this.backTransparent,
    this.frontDefault,
    this.frontGray,
    this.frontTransparent,
  });

  dynamic backDefault;
  dynamic backGray;
  dynamic backTransparent;
  dynamic frontDefault;
  dynamic frontGray;
  dynamic frontTransparent;

  factory RedBlue.fromJson(Map<String, dynamic> json) => RedBlue(
    backDefault: json["back_default"],
    backGray: json["back_gray"],
    backTransparent: json["back_transparent"],
    frontDefault: json["front_default"],
    frontGray: json["front_gray"],
    frontTransparent: json["front_transparent"],
  );

  Map<String, dynamic> toJson() => {
    "back_default": backDefault,
    "back_gray": backGray,
    "back_transparent": backTransparent,
    "front_default": frontDefault,
    "front_gray": frontGray,
    "front_transparent": frontTransparent,
  };
}

class GenerationIi {
  GenerationIi({
    required this.crystal,
    required this.gold,
    required this.silver,
  });

  Crystal crystal;
  Gold gold;
  Gold silver;

  factory GenerationIi.fromJson(Map<String, dynamic> json) => GenerationIi(
    crystal: Crystal.fromJson(json["crystal"]),
    gold: Gold.fromJson(json["gold"]),
    silver: Gold.fromJson(json["silver"]),
  );

  Map<String, dynamic> toJson() => {
    "crystal": crystal.toJson(),
    "gold": gold.toJson(),
    "silver": silver.toJson(),
  };
}

class Crystal {
  Crystal({
    this.backDefault,
    this.backShiny,
    this.backShinyTransparent,
    this.backTransparent,
    this.frontDefault,
    this.frontShiny,
    this.frontShinyTransparent,
    this.frontTransparent,
  });

  dynamic backDefault;
  dynamic backShiny;
  dynamic backShinyTransparent;
  dynamic backTransparent;
  dynamic frontDefault;
  dynamic frontShiny;
  dynamic frontShinyTransparent;
  dynamic frontTransparent;

  factory Crystal.fromJson(Map<String, dynamic> json) => Crystal(
    backDefault: json["back_default"],
    backShiny: json["back_shiny"],
    backShinyTransparent: json["back_shiny_transparent"],
    backTransparent: json["back_transparent"],
    frontDefault: json["front_default"],
    frontShiny: json["front_shiny"],
    frontShinyTransparent: json["front_shiny_transparent"],
    frontTransparent: json["front_transparent"],
  );

  Map<String, dynamic> toJson() => {
    "back_default": backDefault,
    "back_shiny": backShiny,
    "back_shiny_transparent": backShinyTransparent,
    "back_transparent": backTransparent,
    "front_default": frontDefault,
    "front_shiny": frontShiny,
    "front_shiny_transparent": frontShinyTransparent,
    "front_transparent": frontTransparent,
  };
}

class Gold {
  Gold({
    this.backDefault,
    this.backShiny,
    this.frontDefault,
    this.frontShiny,
    this.frontTransparent,
  });

  dynamic backDefault;
  dynamic backShiny;
  dynamic frontDefault;
  dynamic frontShiny;
  dynamic frontTransparent;

  factory Gold.fromJson(Map<String, dynamic> json) => Gold(
    backDefault: json["back_default"],
    backShiny: json["back_shiny"],
    frontDefault: json["front_default"],
    frontShiny: json["front_shiny"],
    frontTransparent: json["front_transparent"],
  );

  Map<String, dynamic> toJson() => {
    "back_default": backDefault,
    "back_shiny": backShiny,
    "front_default": frontDefault,
    "front_shiny": frontShiny,
    "front_transparent": frontTransparent,
  };
}

class GenerationIii {
  GenerationIii({
    required this.emerald,
    required this.fireredLeafgreen,
    required this.rubySapphire,
  });

  OfficialArtwork emerald;
  Gold fireredLeafgreen;
  Gold rubySapphire;

  factory GenerationIii.fromJson(Map<String, dynamic> json) => GenerationIii(
    emerald: OfficialArtwork.fromJson(json["emerald"]),
    fireredLeafgreen: Gold.fromJson(json["firered-leafgreen"]),
    rubySapphire: Gold.fromJson(json["ruby-sapphire"]),
  );

  Map<String, dynamic> toJson() => {
    "emerald": emerald.toJson(),
    "firered-leafgreen": fireredLeafgreen.toJson(),
    "ruby-sapphire": rubySapphire.toJson(),
  };
}

class OfficialArtwork {
  OfficialArtwork({
    this.frontDefault,
    this.frontShiny,
  });

  String? frontDefault;
  String? frontShiny;

  factory OfficialArtwork.fromJson(Map<String, dynamic> json) => OfficialArtwork(
    frontDefault: json["front_default"],
    frontShiny: json["front_shiny"],
  );

  Map<String, dynamic> toJson() => {
    "front_default": frontDefault,
    "front_shiny": frontShiny,
  };
}

class Home {
  Home({
    this.frontDefault,
    this.frontFemale,
    this.frontShiny,
    this.frontShinyFemale,
  });

  dynamic frontDefault;
  dynamic frontFemale;
  dynamic frontShiny;
  dynamic frontShinyFemale;

  factory Home.fromJson(Map<String, dynamic> json) => Home(
    frontDefault: json["front_default"],
    frontFemale: json["front_female"],
    frontShiny: json["front_shiny"],
    frontShinyFemale: json["front_shiny_female"],
  );

  Map<String, dynamic> toJson() => {
    "front_default": frontDefault,
    "front_female": frontFemale,
    "front_shiny": frontShiny,
    "front_shiny_female": frontShinyFemale,
  };
}

class GenerationVii {
  GenerationVii({
    required this.icons,
    required this.ultraSunUltraMoon,
  });

  DreamWorld icons;
  Home ultraSunUltraMoon;

  factory GenerationVii.fromJson(Map<String, dynamic> json) => GenerationVii(
    icons: DreamWorld.fromJson(json["icons"]),
    ultraSunUltraMoon: Home.fromJson(json["ultra-sun-ultra-moon"]),
  );

  Map<String, dynamic> toJson() => {
    "icons": icons.toJson(),
    "ultra-sun-ultra-moon": ultraSunUltraMoon.toJson(),
  };
}

class DreamWorld {
  DreamWorld({
    this.frontDefault,
    this.frontFemale,
  });

  dynamic frontDefault;
  dynamic frontFemale;

  factory DreamWorld.fromJson(Map<String, dynamic> json) => DreamWorld(
    frontDefault: json["front_default"],
    frontFemale: json["front_female"],
  );

  Map<String, dynamic> toJson() => {
    "front_default": frontDefault,
    "front_female": frontFemale,
  };
}

class GenerationViii {
  GenerationViii({
    required this.icons,
  });

  DreamWorld icons;

  factory GenerationViii.fromJson(Map<String, dynamic> json) => GenerationViii(
    icons: DreamWorld.fromJson(json["icons"]),
  );

  Map<String, dynamic> toJson() => {
    "icons": icons.toJson(),
  };
}

class Other {
  Other({
    required this.dreamWorld,
    required this.home,
    required this.officialArtwork,
  });

  DreamWorld dreamWorld;
  Home home;
  OfficialArtwork officialArtwork;

  factory Other.fromJson(Map<String, dynamic> json) => Other(
    dreamWorld: DreamWorld.fromJson(json["dream_world"]),
    home: Home.fromJson(json["home"]),
    officialArtwork: OfficialArtwork.fromJson(json["official-artwork"]),
  );

  Map<String, dynamic> toJson() => {
    "dream_world": dreamWorld.toJson(),
    "home": home.toJson(),
    "official-artwork": officialArtwork.toJson(),
  };
}

class Stat {
  Stat({
    required this.baseStat,
    required this.effort,
    required this.stat,
  });

  int baseStat;
  int effort;
  Species stat;

  factory Stat.fromJson(Map<String, dynamic> json) => Stat(
    baseStat: json["base_stat"],
    effort: json["effort"],
    stat: Species.fromJson(json["stat"]),
  );

  Map<String, dynamic> toJson() => {
    "base_stat": baseStat,
    "effort": effort,
    "stat": stat.toJson(),
  };
}

class Type {
  Type({
    required this.slot,
    required this.type,
  });

  int slot;
  Species type;

  factory Type.fromJson(Map<String, dynamic> json) => Type(
    slot: json["slot"],
    type: Species.fromJson(json["type"]),
  );

  Map<String, dynamic> toJson() => {
    "slot": slot,
    "type": type.toJson(),
  };
}

import 'package:json_annotation/json_annotation.dart';

part 'movie.g.dart';

@JsonSerializable()
class Movie {
  final int id;
  final String title;
  final String overview;
  @JsonKey(name: 'poster_path')
  String? posterPath;
  @JsonKey(name: 'backdrop_path')
  final String? backdropPath;
  @JsonKey(name: 'release_date')
  final String? releaseDate;
  @JsonKey(name: 'vote_average')
  final double voteAverage; 

  Movie({required this.id, required this.title, required this.overview, this.posterPath, this.releaseDate, required this.voteAverage, this.backdropPath});
  
  factory Movie.fromJson(Map<String, dynamic> json) => _$MovieFromJson(json);

  Map<String, dynamic> toJson() => _$MovieToJson(this);

  @override
  String toString() {
    return 'Movie(id: $id, title: $title, overview: $overview)';
  }

  //Récupérer l'url de l'affiche du film
  String get posterUrl{
    return (posterPath != null) ? 'https://image.tmdb.org/t/p/w500$posterPath' : '';
  }

  ///Récupérer l'url de l'image de fond du film
  String get backdropUrl{
    return (backdropPath != null) ? 'https://image.tmdb.org/t/p/w780$backdropPath' : '';
  }

  //Récupérer l'année de sortie du film
  String get releaseYear {
    if (releaseDate == null || releaseDate!.isEmpty) return '';
    return releaseDate!.substring(0, 4);
  }

}
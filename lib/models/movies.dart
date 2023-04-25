import 'package:flutter/material.dart';
import 'package:moviesappbinary/main.dart';

class Movie {
final String title;
final String year;
final String imdbID;
final String poster;
final String Type;


Movie({
required this.title,
required this.year,
required this.imdbID,
required this.poster,
required this.Type
});

factory Movie.fromJson(Map<String, dynamic> json) {
return Movie(
title: json['Title'] as String,
year: json['Year'] as String,
imdbID: json['imdbID'] as String,
poster: json['Poster'] as String,
Type: json['Type'] as String,
);
}
}

class MovieDetails {
final String title;
final String year;
final String rated;
final String released;
final String runtime;
final String genre;
final String director;
final String writer;
final String actors;
final String plot;
final String language;
final String country;
final String awards;
final String poster;
final List<Rating> ratings;
final String metascore;
final String imdbRating;
final String imdbVotes;
final String imdbID;
final String type;
final String dvd;
final String boxOffice;
final String production;
final String website;

MovieDetails({
required this.title,
required this.year,
required this.rated,
required this.released,
required this.runtime,
required this.genre,
required this.director,
required this.writer,
required this.actors,
required this.plot,
required this.language,
required this.country,
required this.awards,
required this.poster,
required this.ratings,
required this.metascore,
required this.imdbRating,
required this.imdbVotes,
required this.imdbID,
required this.type,
required this.dvd,
required this.boxOffice,
required this.production,
required this.website,
});

factory MovieDetails.fromJson(Map<String, dynamic> json) {
return MovieDetails(
title: json['Title'] as String,
year: json['Year'] as String,
rated: json['Rated'] as String,
released: json['Released'] as String,
runtime: json['Runtime'] as String,
genre: json['Genre'] as String,
director: json['Director'] as String,
writer: json['Writer'] as String,
actors: json['Actors'] as String,
plot: json['Plot'] as String,
language: json['Language'] as String,
country: json['Country'] as String,
awards: json['Awards'] as String,
poster: json['Poster'] as String,
ratings: (json['Ratings'] as List<dynamic>).map((r) => Rating.fromJson(r)).toList(),
metascore: json['Metascore'] as String,
imdbRating: json['imdbRating'] as String,
imdbVotes: json['imdbVotes'] as String,
imdbID: json['imdbID'] as String,
type: json['Type'] as String,
dvd: json['DVD'] as String,
boxOffice: json['BoxOffice'] as String,
production: json['Production'] as String,
website: json['Website'] as String,
);
}
}

class Rating {
final String source;
final String value;

Rating({
required this.source,
required this.value,
});

factory Rating.fromJson(Map<String, dynamic> json) {
return Rating(
source: json['Source'] as String,
value: json['Value'] as String,
);
}
}
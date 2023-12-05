import 'package:flutter/material.dart';
import 'package:movieflix/models/movie.dart';
import 'package:movieflix/screens/detail_screen.dart';
import 'package:movieflix/services/api_service.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(
            vertical: 50.0,
            horizontal: 15.0,
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                _Populars(),
                _Playings(),
                _Comings(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Populars extends StatelessWidget {
  _Populars({super.key});

  Future<List<Movie>> populars = ApiService.getPopularMovies();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Popular Movies",
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(
          height: 20.0,
        ),
        FutureBuilder(
          future: populars,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return SizedBox(
                height: 250,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: snapshot.data!.length,
                  separatorBuilder: (context, index) {
                    return SizedBox(
                      width: 25.0,
                    );
                  },
                  itemBuilder: (context, index) {
                    var movie = snapshot.data![index];
                    return Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => DetailScreen(
                                          id: movie.id!,
                                          posterPath: movie.posterPath!,
                                        )));
                          },
                          child: Container(
                            width: 300,
                            height: 200,
                            clipBehavior: Clip.hardEdge,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                25.0,
                              ),
                            ),
                            child: Image.network(
                              "https://image.tmdb.org/t/p/w500/${movie.posterPath}",
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              );
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ],
    );
  }
}

class _Playings extends StatelessWidget {
  _Playings({super.key});

  Future<List<Movie>> playings = ApiService.getPlayingMovies();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Now in Cinemas",
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(
          height: 20.0,
        ),
        SizedBox(
          height: 250,
          child: FutureBuilder(
            future: playings,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      var movie = snapshot.data![index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => DetailScreen(
                                        id: movie.id!,
                                        posterPath: movie.posterPath!,
                                      )));
                        },
                        child: Column(
                          children: [
                            Container(
                              clipBehavior: Clip.hardEdge,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10)),
                              width: 150,
                              height: 150,
                              child: Image.network(
                                "https://image.tmdb.org/t/p/w500/${movie.posterPath}",
                                fit: BoxFit.cover,
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            SizedBox(
                              width: 150,
                              child: Text(
                                movie.title!,
                                style: TextStyle(
                                  fontSize: 13.0,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                    separatorBuilder: (context, index) => SizedBox(width: 30.0),
                    itemCount: snapshot.data!.length);
              }
              return Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
        )
      ],
    );
  }
}

class _Comings extends StatelessWidget {
  _Comings({super.key});

  Future<List<Movie>> comings = ApiService.getComingMovies();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Coming soon",
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(
          height: 20.0,
        ),
        SizedBox(
          height: 250,
          child: FutureBuilder(
            future: comings,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      var movie = snapshot.data![index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => DetailScreen(
                                        id: movie.id!,
                                        posterPath: movie.posterPath!,
                                      )));
                        },
                        child: Column(
                          children: [
                            Container(
                              clipBehavior: Clip.hardEdge,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10)),
                              width: 150,
                              height: 150,
                              child: Image.network(
                                "https://image.tmdb.org/t/p/w500/${movie.posterPath}",
                                fit: BoxFit.cover,
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            SizedBox(
                              width: 150,
                              child: Text(movie.title!,
                                  style: TextStyle(
                                    fontSize: 13.0,
                                    fontWeight: FontWeight.w700,
                                  )),
                            ),
                          ],
                        ),
                      );
                    },
                    separatorBuilder: (context, index) => SizedBox(width: 30.0),
                    itemCount: snapshot.data!.length);
              }
              return Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
        )
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:movieflix/models/movie_details.dart';
import 'package:movieflix/services/api_service.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({
    super.key,
    required this.id,
    required this.posterPath,
  });

  final int id;
  final String posterPath;

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  bool isLoading = true;
  late MovieDetail movieDetail;

  @override
  void initState() {
    getMovieDetail();
    super.initState();
  }

  void getMovieDetail() async {
    movieDetail = await ApiService.getMovieDetails(widget.id);
    setState(() {
      isLoading = false;
    });
  }

  // MovieDetail movieDetail = waitForMovieDetail();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Color(0x44000000),
        elevation: 0,
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 15.0,
          vertical: 15.0,
        ),
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: NetworkImage(
              "https://image.tmdb.org/t/p/w500/${widget.posterPath}",
            ),
            colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.5), BlendMode.darken),
          ),
        ),
        child: (isLoading)
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                      height: 300.0,
                    ),
                    Text(
                      movieDetail.title!,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 25.0,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    SizedBox(
                      height: 30.0,
                    ),
                    Text(
                      "Rating : ${movieDetail.voteAverage}",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14.0,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    Text(
                      "Runtime : ${movieDetail.runtime} min",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14.0,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          "Genres : ",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14.0,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        for (var genre in movieDetail.genres!.take(3))
                          Container(
                            padding: EdgeInsets.only(
                              right: 10.0,
                            ),
                            child: Text(
                              genre.name!,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14.0,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                          )
                      ],
                    ),
                    SizedBox(
                      height: 40.0,
                    ),
                    Text(
                      "Storyline",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 25.0,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      "${movieDetail.overview!} minutes",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 13.0,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}

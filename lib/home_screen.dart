import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/Services/services.dart';
import 'package:movie_app/models/models.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<Movie>> nowShowing;
  late Future<List<Movie>> upcoming;
  late Future<List<Movie>> popularMovies;
  @override
  void initState() {
    super.initState();
    nowShowing = APIservices().getNowShowing();
    upcoming = APIservices().getUpComing();
    popularMovies = APIservices().getPopular();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Movie App'),
        leading: const Icon(Icons.menu),
        centerTitle: true,
        actions: const [
          Icon(Icons.search_rounded),
          SizedBox(width: 10),
          Icon(Icons.notifications),
          SizedBox(width: 10),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                " Now Showing",
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 18,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 10),
              FutureBuilder(
                future: nowShowing,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text('Error: ${snapshot.error}'),
                    );
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(
                      child: Text('No movies found'),
                    );
                  }
                  final movies = snapshot.data!;
                  return CarouselSlider.builder(
                    itemCount: movies.length,
                    itemBuilder: (context, index, movieIndex) {
                      final movie = movies[index];
                      return Stack(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              image: DecorationImage(
                                  image: NetworkImage(
                                    "https://image.tmdb.org/t/p/original/${movie.backDropPath}",
                                  ),
                                  fit: BoxFit.cover),
                            ),
                          ),
                          Positioned(
                            bottom: 15,
                            left: 0,
                            right: 0,
                            child: Text(
                              movie.title,
                              textAlign: TextAlign.center,
                              maxLines: 1,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: Colors.white,
                              ),
                            ),
                          )
                        ],
                      );
                    },
                    options: CarouselOptions(
                      autoPlay: true,
                      enlargeCenterPage: true,
                      aspectRatio: 1.7,
                      autoPlayInterval: const Duration(seconds: 3),
                    ),
                  );
                },
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "Up Coming Movies",
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 18,
                  color: Colors.black,
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                height: 250,
                child: FutureBuilder(
                  future: upcoming,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (snapshot.hasError) {
                      return Center(
                        child: Text('Error: ${snapshot.error}'),
                      );
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return const Center(
                        child: Text('No movies found'),
                      );
                    }
                    final movies = snapshot.data!;
                    return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: movies.length,
                      itemBuilder: (context, index) {
                        final movie = movies[index];
                        return Stack(
                          children: [
                            Container(
                              width: 180,
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                image: DecorationImage(
                                    image: NetworkImage(
                                        "https://image.tmdb.org/t/p/original/${movie.backDropPath}"),
                                    fit: BoxFit.cover),
                              ),
                            ),
                            Positioned(
                              bottom: 15,
                              left: 0,
                              right: 0,
                              child: Text(
                                movie.title,
                                textAlign: TextAlign.center,
                                maxLines: 1,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: Colors.white,
                                ),
                              ),
                            )
                          ],
                        );
                      },
                    );
                  },
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "Popular Movies",
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 18,
                  color: Colors.black,
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                height: 250,
                child: FutureBuilder(
                  future: popularMovies,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (snapshot.hasError) {
                      return Center(
                        child: Text('Error: ${snapshot.error}'),
                      );
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return const Center(
                        child: Text('No movies found'),
                      );
                    }
                    final movies = snapshot.data!;
                    return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: movies.length,
                      itemBuilder: (context, index) {
                        final movie = movies[index];
                        return Stack(
                          children: [
                            Container(
                              width: 180,
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                image: DecorationImage(
                                    image: NetworkImage(
                                        "https://image.tmdb.org/t/p/original/${movie.backDropPath}"),
                                    fit: BoxFit.cover),
                              ),
                            ),
                            Positioned(
                              bottom: 15,
                              left: 0,
                              right: 0,
                              child: Text(
                                movie.title,
                                textAlign: TextAlign.center,
                                maxLines: 1,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: Colors.white,
                                ),
                              ),
                            )
                          ],
                        );
                      },
                    );
                  },
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}

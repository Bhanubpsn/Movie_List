import 'package:flutter/material.dart';

import '../model/Movies.dart';

class MovieListView extends StatelessWidget {
  const MovieListView({Key? key}) : super(key: key);

  static List<Movie> movieList = Movie.getMovies();
  static const List movies = [
      "Iron Man",
      "Iron Man 2",
      "Iron Man 3",
      "Thor",
      "Thor : The Dark World",
      "Thor Ragnarok",
      "Captain America : The First Avenger",
      "Captain America : Winter Soldier",
      "Captain America : Civil War",
      "Black Panther",
      "Avengers",
      "Doctor Strange",
      "Doctor Strange : Multiverse of Madness",
      "Spiderman : Homecoming",
      "Spiderman : Far From Home",
      "Spiderman : No Way Home",
      "Avengers Age of Ultron",
      "Avengers Infinity War",
      "Avengers Endgame",
      "Avatar",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const Text("Movies"),
        backgroundColor: Colors.blueGrey.shade900,
      ),
      backgroundColor: Colors.blueGrey.shade400,
      body: ListView.builder(
            itemCount: movieList.length,
            itemBuilder: (BuildContext context,int index){
              return Stack(
                  children:[
                    movieCard(movieList[index], context),
                    Positioned(
                        top: 10.0,
                        child: movieImage(movieList[index].poster)
                    ),


                  ]
              );
                // return Card(
                //   color: Colors.white,
                //   elevation: 5.0,
                //   child: ListTile(
                //          leading: CircleAvatar(
                //            child: Container(
                //              width: 200.0,
                //              height: 200.0,
                //              decoration: BoxDecoration(
                //                image: DecorationImage(
                //                  image: NetworkImage(movieList[index].poster),
                //                  fit: BoxFit.cover,
                //                ),
                //                color: Colors.blue,
                //                borderRadius: BorderRadius.circular(13.9),
                //              ),
                //
                //            ),
                //          ),
                //          trailing:const Text("...",),
                //          title: Text(movieList[index].title),
                //          subtitle: Text(movieList[index].title),
                //          onTap: (){
                //            Navigator.push(context, MaterialPageRoute(builder: (context) =>MovieListViewDetails(movieName: movieList.elementAt(index).title,movie: movieList[index])));
                //          },
                //          // onTap: () => debugPrint("Movie Name : ${movies[index]}"),
                //
                //   ),
                // );
          }
      ),
    );
  }

  Widget movieCard(Movie movie, BuildContext context){
    return InkWell(
      child: Container(
        margin:const EdgeInsets.only(left: 60.0),
        width: MediaQuery.of(context).size.width,
        height: 120.0,
        child: Card(
          color: Colors.black45,
          child: Padding(
            padding: const EdgeInsets.only(top: 8.0,bottom: 8.0,left: 54.0),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Text(
                            movie.title,
                            style:const TextStyle(
                              fontSize: 17.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                        ),
                      ),
                      Text(
                          "Rating: ${movie.imdbRating}/10",
                          style:const TextStyle(
                            fontSize: 15.0,
                            color: Colors.grey,
                          ),
                      ),
                    ],
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                          "Released: ${movie.released}",
                          style:const TextStyle(
                              fontSize: 15.0,
                              color: Colors.grey,
                          ),
                      ),
                      Text(
                          movie.rated,
                          style:const TextStyle(
                              fontSize: 15.0,
                              color: Colors.grey,
                        ),
                      ),
                    ],
                  ),

                ],
              ),
            ),
          ),
        ),
      ),
      onTap: () => {
            Navigator.push(context, MaterialPageRoute(builder: (context) =>MovieListViewDetails(movieName: movie.title,movie: movie))),
      },
    );
  }

  Widget movieImage(String imageUrl){
    return Container(
      width: 100.0,
      height: 100.0,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        image: DecorationImage(
          image: NetworkImage(imageUrl ?? 'https://images-na.ssl-images-amazon.com/images/M/MV5BMTYxMDg1Nzk1MV5BMl5BanBnXkFtZTcwMDk0MTUzNA@@._V1_SX1500_CR0,0,1500,999_AL_.jpg',),
          fit: BoxFit.cover,
        )
      ),
    );
  }


}



// New Route (Screen or Page)
class MovieListViewDetails extends StatelessWidget {
  final String movieName;
  final Movie movie;
  const MovieListViewDetails({Key ? key,required this.movieName, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Text("Movies $movieName"),
        backgroundColor: Colors.blueGrey.shade900,
      ),
      body: ListView(
        children: [
            MovieDetailsThumbnail(thumbnail: movie.images[1]),
            MovieDetailsHeaderWithPoster(movie: movie,),
            const HorizontalLine(),
            const SizedBox(height: 50,),
            MovieDetailsCast(movie: movie),
            const HorizontalLine(),
            MovieExtraPoster(posters: movie.images),
        ],
      ),
      // body: Center(
      //   child: Container(
      //     child: ElevatedButton(
      //       onPressed: () {
      //         Navigator.pop(context);
      //       },
      //       child: Text("Go Back ${movie.director}",),
      //
      //     )
      //   ),
      // ),
    );
  }
}

class MovieDetailsThumbnail extends StatelessWidget {
  const MovieDetailsThumbnail({Key? key, required this.thumbnail}) : super(key: key);

  final String thumbnail;


  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: 190,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(thumbnail),
                  fit: BoxFit.cover,
                )
              ),
            ),
            const Icon(Icons.play_circle_outlined,size: 100,color: Colors.white,)
          ],

        ),
        Container(
          decoration:const BoxDecoration(
            gradient: LinearGradient(
                colors: [Color(0x00f5f5f5),Color(0xfff5f5f5)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
            ),
          ),
          height: 80.0,
        ),
      ],
    );
  }
}

class MovieDetailsHeaderWithPoster extends StatelessWidget {
  const MovieDetailsHeaderWithPoster({Key? key, required this.movie}) : super(key: key);

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          children: [
            MoviePoster(poster : movie.poster.toString()),
            const SizedBox(width: 16,),
            Expanded(
                child: MovieDetailsHeader(movie: movie),
            ),
          ],
        ),
    );
  }
}


class MoviePoster extends StatelessWidget {
  const MoviePoster({Key? key, required this.poster}) : super(key: key);

  final String poster;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ClipRRect(
        borderRadius:const BorderRadius.all(Radius.circular(10)),
        child: Container(
          width: MediaQuery.of(context).size.width/4,
          height: 160,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(poster),
              fit: BoxFit.cover,
            )
          ),
        ),
      ),
    );
  }
}

class MovieDetailsHeader extends StatelessWidget {
  const MovieDetailsHeader({Key? key, required this.movie}) : super(key: key);

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
            "${movie.year} . ${movie.genre}".toUpperCase(),
            style:const TextStyle(
              fontWeight: FontWeight.w400,
              color: Colors.cyan,
            ),
        ),
        Text(
          movie.title,
          style:const TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 32,
          ),
        ),
        Text.rich(
            TextSpan(
                style:const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w300,
                ),
                children: [
                  TextSpan(
                    text: movie.plot,
                  ),
                  const TextSpan(
                    text: "More...",
                    style: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.w400,
                      color: Colors.indigo,
                    ),
                  ),
                ]
            )
        ),
      ],
    );
  }
}


class MovieDetailsCast extends StatelessWidget {
  const MovieDetailsCast({Key? key, required this.movie}) : super(key: key);

  final Movie movie;


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          MovieField(field: "Cast", value: movie.actors),
          MovieField(field: "Directors",value: movie.director),
          MovieField(field: "Awards", value: movie.awards),
        ],

      ),
    );
  }
}

class MovieField extends StatelessWidget {
  const MovieField({Key? key, required this.field, required this.value}) : super(key: key);

  final String field;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
         Text(
           "$field : ",
           style:const TextStyle(
             color: Colors.black38,
             fontSize: 12,
             fontWeight: FontWeight.w300,
           ),
         ),
        Expanded(
          child: Text(
            value,
            style:const TextStyle(
              color: Colors.black,
              fontSize: 12,
              fontWeight: FontWeight.w300,
            ),
          ),
        ),
      ],
    );
  }
}

class HorizontalLine extends StatelessWidget {
  const HorizontalLine({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 12),
      child: Container(
        height: 0.5,
        color: Colors.grey,
      ),
    );
  }
}


class MovieExtraPoster extends StatelessWidget {
  const MovieExtraPoster({Key? key, required this.posters}) : super(key: key);

  final List<String> posters;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left : 15.0),
          child: Text(
            "More Movie Posters.".toUpperCase(),
            style:const TextStyle(
              fontSize: 14,
              color: Colors.black26,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: Container(
            height: 170,
            child: ListView.separated(
                scrollDirection: Axis.horizontal,
                separatorBuilder: (context, index) =>const SizedBox(width: 8,),
                itemCount: posters.length,
                itemBuilder: (context, index) => ClipRRect(
                  borderRadius:const BorderRadius.all(Radius.circular(10.0),),
                  child: Container(
                    width: MediaQuery.of(context).size.width / 4,
                    height: 160,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(posters[index]),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
            ),
          ),
        ),
      ],
    );
  }
}













import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'models/movies.dart';
import 'dart:math';

void main() {
  runApp(MovieApp());
}

class MovieApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movie App',
      debugShowCheckedModeBanner: false,
    //  theme: ThemeData(
        //primarySwatch: Colors.blue,
        //visualDensity: VisualDensity.adaptivePlatformDensity,
     // ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late List<Movie> _movies;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchMovies();
  }

  Future<void> _fetchMovies() async {
    final url = Uri.parse('https://www.omdbapi.com/?apikey=c4033450&s=hollywood');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final results = json.decode(response.body)['Search'] as List<dynamic>;
      setState(() {
        _movies = results.map((result) => Movie.fromJson(result)).toList();
        _isLoading = false;
      });
    } else {
      throw Exception('Failed to fetch movies');
    }
  }
Shader _getRandomColor() {
  final Random random = Random();
  final int r = random.nextInt(256);
  final int g = random.nextInt(256);
  final int b = random.nextInt(256);
  final int a = random.nextInt(128) + 128; // Opacity range: 0.5 to 1.0
  final Color color1 = Color.fromRGBO(r, g, b, 1.0);
  final Color color2 = Color.fromRGBO(r, g, b, 0.5);
  return LinearGradient(
    colors: [color1, color2],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  ).createShader(Rect.fromLTRB(0, 0, 100, 100));
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
    icon: Icon(Icons.arrow_back_ios,
    color: Colors.black,
    ),
    onPressed: () {
      // handle menu button press
    },
  ),
   titleSpacing: 16,
  actions: [
    IconButton(
      icon: Icon(Icons.more_vert,
      color: Colors.black,
      ),
      onPressed: () {
        // handle search button press
      },
    ),
    
  ],
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          :   ListView.builder(
              itemCount: _movies.length,
              itemBuilder: (context, index) => 
              Padding(
  padding: EdgeInsets.all(10),
  child: SizedBox(
    width: 130,
    height: 120,
        child: Card(
            color: Color((Random().nextDouble() * 0xFFFFFF).toInt() << 0).withOpacity(1.0),

          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20)
          ),
          child: InkWell(
        onTap: () => {Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MovieDetailsPage(imdbID: _movies[index].imdbID),
      ))},
      child : Center(
           child: ListTile(
            contentPadding: EdgeInsets.symmetric(horizontal: 16.0,vertical: 10),
            leading: SizedBox(
              width: 48,
             height: 4800,
             child: Image.network( _movies[index].poster,
              height: 180,
              width: 60,
              fit: BoxFit.cover,
            ),
            ),
            title:    Text(_movies[index].title,
            textAlign: TextAlign.left,
            style:TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontSize: 15
            ),
            ),
           subtitle: Text("Movie",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white
            ),
            ),
            trailing: const Icon(Icons.star,
            color: Colors.yellow,
            ),
            ),

          ),
          
        ),
      ),
      
    ),
  
  ),
));
}
} 

class MovieDetailsPage extends StatefulWidget {
  final String imdbID;

  const MovieDetailsPage({required this.imdbID});

  @override
  _MovieDetailsPageState createState() => _MovieDetailsPageState();
}

class _MovieDetailsPageState extends State<MovieDetailsPage> {
  MovieDetails? _movieDetails;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchMovieDetails();
  }

  Future<void> _fetchMovieDetails() async {
    final url = Uri.parse('https://www.omdbapi.com/?i=tt7131622&plot=full&apikey=c4033450');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final result = json.decode(response.body);
      setState(() {
        _movieDetails = MovieDetails.fromJson(result);
        _isLoading = false;
      });
    } else {
      throw Exception('Failed to fetch movie details');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    appBar: AppBar(
      elevation: 0,
  backgroundColor: Colors.pinkAccent,
  leading: IconButton(
    icon: Icon(Icons.arrow_back_ios),
    onPressed: () {
      // handle menu button press
    },
  ),
  titleSpacing: 16,
  actions: [
    IconButton(
      icon: Icon(Icons.star,
      color: Colors.yellow,
      ),
      onPressed: () {
        // handle search button press
      },
    ),
    
  ],
),
       body:_isLoading
          ? Center(
            child: CircularProgressIndicator())
: Scaffold(
    resizeToAvoidBottomInset: false,
    backgroundColor: Colors.pinkAccent.withOpacity(0.8),
    body
    :Container(
       decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Colors.pink[400]!,
          Colors.pink[800]!,
        ],
      ),
    ),
      child: Column(
      children: [
        Padding(
          padding: EdgeInsets.only(top: 30,left: 5,right: 10),
          child: Container(
            
            padding: EdgeInsets.only(left: 5,top: 10,right: 10),
            height: 80,
            child: ListTile(
              leading: CircleAvatar(
              radius: 40,
                backgroundImage: NetworkImage(_movieDetails!.poster),
              ),
              title: Text(
                _movieDetails!.title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
              subtitle: Text(
                
                _movieDetails!.director,
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: 20,),
        Stack(
          children: [
  Container(
    alignment: Alignment.center,
    height: 200,
    width: MediaQuery.of(context).size.width,
    margin: EdgeInsets.only(left: 25, right: 25),
    padding: EdgeInsets.all(10),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(15),
      image: DecorationImage(
        image: NetworkImage(_movieDetails!.poster),
        fit: BoxFit.cover,
      ),
    ),
  ),
   Container(
  width: MediaQuery.of(context).size.width,
  margin: EdgeInsets.only(left: 25, right: 25),
  padding: EdgeInsets.all(10),
  alignment: Alignment.center,
  height: 200,
  decoration: BoxDecoration(
    color: Colors.black.withOpacity(0.6),
    borderRadius: BorderRadius.circular(15),
  ),
),
  Positioned.fill(
  child: Container(
    alignment: Alignment.center,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          alignment: Alignment.center,
          icon: Icon(
            Icons.play_arrow,
            color: Colors.white.withOpacity(0.8),
            size: 45,
          ),
          onPressed: () {
            // Do something when play button is pressed
          },
        ),
        SizedBox(height: 6,),
        Text(
          "Watch Trailer",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontSize: 10,
          ),
        ),
      ],
    ),
  ),
),
],
        ),
SizedBox(height: 10,),
        Container(
          margin: EdgeInsets.only(left: 25,right: 25,top: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Overview",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
              Row(
                children: [
                  Text(
                    _movieDetails!.imdbRating,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(width: 5),
                  Icon(
                    Icons.star,
                    color: Colors.yellow,
                  ),
                ],
              ),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.only(left:25,right: 25,top: 10),
          child: Text(
            "Actor Rick Dalton gained fame and fortune by starring in a 1950s television Western, but is now struggling to fine drinking and palling around with Cliff Booth, his easygoing best friend and longtime stunt double. Rick also happens to live next door to Roman Polanski and Sharon Tate -- the filmmaker and budding actress whose futures will forever be altered by members of the Manson Family.",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontSize: 11
            ),
          ),
        ),
        SizedBox(height: 10),
        Container(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),

          color: Colors.pinkAccent.withOpacity(0.3), 
  child: Column(
  crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        "Actors",
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.white,
          fontSize: 20,
        ),
      ),
        SizedBox( height: 10),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child:Row(
        children: [
          CircleAvatar(
            backgroundImage: AssetImage(
              "images/img3.jpeg",
            ),
            radius: 30,
          ),
          SizedBox(width: 10),
          CircleAvatar(
            backgroundImage: AssetImage(
              "images/img2.jpeg",
            ),
            radius: 30,
          ),
          SizedBox(width: 10),
          CircleAvatar(
            backgroundImage:  AssetImage(
              'images/img1.jpeg'
            ),
            radius: 30,
          ),
          SizedBox(width: 10),
          CircleAvatar(
            backgroundImage: AssetImage(
              'images/img.jpeg'
            ),
            radius: 30,
          ),
          SizedBox(width: 10),
          CircleAvatar(
            backgroundImage: AssetImage(
              'images/img.jpeg'
            ),
            radius: 30,
          ),
        ],
      )),
    ],
  ),
),
SizedBox(height: 15,),
Row(
  mainAxisAlignment: MainAxisAlignment.spaceAround,
  children: [
    Column(
      children: [
        Text("IMdB",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold
          ),
        ),
        SizedBox(height: 10,),
        RichText(
  text: TextSpan(
    children: [
      TextSpan(
        text: _movieDetails!.imdbRating,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 30, // adjust the font size as needed
          color: Colors.white,
        ),
      ),
      TextSpan(
        text: '/10',
        style: TextStyle(
          fontSize: 16, // adjust the font size as needed
          color: Colors.white,
        ),
        
      ),
      
    ],
  ),
),

        
      ],
    ),
    SizedBox(width: 10), // Adds 10 pixels of space between the texts
    Column(
      children: [
        Text("Metascore",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold
          ),
        ),
        SizedBox(height: 10,),
        RichText(
  text: TextSpan(
    children: [
      TextSpan(
        text: _movieDetails!.metascore,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 30, // adjust the font size as needed
          color: Colors.white,
        ),
      ),
      TextSpan(
        text: '/100',
        style: TextStyle(
          fontSize: 16, // adjust the font size as needed
          color: Colors.white,
        ),
        
      ),
      
    ],
  ),
),

        
      ],
    ),
  ],
)

    

    ]),)
  )
  );
  }}
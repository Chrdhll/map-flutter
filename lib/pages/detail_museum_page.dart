import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class DetailMuseumPage extends StatelessWidget {
  final Map<String, dynamic> museum;
  const DetailMuseumPage({super.key, required this.museum});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(museum['namaTempat'])),
      body: Padding(
        padding: EdgeInsets.all(15),
        child: SingleChildScrollView(
          child: Column(
            children: [
              ClipRRect(
                child: Image.asset(
                  museum['gambar'],
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: 300,
                ),
              ),
              SizedBox(height: 15),
              Text(
                museum['namaTempat'],
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 15),
              Text(
                museum['harga_tiket'],
                style: TextStyle(color: Colors.red, fontSize: 20),
              ),
              SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(museum['rating'].toString(), style: TextStyle(fontSize: 15)),
                  SizedBox(width: 5),
                  RatingBarIndicator(
                    rating: museum['rating'],
                    itemBuilder:
                        (context, index) =>
                            Icon(Icons.star, color: Colors.amber),
                    itemCount: 5,
                    itemSize: 20,
                    direction: Axis.horizontal,
                  ),
                  SizedBox(width: 5),
                ],
              ),
              SizedBox(height: 20),
              Text(museum['deskripsi'], style: TextStyle(fontSize: 16)),
            ],
          ),
        ),
      ),
    );
  }
}

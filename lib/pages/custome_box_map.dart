import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class CustomeBoxMap extends StatelessWidget {
  final String gambar;
  final String harga;
  final String namaTempat;
  final double rating;
  final VoidCallback onPressed;
  const CustomeBoxMap({
    super.key,
    required this.gambar,
    required this.namaTempat,
    required this.rating,
    required this.harga,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [BoxShadow(color: Colors.black, blurRadius: 8)],
      ),
      child: Column(
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
              child: Image.asset(
                gambar,
                width: 280,
                height: 80,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8),
            child: Text(
              namaTempat,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text('$rating', style: TextStyle(fontSize: 10)),
              SizedBox(width: 5),
              RatingBarIndicator(
                rating: rating,
                itemBuilder:
                    (context, index) => Icon(Icons.star, color: Colors.amber),
                itemCount: 5,
                itemSize: 15,
                direction: Axis.horizontal,
              ),
              SizedBox(width: 5),
            ],
          ),
          Text(harga, style: TextStyle(color: Colors.red, fontSize: 13)),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
            onPressed: () {
              onPressed.call();
            },
            child: Text('VIEW', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}

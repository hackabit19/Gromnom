class Restaurant {
  List<Restaurants> restaurants;

  Restaurant({this.restaurants});

  Restaurant.fromJson(Map<String, dynamic> json) {
    if (json['restaurants'] != null) {
      restaurants = new List<Restaurants>();
      json['restaurants'].forEach((v) {
        restaurants.add(new Restaurants.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.restaurants != null) {
      data['restaurants'] = this.restaurants.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Restaurants {
  String restaurant;
  String code;
  String rating;

  Restaurants({this.restaurant, this.code, this.rating});

  Restaurants.fromJson(Map<String, dynamic> json) {
    restaurant = json['restaurant'];
    code = json['code'];
    rating = json['rating'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['restaurant'] = this.restaurant;
    data['code'] = this.code;
    data['rating'] = this.rating;
    return data;
  }
}

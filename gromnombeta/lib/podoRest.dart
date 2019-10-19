class Restaurants {
  List<RestaurantInfo> restaurants;

  Restaurants({this.restaurants});

  Restaurants.fromJson(Map<String, dynamic> json) {
    if (json['restaurants'] != null) {
      restaurants = new List<RestaurantInfo>();
      json['restaurants'].forEach((v) {
        restaurants.add(new RestaurantInfo.fromJson(v));
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

class RestaurantInfo {
  String restaurant;
  String code;
  String rating;

  RestaurantInfo({this.restaurant, this.code, this.rating});

  RestaurantInfo.fromJson(Map<String, dynamic> json) {
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

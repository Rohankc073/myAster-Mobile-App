class ApiEndpoints {
  ApiEndpoints._();

  static const Duration connectionTimeout = Duration(seconds: 5000);
  static const Duration receiveTimeout = Duration(seconds: 5000);

  //IP for iPhone
  static const String baseUrl = 'http://localhost:5003/';

  //Auth Endpoints

  static const String login = 'auth/login';
  static const String register = 'auth/register';
  static const String imageUrl = "http://localhost:5003/uploads/";
  static const String uploadImage = "auth/uploadImage";
  static const String addDoctor = 'doctors/save';
  static const String getAllDoctor = 'doctors/getAll';
  static const String getAllProduct = 'products/all';
  static const String getUserById = 'users/:id';
  static const String addProductToCart = 'cart/add';
  static const String cart = 'cart/:id';

  static const String getProductById = 'prducts/:id';
}

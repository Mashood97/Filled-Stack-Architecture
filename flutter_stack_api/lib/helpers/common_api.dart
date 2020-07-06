class CommonAPI {
  static const String _baseUrl = 'http://192.168.1.105:3000/';
  static const String signupUrl = _baseUrl + 'adminAuth/signUp';
  static const String signInUrl = _baseUrl + 'adminAuth/signIn';
  static const String addProductUrl = _baseUrl + 'product';
  static const String getProductUrl = _baseUrl + 'product';
  static const String getProductByIdUrl = _baseUrl + 'product';
  static const String updateProductUrl = _baseUrl + 'product';
  static const String deleteProductUrl = _baseUrl + 'product';
  static const String getAllusers = _baseUrl + 'user';
  static const String deleteUser = _baseUrl + 'user';

}

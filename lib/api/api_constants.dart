class ApiConstants {
  static const baseUrl = 'https://demo.iroidsolutions.com:7005/api/v1/';

//auth

  static const login = 'auth/login';
  static const register = 'auth/register';
  static const logout = 'auth/logout';

  //user
  static const getUsers = 'users';

  //forgot Password
  static const forgotPassword = 'auth/forgot-password';

  //category
  static const getCategory = 'category';

  //brands
  static const getBrands = 'brand';
  static const getProductFromBrand = 'product/product-listing';
  static const product = 'product';
  static const searchProduct = 'product/search-list';
  //review
  static const getReview = 'product/reviews';

  //check version
  static const checkVersion = 'check-version';

  //Reward Verification

  static const bankVerification = 'stripe/bankVerification';
  static const stripeVerification = 'stripe/verification';

  //state list
  static const stateList = 'stripe/state-listing';

  //contact support
  static const contactSupport = 'contact-support';

  //stripe payment
  static const getCheckOutProduct = 'stripe/checkout-product';
  static const createCard = 'stripe/card';
  static const getUserCard = 'stripe/card-listing';
  static const stripePaymentInvoice = 'stripe/payment-invoice';

  //delete Account
  static const deleteAccount = 'users/delete-account';

  //purchase product

  static const productPurchaseList = 'product/purchase-listing';
  static const productPurchaseDetail = 'product/purchase-product-details';
  static const keepProduct = 'keep-return/product-keep';
  static const returnProduct = 'keep-return/product-return';
}

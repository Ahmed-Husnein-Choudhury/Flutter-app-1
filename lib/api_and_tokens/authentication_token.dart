class AuthenticationToken{
  static String _tokenType;
  static String _accessToken;

  static void setToken(String tokenType,String accessToken){
    _tokenType=tokenType;
    _accessToken=accessToken;
  }

  static String getToken(){
    return _tokenType+" "+_accessToken;
  }

}
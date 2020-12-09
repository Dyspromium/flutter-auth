library odyssey.app;


const API_LINK = "https://surfrider-api.neutrapp.com/api/";

class ClassApi {
  String login = API_LINK + "auth/login";
  String register = API_LINK + "auth/register";
}

ClassApi api = new ClassApi();
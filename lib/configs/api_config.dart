library odyssey.app;


const AUTH_LINK = "https://surfrider-api.neutrapp.com/api/";
const EVENT_LINK = "";

class ClassApi {
  String login = AUTH_LINK + "auth/login";
  String register = AUTH_LINK + "auth/register";
}

ClassApi api = new ClassApi();
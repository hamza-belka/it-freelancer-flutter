import 'package:itfreelance/GeneralAdresse.dart';

enum NavLinks { Home, Github, Videos, Jobs}

String displayString(NavLinks link){


  switch(link){

    case NavLinks.Home:
      return "Home";
      break;
    case NavLinks.Github:
      return "Github";
      break;
    case NavLinks.Videos:
      return "Videos";
      break;
    default:
      return "";

  }

}
String linkUrl(NavLinks link){
  switch(link){

    case NavLinks.Home:
      return GeneralAdresse().Gadress+"/employerfreelancer/listfreelancer.php";
      break;
    case NavLinks.Github:
      return GeneralAdresse().Gadress+"/employerfreelancer/listfreelancer.php1";
      break;
    case NavLinks.Videos:
      return GeneralAdresse().Gadress+"/employerfreelancer/listfreelancer.php2";
      break;
    case NavLinks.Jobs:
      return GeneralAdresse().Gadress+"/employerfreelancer/listfreelancer.php3";
      break;
    default:
      return "";

  }


}
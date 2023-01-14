class User{
  String username;
  String password;
  int role;

  String email;
  User(this.username, this.password, {this.role=0,this.email=""});
}

class UserSettings{
  String bio;
  String uniName;
  String bolumName;
  String resimURL;
  bool bioShow;
  bool uniShow;
  bool girisSesi;
  bool profilTepkisi;
  bool motivasyonBildirimi;
  bool oturumAcik;
  UserSettings({this.resimURL="", this.bio= "",this.uniName="",this.bolumName="",this.bioShow=true, this.uniShow=true,this.girisSesi=true,this.profilTepkisi=true,this.motivasyonBildirimi=true,this.oturumAcik=true});
}
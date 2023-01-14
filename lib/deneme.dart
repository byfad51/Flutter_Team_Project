class Deneme {
  final String name;
  final int turkD;
  final int sosD;
  final int matD;
  final int fenD;
  final int turkY;
  final int sosY;
  final int matY;
  final int fenY;
  final String id;
  const Deneme({required this.name,this.turkD = 0, this.sosD = 0, this.matD = 0, this.fenD = 0,this.turkY = 0, this.sosY = 0, this.matY = 0, this.fenY = 0, required this.id});

  int getTotalTrue() {
    return turkD + matD + sosD + fenD;
  }
  int getTotalWrong() {
    return turkY + matY + sosY + fenY;
  }
  double getTotalNet() {
    return getTotalTrue().toDouble() - (getTotalWrong().toDouble()/4);
  }
 /* double getMatNet(){

  }*/

}
//====================
//==== Date Class ====
//====================

class Date {
  int day;
  int month;
  int year;
  
  Date(String dateStr) {
    String[] arrOfStr = dateStr.split("[/ ]");
    month = Integer.valueOf(arrOfStr[0]);
    day = Integer.valueOf(arrOfStr[1]);
    year = Integer.valueOf(arrOfStr[2]);
  }
  
  String getDateString() {
     return (day + "/" + month + "/" + year);
  }
  
}

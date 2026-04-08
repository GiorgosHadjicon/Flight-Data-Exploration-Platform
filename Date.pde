//====================
//==== Date Class ====
//====================
// AUTHORSHIP: Giorgos Zambas

// Created a Date class to be used as a flight atribute
class Date {
  int day;
  int month;
  int year;
  
  // Separates passed in date sgtring into 3 atributes
  Date(String dateStr) {
    String[] arrOfStr = dateStr.split("[/ ]");
    month = Integer.valueOf(arrOfStr[0]);
    day = Integer.valueOf(arrOfStr[1]);
    year = Integer.valueOf(arrOfStr[2]);
  }
  
  // Returns date atributes in a single string
  String getDateString() {
     return (day + "/" + month + "/" + year);
  }
  
}

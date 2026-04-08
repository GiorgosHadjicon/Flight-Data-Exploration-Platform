// AUTHORSHIP: Zuhairia Sahjabin

class Airport {
  String code;
  float lat;
  float lon;

  Airport(String code, float lat, float lon) {
    this.code = code;
    this.lat = lat;
    this.lon = lon;
  }
}

void loadAirports(String filename) {
  Table table = loadTable(filename, "header");

  for (TableRow row : table.rows()) {
  String code = row.getString(table.getColumnTitle(0));
  float lat = row.getFloat(table.getColumnTitle(1));
  float lon = row.getFloat(table.getColumnTitle(2));

    airportMap.put(code, new Airport(code, lat, lon));
  }
}

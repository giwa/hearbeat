// Config file for heart beat
//
//
class HBConfig{
  private String configFile;
  private JSONObject configJson;

  HBConfig(String configFile){
    this.configFile = configFile;
  }

  public void read(){
    this.configJson = loadJSONObject(this.configFile);
  }

  public String getTitle(){
    return this.configJson.getString("title");
  }

  public int getBPM(){
    return this.configJson.getInt("bpm");
  }

  public float getZoom(){
    return this.configJson.getFloat("zoom");
  }

  public int getSensor(){
    return this.configJson.getInt("sensor");
  }
}
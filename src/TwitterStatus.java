public class TwitterStatus {
  String userName, content;
  long tweetId;
  double latitude, longitude;
  
  public TwitterStatus(String userName, long tweetId, double latitude, double longitude,
                       String content) {
    this.userName = userName;
    this.tweetId = tweetId;
    this.longitude = longitude;
    this.latitude = latitude;
    this.content = content;
  }

  public long getTweetId() {
    return tweetId;
  }

  public String getUserName() {
    return userName;
  }
  
  public double getLatitude() {
	    return latitude;
	  }
  
  public double getLongitude() {
	    return longitude;
	  }

  public String getContent() {
    return content;
  }
}

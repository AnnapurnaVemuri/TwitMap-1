import twitter4j.*;
import twitter4j.conf.ConfigurationBuilder;
import java.util.ArrayList;
import java.util.List;

public final class TweetGet {
  private List<TwitterStatus> twitterStatusList = new
      ArrayList<TwitterStatus>();
  private TwitterStream twitterStream;
  public static final DataBaseHelper helper = new DataBaseHelper();

  public TweetGet() {
    //getTweets();
  }

  private void getTweets() {
    ConfigurationBuilder cb = new ConfigurationBuilder();
    cb.setDebugEnabled(true)
    	.setOAuthConsumerKey("KZI4MpW52dWinfzjXlKfTrzKN")
        .setOAuthConsumerSecret("ZzGjkXws3Bp2wzCd7mFqzlE6GK0HXhwi4Xfm8o7Px8auVDFJgD")
        .setOAuthAccessToken("2848198209-fwp23E0HONFs0iQpGJt8ABPk8HM5J3XX8NrhaHS")
        .setOAuthAccessTokenSecret("97BANAvxYHf4j7tFSW9t24i91d2zrVrXVnYrqd6XUxoB9");
    
    twitterStream = new TwitterStreamFactory(cb.build()).getInstance();
    StatusListener listener = new StatusListener() {
      @Override
      public void onStatus(Status status) {
        String username = status.getUser().getScreenName();
        long tweetId = status.getId();
        String content = status.getText();
        if(status.getGeoLocation()==null)
        	return;
        double latitude = status.getGeoLocation().getLatitude();
        double longitude = status.getGeoLocation().getLongitude();
        TwitterStatus newStatus = new TwitterStatus(username, tweetId,
            latitude, longitude, content);
        twitterStatusList.add(newStatus);
        if (twitterStatusList.size() == 10) {
          updateDB();
          twitterStatusList.clear();
        }
      }

      @Override
      public void onDeletionNotice(StatusDeletionNotice statusDeletionNotice) {
        System.out.println("Got a status deletion notice id:" + statusDeletionNotice.getStatusId());
      }

      @Override
      public void onTrackLimitationNotice(int numberOfLimitedStatuses) {
        System.out.println("Got track limitation notice:" + numberOfLimitedStatuses);
      }

      @Override
      public void onScrubGeo(long userId, long upToStatusId) {
        System.out.println("Got scrub_geo event userId:" + userId + " upToStatusId:" + upToStatusId);
      }

      @Override
      public void onStallWarning(StallWarning warning) {
        System.out.println("Got stall warning:" + warning);
      }

      @Override
      public void onException(Exception ex) {
        ex.printStackTrace();
      }
    };
    twitterStream.addListener(listener);
    twitterStream.sample();
  }

  private void updateDB() {
    while (!helper.batchInsert(twitterStatusList)) {
      System.out.println("Update failed, Retrying");
    }
    System.out.println("Update successful");
  }

  public List<LatLong> getLocationsFromDB(String keyword) {
    return helper.getLocations(keyword);
  }

  public void destroyTwitterSample() {
	if (twitterStream != null) {
	  twitterStream.shutdown();
	}
  }
}
Cloud Computing and Big Data, Assignment 1

Team Memebers:
Annapurna Vemuri(amv2164) and 
Sowmya Sree Bhagavatula(sb3636)

- The assignment was coded in Java, uses servlets, Javascript, google map API, Server Side Events, Twitter API for rendering the graphs. 
- The UI shows two maps: a heat map and a google map with markers for the locations of all tweets and also has a dropdown, through which the locations of tweets containing a particular keyword say 'TV' can be selected. By default, all tweets' locations are loaded to the UI
- Tweets from start till current time are uploaded to the map. Also, the maps are updated in Near Real time using Server Side Events
- The tweets fetched through Twitter API are stored in a MySQL database in Amazon RDS
- The UI is uploaded through Elastic BeanStalk at http://twitterassign-env.elasticbeanstalk.com
- Due to cost considerations for storing the data, we disabled twitter sample which is getting the tweets in real time and updating the database. The code which is commented is in constructor method of TweetGet class.

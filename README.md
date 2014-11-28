TwitMap
=======

This project is developed in requirement of course Cloud Computing and Big Data
Team Memebers:
Annapurna Vemuri(amv2164)
Sowmya Sree Bhagavatula(sb3636)
Madhuri S Palle(msp2167)
Sri Lakshmi Chintala(sc3772)

This project is a web application which get twitter data from Amazon SNS endpoint and shows the data as a marker map and heat map using Google Map API. The UI also shows a heat map based on the sentiment of the tweet. As the tweets are received from Amazon SNS, they are sent to the UI using Server Sent Events. Filtering of tweets based on a preset collection of keywords is also added to the UI.

The assignment was coded in Java, uses servlets, Javascript, Bootstrap API, google map API, Server Side Events, Twitter API for rendering the graphs.

The UI shows two maps: a heat map and a google map with markers for the locations of all tweets and also has a dropdown, through which the locations of tweets containing a particular keyword say 'lol' can be selected. By default, all tweets' locations are loaded to the UI

The UI is uploaded through Elastic BeanStalk at http://cloud-assgn2.elasticbeanstalk.com

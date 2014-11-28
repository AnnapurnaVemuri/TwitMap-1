import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.amazonaws.AmazonClientException;
import com.amazonaws.auth.AWSCredentials;
import com.amazonaws.auth.PropertiesCredentials;
import com.amazonaws.services.sns.AmazonSNSClient;
import com.amazonaws.services.sns.model.CreateTopicRequest;
import com.amazonaws.services.sns.model.CreateTopicResult;
import com.amazonaws.services.sns.model.SubscribeRequest;

import java.io.IOException;
import java.io.PrintWriter;

public class TwitMap extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private String message;
	//protected TweetGet getTweets;

	public void init() {
		// getTweets = new TweetGet();
		message = "Hello!";
		AWSCredentials credentials = null;
		try {
			credentials = new PropertiesCredentials(
					TwitMap.class
							.getResourceAsStream("AwsCredentials.properties"));
		} catch (Exception e) {
			throw new AmazonClientException(
					"Cannot load the credentials from the credential profiles file. "
							+ "Please make sure that your credentials file is at the correct location, and is in valid format.",
					e);
		}

		AmazonSNSClient service = new AmazonSNSClient(credentials);
		String local="172.31.20.134";//GetPublicHostname.tellMyIP();
		//String url="http://"+local+":8080/Twitter-Assi1/twitmapsse";
		
		
		String url="http://cloud-assgn2.elasticbeanstalk.com/twitmapsse";
		// Create a topic
		CreateTopicRequest createReq = new CreateTopicRequest()
				.withName("AllTopics4");
		CreateTopicResult createRes = service.createTopic(createReq);
		SubscribeRequest subscribeReq = new SubscribeRequest()
				.withTopicArn(createRes.getTopicArn())
				.withProtocol("http")
				.withEndpoint(url);
		service.subscribe(subscribeReq);

	}

	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		response.setContentType("application/json");
		PrintWriter out = response.getWriter();
		out.println(message);
	}
}

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

public class TwitMap  extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private String message;
	protected TweetGet getTweets;

	public void init() {
		getTweets = new TweetGet();
		message = "Hello!";
	}

	public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {	  
	    response.setContentType("application/json");
	    PrintWriter out = response.getWriter();
	    out.println(message);
	}

	public void destroy() {
		// do nothing.
	}
}

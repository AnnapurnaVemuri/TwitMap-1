import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import freemarker.core.LocalContext;

import java.io.IOException;
import java.io.PrintWriter;
import java.rmi.registry.LocateRegistry;
import java.util.List;

@WebServlet(urlPatterns={"/twitmapsse"})
public class TwitMapAsyncServlet extends TwitMap {

	private static final long serialVersionUID = 1L;

	@Override
  public void doGet(HttpServletRequest req, HttpServletResponse res) throws
      IOException, ServletException {
		
    res.setContentType("text/event-stream");
    res.setCharacterEncoding("UTF-8");

    String keyword = req.getParameter("msg");

    PrintWriter writer = res.getWriter();
    
    List<LatLong> locations = getTweets.getLocationsFromDB(keyword);
    String locationList="";
    for (LatLong location: locations) {
      locationList+=location.toString();
      locationList+=" ";

    }
    writer.write("data: "+locationList+" \n\n");
    //writer.write("data: data \n\n");
  }
}
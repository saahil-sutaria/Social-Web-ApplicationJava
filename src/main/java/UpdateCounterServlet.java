
import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.google.appengine.api.datastore.*;
import com.google.appengine.api.datastore.Query.Filter;
import com.google.appengine.api.datastore.Query.FilterOperator;
import com.google.appengine.api.users.*;
import javax.servlet.http.*;


@SuppressWarnings("serial")
public class UpdateCounterServlet extends HttpServlet {
	public void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
		resp.setContentType("text/html");
		DatastoreService datastore = DatastoreServiceFactory.getDatastoreService();
		String key = req.getParameter("tID");
		Key k = KeyFactory.stringToKey(key);
		Query q = new Query("Twitter");
		Filter fl = new Query.FilterPredicate(Entity.KEY_RESERVED_PROPERTY, FilterOperator.EQUAL, k);
		q.setFilter(fl);
		PreparedQuery prq = datastore.prepare(q);
		Entity tweets = prq.asSingleEntity();
		tweets.setProperty("visit_counter", ((Long) tweets.getProperty("visit_counter")).intValue() + 1);
		datastore.put(tweets);
		PrintWriter pw = resp.getWriter();
		pw.write("Tweet: " + tweets.getProperty("TweetMessage") + "\n");
		pw.write("</br>");
		pw.println("Visited Counter: " + tweets.getProperty("visit_counter") + "\n");
		pw.write("</br>");
		pw.println("User: " + tweets.getProperty("Username") + "\n");
	}
}

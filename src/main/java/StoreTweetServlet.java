
import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.google.appengine.api.datastore.*;
import com.google.appengine.api.users.*;
import java.io.IOException;
import javax.servlet.http.*;


@SuppressWarnings("serial")
public class StoreTweetServlet extends HttpServlet {
	public void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws IOException, ServletException {
		System.out.println("IN1");
		resp.setContentType("text/html");
		String uname = req.getParameter("uname");
		HttpSession session = req.getSession(true);
		session.setAttribute("name",uname);
		RequestDispatcher rd = req.getRequestDispatcher("tweets.jsp");
			rd.forward(req, resp);
		
	}
	@SuppressWarnings("serial")
	public void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws IOException {
		System.out.println("IN2");
		resp.setContentType("text/html");
		//getting the datastore
		DatastoreService datastore = DatastoreServiceFactory.getDatastoreService();
		//create entity Tweets and put the tweet message into the datastore
		String message=req.getParameter("message");
		String name=req.getParameter("Username");
		String uid=req.getParameter("UserId");
		String image = req.getParameter("image");
		Key tkey=KeyFactory.createKey("tweetid",name);
		Entity twitter=new Entity("Twitter",tkey);
		twitter.setProperty("TweetMessage",message);
		twitter.setProperty("Username",name);
		twitter.setProperty("userID",uid);
		twitter.setProperty("picture",image);
		twitter.setProperty("visit_counter",0);
		datastore.put(twitter);
		resp.sendRedirect("tweets.jsp");

	}
}

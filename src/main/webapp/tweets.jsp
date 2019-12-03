<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.google.appengine.api.users.User" %>
<%@ page import="com.google.appengine.api.users.UserService" %>
<%@ page import="com.google.appengine.api.users.UserServiceFactory" %>
<%@ page import="com.google.appengine.api.datastore.DatastoreServiceFactory" %>
<%@ page import="com.google.appengine.api.datastore.DatastoreService" %>
<%@ page import="com.google.appengine.api.datastore.Query" %>
<%@ page import="com.google.appengine.api.datastore.Entity" %>
<%@ page import="com.google.appengine.api.datastore.FetchOptions" %>
<%@ page import="com.google.appengine.api.datastore.Key" %>
<%@ page import="com.google.appengine.api.datastore.KeyFactory" %>
<%@ page import="com.google.appengine.api.datastore.Query.Filter"%>
<%@ page import="com.google.appengine.api.datastore.Query.FilterPredicate"%>
<%@ page import="com.google.appengine.api.datastore.Query.FilterOperator"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link rel="stylesheet" type="text/css" href="twitter.css"/>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Facebook-Tweet App</title>
<style>
label textarea{
 vertical-align: center;
}
</style>
</head>
<body>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.0/jquery.min.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	getUserDetails();
});
</script>
    <h1 id="fb-welcome"></h1>
   <nav justify-align="center">
   	<ul align="center">
   		<li><a href="tweets.jsp">Tweets</a></li>
   		<li><a href="friends.jsp">Friends</a></li>
   		<li><a href="toptweets.jsp">Top Tweets</a></li>
   	</ul>
   	</nav>
   	
   	<p align="center">
   	
   		
   		<div id="display_tweet" display="inline" align="center" style="width:60%;margin: 0 auto;">
   		
   			<form action="/store" method="post">
   			<div >
   				<div>
   				<p class="formfield">
   				<label for="message"></label>
   				<textarea placeholder="Enter Tweet..." id="message" name="message" rows="7" cols="70" id="message" onchange="getUserDetails()"></textarea>
   				<input type="hidden" id="Username" name="Username"/>
   				<input type="hidden" id="UserId" name="UserId"/>
   				<input type="hidden" id="image" name="image"/>
   				</p>
   				</div>
   				<input type="submit" value="Save Tweet" />
				<input type="button" id="post" value="Post On Timeline" onclick="create_message();"> <label for="post"></label>			
		   		<input type="button" id="send" value="Send Message to Friend" onclick="sendmessage();"> <label for="send"></label>
		   			
		   		
		   		
		   		</div>
   			</form>
   		 </div>	
   		 <script type="text/javascript">
   		
   		 </script>
   		 <br>
   		 
   		<%
   		   String name=(String)session.getAttribute("name");
   		   DatastoreService ds=DatastoreServiceFactory.getDatastoreService();
   		   Filter keyfilter = new FilterPredicate("Username",FilterOperator.EQUAL,name); 
   		   Query q= new Query("Twitter"); 
   		   List<Entity> tweets = ds.prepare(q).asList(FetchOptions.Builder.withLimit(30));
   		 
   		 %>
   		 <div style="height: 500px; overflow: auto;">
   		 <table align="center" id="tblid" border="1">
   		 <tbody>
   		 <tr>
   		 <th style="font-size:16px">
   		 Tweets
   		 </th>
   		 <th style="font-size:16px">
   		 Username
   		 </th>
         
   		 </tr align="center">
 		 <% 
   		   for(Entity twitter: tweets)
   			{ 
  				  String message=(String)twitter.getProperty("TweetMessage");
  				  String usrname=(String)twitter.getProperty("Username"); 
  				  String usrid=(String)twitter.getProperty("UserId");
  				  String image=(String)twitter.getProperty("picture");
  				  String date=(String)twitter.getProperty("Date");
  				  //Long id=tweet.getKey().getId();
  	   	  %>
            	<tr align="center"> 
  				<td>
  				<%=message %>
  				</td>
  				<td>
  				<%=usrname %>
  			   </td>
  			   <td hidden="true"> <%= KeyFactory.keyToString(twitter.getKey()) %> </td>
  			   
  			   </tr>
  			   
  			   
   		
        <%  }  %>
      
        </tbody>
        </table>
        </div>
   	<div id="the_Text">
   	</div>
   	<div id="the msg">
   	</div>
   	<div id="the name">
   	</div>
   	</p>
   	<!--<script type="text/javascript" src="fb.js"></script>-->
   	<script type="text/javascript">
   	 
   	function showform()
   	{
   		document.getElementById('display_tweet').style.display='inline';
   		getUserDetails();
   	}
   	function create_message()
   	{
   		var tweetmessage=document.getElementById('message').value;
   		post_tweet(tweetmessage);
   	}
   	function sendmessage()
   	{
   		var lnk = 'https://fproject1-260906.appspot.com//update?tID=ahBzfnR3aXR0ZXItMjA0ODA5cj8LEgd0d2VldGlkIh5OYW5jeSBBbGJmYmllZGJpaGlpIFNtaXRoc3RlaW4MCxIHVHdpdHRlchiAgICAgICACgw';
   		FB.ui({
			method : 'send',
			
			link: lnk
		});
   		
   	}
   	function deleteTweet()
   	{
   		var table = document.getElementById("tblid");
   		var rows = table.getElementsByTagName("tr");
   		for (i = 0; i < rows.length; i++) {
   	        var currentRow = table.rows[i];
   	        var createHandler=
   	        	function(row) 
   	            {
   	                return function() { 
   	                                        var cell = row.getElementsByTagName("td")[2];
   	                                        var id = cell.innerText;
   	                                        document.getElementById('delete').value=id;
   	                                        
   	                                       
   	                                 };
   	            };
   	        currentRow.onclick = createHandler(currentRow);
   	    }
   	}
   	
 function post_tweet(tweetmessage)
   	{
	 
   	 
	  FB.ui({
			
	 		method: 'share',
	 		href:'https://apps.facebook.com/twitter/tweets.jsp'
	 		});	 
   	
   	}
 function getUserDetails()
 {
	 FB.api('/me','get',{fields: 'first_name,last_name,name,id,picture'}, function(response) {
		 	document.getElementById('Username').value=response.first_name;
			document.getElementById('UserId').value=response.id;
			document.getElementById('image').src=response.picture.data.url;
   
         
   });

 }
 
 window.fbAsyncInit = function() {
	  FB.init({
		  appId: '413483422869318',
	        cookie : true, 
	        xfbml : true, 
	        version : 'v5.0' 
	  });
	  
	  function checkLoginState() {
	      FB.getLoginStatus(function(response) {
	            statusChangeCallback(response);
	      });
	}
	  
	  // function to check the login status
	  
	  function statusChangeCallback(response) {
	      console.log('statusChangeCallback');
	      console.log(response);

	      if (response.status === 'connected') {
	            // Logged into your app and Facebook.
	             //testAPI();
	    	  //document.getElementById('status').innerHTML='succesfully connected';
	       } else if (response.status === 'not_authorized') {
	            // The person is logged into Facebook, but not your app.
	             document.getElementById('status').innerHTML = 'Please log ' +'into this app.';
	       } else {
	             // The person is not logged into Facebook, so we're not sure if
	             // they are logged into this app or not.
	             document.getElementById('status').innerHTML = 'Please log ' + 'into Facebook.';
	       }
	}
	  
	  FB.getLoginStatus(function(response) {
	        statusChangeCallback(response);
	        },{scope:'user_friends,user_birthday,email,publish_actions'});
	  };
	// Load the Facebook SDK asynchronouslyxs
	  (function(d, s, id) {
	        var js, fjs = d.getElementsByTagName(s)[0];
	        if (d.getElementById(id)) return;
	        js = d.createElement(s); js.id = id;
	        js.src = "//connect.facebook.net/en_US/sdk.js";
	        fjs.parentNode.insertBefore(js, fjs);
	  }(document, 'script', 'facebook-jssdk'));
   	 	
   	</script>
</body>
</html>
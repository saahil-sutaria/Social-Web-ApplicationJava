<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
	<script>
  window.fbAsyncInit = function() {
    FB.init({
      appId      : '413483422869318',
      xfbml      : true,
      cookie     :true,
      version    : 'v5.0'
    });
    FB.AppEvents.logPageView();
    // ADD ADDITIONAL FACEBOOK CODE HERE
  };

  (function(d, s, id){
     var js, fjs = d.getElementsByTagName(s)[0];
     if (d.getElementById(id)) {return;}
     js = d.createElement(s); js.id = id;
     js.src = "//connect.facebook.net/en_US/sdk.js";
     fjs.parentNode.insertBefore(js, fjs);
   }(document, 'script', 'facebook-jssdk'));

// Place following code after FB.init call.

function onLogin(response) {
  if (response.status == 'connected') {
    FB.api('/me?fields=first_name', function(data) {
      var welcomeBlock = document.getElementById('fb-welcome');
      welcomeBlock.innerHTML = 'Hello, ' + data.first_name + '!';
    });
  }
}

FB.getLoginStatus(function(response) {
  // Check login status on load, and if the user is
  // already logged in, go directly to the welcome message.
  if (response.status == 'connected') {
    onLogin(response);
  } else {
    // Otherwise, show Login dialog first.
    FB.login(function(response) {
      onLogin(response);
    }, {scope: 'user_friends, email'});
  }
});


</script>
 <script>    
    	function testAPI(){
    		console.log('Welcome! Fetching your information.... ');
            FB.api('/me', function (response) {
            	debugger;
                console.log('Successful login for: ' + response.name);                                               
                document.getElementById('status').innerHTML = 'Thanks for logging in, ' + response.name + '!';                
            }, { scope: 'user_birthday' });            
            FB.api('/me', {fields: 'birthday'}, function(response) {            	  
            	  debugger;
            	  var dateString = response.birthday;
            	  var dateParts = dateString.split("/");
            	  var dateObject = new Date(dateParts[2], dateParts[0] - 1, dateParts[1]);            	 
                  document.getElementById('DOB').innerHTML = 'Your Birth day is : ' + dateObject.toString();
                  
                  // Calculate date difference between two dates 
                  var ageDifMs = Date.now() - dateObject.getTime();
                  var ageDate = new Date(ageDifMs); // miliseconds from epoch
                  document.getElementById('age').innerHTML = 'Your age is : ' + Math.abs(ageDate.getUTCFullYear() - 1970);                  
            })
    	}
    	
    	function statusChangeCallback(response){
    		console.log('Function : statusChangeCallback');
            console.log(response);            
            if (response.status === 'connected') {	// Logged into your app and Facebook.                
                testAPI();
            } else if (response.status === 'not_authorized') {	// The person is logged into Facebook, but not your app.
                document.getElementById('status').innerHTML = 'Please log into this app.';
            } else {
                // The person is not logged into Facebook, so we're not sure if
                // they are logged into this app or not.
                document.getElementById('status').innerHTML = 'Please log into Facebook.';
            }
    	}
    	</script>


<script>
// not being used currently
function postToFacebook() {
	var body = 'Reading JS SDK documentation';
	FB.api('/me/feed', 'post', { message: 'Hello' }, function(response) {
	  if (!response || response.error) {
	    alert(response.error);
	  } else {
	    alert('Post ID: ' + response.id);
	  }
	});
}
</script>


<a href="#" onClick="postToFeed()">Post to Feed</a>
<br>

<script>

function postToFeed() {
	FB.ui({
		  method: 'feed',
		  link: 'https://apps.facebook.com/twitter/tweets.jsp',
		  caption: 'Posting to feed',
		}, function(response){});
}
</script>
<br>
<a href="#" onClick="publishToFeed()">Publish to Facebook</a>
<script>
function publishToFeed() {
FB.login(function()
		{   FB.api('/me/feed', 'post', {message: 'Hello, world!'});  }, {scope: 'publish_actions'});
}
</script>
<script>
 function testMessageCreate() {
            console.log('Posting a message to user feed.... ');
            //first must ask for permission to post and then will have call back function defined right inline code
            // to post the message.
            FB.login(function () {
                var typed_text = document.getElementById("message_text").value;
                FB.api('/me/feed', 'post', { message: typed_text });
                document.getElementById('theText').innerHTML = 'Thanks for posting the message' + typed_text;
            }, { scope: 'publish_actions,email,public_profile,user_birthday', return_scopes: true});
        } //user_birthday', return_scopes: true});
        
        // Load the SDK asynchronously
        (function(d, s, id) {
            var js, fjs = d.getElementsByTagName(s)[0];
            if (d.getElementById(id)) return;
            js = d.createElement(s); js.id = id;
            js.src = "//connect.facebook.net/en_US/sdk.js";
            fjs.parentNode.insertBefore(js, fjs);
        }(document, 'script', 'facebook-jssdk'));
    </script>
        
    <fb:login-button scope="public_profile,email" onlogin="checkLoginState();">
    </fb:login-button>

    <div id="status">
    </div>
   
    <input type="text" value="" id="message_text" />
    <input type="button" value="enter" onclick="testMessageCreate();" />
    <br><br>

 <fb:login-button scope="public_profile,email,user_friends" onlogin="checkLoginState();">
   </fb:login-button>
   <br></br>
   <div id="tweet" style="display:none"/>
   <form action="/store" method="get">
   <input type="submit" value="Try Tweet Application" id="tapp" onclick="location.href='/tweets.jsp?'"/>
   <input type="hidden" value="uname" id="uname" name="uname"/>
   </form>
   </div>
</body>
</html>
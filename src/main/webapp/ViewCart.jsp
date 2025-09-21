<%@page import="java.util.HashMap"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.foodbox.Modal.DAO"%>
<%
	String uemail=(String)session.getAttribute("uemail");
	if(uemail==null){
		session.setAttribute("msg", "Please Login First!");
		response.sendRedirect("User.jsp");
	}else{
		String name=(String)session.getAttribute("name");
%>

<!DOCTYPE html>
<html>

<head>
  <title>FoodBox</title>
  <link rel="icon" href="resources/foodbox-logo.png" />

  <meta name="viewport" content="width=device-width, initial-scale=1">

  <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/js/bootstrap.bundle.min.js"></script>
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css" />

  <!-- font-awesome -->
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.1/css/all.min.css" integrity="sha512-MV7K8+y+gLIBoVD59lQIYicR65iaqukzvf/nwasF0nqhPay5w/9lJmVM2hMDcnK1OnMGCdVK+iQrJ7lzPJQd1w==" crossorigin="anonymous" referrerpolicy="no-referrer" />
  <script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.1/js/all.min.js" integrity="sha512-rpLlll167T5LJHwp0waJCh3ZRf7pO6IT1+LZOhAyP6phAirwchClbTZV3iqL3BMrVxIYRbzGTpli4rfxsCK6Vw==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
  
  <!-- Lightbox CSS & Script -->
  <script src="resources/lightbox/ekko-lightbox.js"></script>
  <link rel="stylesheet" href="resources/lightbox/ekko-lightbox.css"/>

  <!-- AOS CSS & Script -->
  <script src="resources/aos/aos.js"></script>
  <link rel="stylesheet" href="resources/aos/aos.css"/>

  <!-- custom css -->
  <link rel="stylesheet" href="resources/custom.css">

  <meta name="author" content="BCA-Student IIMT COLLEGE" />
  <meta name="description" content="This is a website for Food Restaurant." />
  <meta name="keywords" content="" />
</head>

<body>
	
	<%
		String msg=(String)session.getAttribute("msg");
	  	if(msg!=null){
	%>
			<p class="text-center bg-warning p-2"> <%=msg%> </p>
	<%  		
		  session.setAttribute("msg",null);
	  	}
	%>
	
    <nav class="navbar navbar-expand-sm container my-3">
        <a href="UserHome.jsp" class="navbar-brand">
          <img src="resources/foodbox-logo.png" height="35px" alt="">
          <span>Food</span>Box
        </a>
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#my-navbar">
      <i class="fa-solid fa-bars"></i>
        </button>
        <div class="collapse navbar-collapse" id="my-navbar">
            <ul class="navbar-nav mx-auto p-2">
              <li>
                <a href="UserHome.jsp">Home</a>
              </li>
              <li>
                <a href="Menu.jsp">Menu</a>
              </li>
            </ul>
            <img src="GetUserPhoto?uemail=<%= uemail  %>" height="30px" style="border-radius:50%;margin:0px 5px;"/>
            Welcome: <b> <%=name %> </b>
            
      		<% DAO db=new DAO(); %>
      		<a class="mx-2 btn btn-sm btn-warning" href="ViewCart.jsp">Cart [ <b><%= db.countCart(uemail) %></b> ]</a>
            <a id="call" class="bg-danger" href="Logout">Logout</a>
        </div>
    </nav>
    <section class="container">
      	<h4 class="bg-success text-white p-3">Cart Items:</h4>
      	<%
      	int total=0;
      	String[] items=db.getAllCartItemsByEmail(uemail);
		if(items==null){
		%>
			<p class="bg-warning p-3">Cart is Empty</p>
		<%	
		}else{
			for(String item:items){
				%>
				<div class="bg-light p-2 m-2">
					<p>
						<img src="GetItemPhoto?name=<%=item  %>" height="50px" />
						Name: <b><%= item  %></b>
						<%
							int price=db.getItemPrice(item);
							total+=price;
						%>
						Price: <b><%= price  %></b>
						<a href="RemoveFromCart?item_name=<%= item  %>" class="btn btn-sm btn-danger mx-2">Remove</a>
					</p>
				</div>
				<%			
			}
		}
		db.closeConnection();
      	%>
      	<p class="bg-success text-white p-3 text-center">
      	Total Amount: <b><%= total %></b> &nbsp;&nbsp;&nbsp;
      	<% session.setAttribute("total", total); %>
      	<a class="btn btn-sm btn-warning" href="PlaceOrder.jsp">Place Order</a>
      	</p>
    </section>
    
    <footer class="bg-dark p-5 text-center">
        <a href="">
          <img src="resources/foodbox-logo.png" height="30px" alt="">
          <span>Food</span>Box
        </a>
        <br/>
        <p>&copy Rights Reserved</p>
        <p>
          <a href="https://www.facebook.com/incapp"><i class="fa-brands fa-facebook"></i></a>
          <a href="https://www.instagram.com/incapp.in"><i class="fa-brands fa-instagram"></i></a>
          <a href="https://www.youtube.com/incapp"><i class="fa-brands fa-youtube"></i></a>
        </p>
    </footer>
    <label id="top-button"><i class="fa-solid fa-circle-up fa-2x"></i></label>

    
</body>
<script>
    //script for scroll to top
    $("#top-button").click(function () {
        $("html, body").animate({scrollTop: 0}, 1000);
    });
</script>
</html>

<% } %>
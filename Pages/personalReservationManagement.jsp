<%@ page import="java.sql.*" %>
<%
session = request.getSession();

if (session.getAttribute("login") != null && session.getAttribute("function") != null) {
  if (!session.getAttribute("function").equals(3)) {
    response.sendRedirect("homePage.jsp?state=3");
  }
} else {
  response.sendRedirect("PgLogin.jsp?state=2");
}

if (request.getParameter("state") != null) {
  switch (request.getParameter("state")) {
    case "1":
      out.println("<script>alert('Reservation added successfully');</script>");
      break;
    case "2":
      out.println("<script>alert('Reservation removed successfully');</script>");
      break;
    case "3":
      out.println("<script>alert('A problem occurred!');</script>");
      break;
  }
}
%>

<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="UTF-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <link rel="stylesheet" href="bootstrap.css">
  <title>Personal reservation management</title>
  <style>
    body {
      background: #eee;
      background-image: url('login-background-img.jpg');
      /*background-image: url('1431301.jpg');*/
      -webkit-background-size: cover;
      -moz-background-size: cover;
      -o-background-size: cover;
      background-size: cover;
    }

    .table-div {
      margin: 5%;
      margin-top: 10px;
    }

    .management-icon {
      width: 40px;
      height: 40px;
    }

    .button {
      margin-top: 3%;
      height: 60px;
      width: 60px;
      margin-left: 1270px;
    }

    .button2 {
      margin-top: 3%;
      height: 60px;
      width: 60px;
      margin-left: 30px;
    }
  </style>
</head>

<body>
  <a href="./homePage.jsp"><img src="./home.png" alt="home.png" class="button"></a>
  <a href="PgReservation.jsp"><img src="./reservation.png" alt="reservation.png" class="button2"></a>
  <div class="table-div">
    <table class="table table-hover">
      <thead style="background-color: #c3a48f;">
        <tr>
          <th scope="col" style="color: black;">Date</th>
          <th scope="col" style="color: black;">Time</th>
          <th scope="col" style="color: black;">Pet</th>
          <th scope="col" style="color: black;">Service Type</th>
          <th scope="col" style="color: black;">Employee</th>
          <th scope="col" style="color: black;">Edit</th>
          <th scope="col" style="color: black;">Remove</th>
        </tr>
      </thead>
      <tbody>
        <%
        if (session.getAttribute("login") != null) {
            Connection conn = null;
            Class.forName("com.mysql.jdbc.Driver").newInstance();
            String jdbcURL="jdbc:mysql://localhost:3306/beauty_salon_management";  // BD "jsp"
            conn = DriverManager.getConnection(jdbcURL,"root", "");

            PreparedStatement psSelectRecord=null;
            ResultSet rsSelectRecord=null;
            String sqlSelectRecord=null;
        sqlSelectRecord = "SELECT * FROM reservation WHERE idClient='" + session.getAttribute("login") + "'" ;
        psSelectRecord = conn.prepareStatement(sqlSelectRecord);
        rsSelectRecord = psSelectRecord.executeQuery();

          while (rs.next()) {
            out.println("<tr class='table-secondary'>");
            out.println("<td>" + rsSelectRecord.getString("date") + "</td>");
            out.println("<td>" + rsSelectRecord.getString("time") + "</td>");
            out.println("<td>" + rsSelectRecord.getString("pet") + "</td>");
            out.println("<td>" + rsSelectRecord.getString("serviceType") + "</td>");
            out.println("<td>" + rsSelectRecord.getString("EmployeeUser") + "</td>");
            out.println("<td><a href='Pgedit_reservation.jsp?id=" + rs.getString("idReservation") + "'><img src='edit.png' class='management-icon'></a></td>");
            out.println("<td><a href='delete_reservation.jsp?id=" + rs.getString("idReservation") + "'><img src='remove.png' class='management-icon'></a></td>");
            out.println("</tr>");
          }

          rsSelectRecord.close();
          psSelectRecord.close();
          conn.close();
        }
        %>
      </tbody>
    </table>
  </div>
</body>

</html>
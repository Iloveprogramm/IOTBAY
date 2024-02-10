<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>IoTBay account logs</title>
  <link rel="stylesheet" href="landing.css">
</head>

<jsp:useBean id="account_info" scope="session" class="Controllers.AccountController"/>

<%
    String filterYear = "";
    String filterMonth = "";
    String filterDay = "";
  
    if (request.getParameter("searchButton") != null) {
        if (request.getParameter("searchButton").equals("Clear")){
        
        }else{
            filterYear = request.getParameter("year");
            filterMonth = request.getParameter("month");
            filterDay = request.getParameter("day");
            if(filterMonth.length() == 1){
                filterMonth = "0"+ filterMonth;
            }
            if(filterDay.length() == 1){
                filterDay = "0"+ filterDay;
            }
        }
    }
    %>
   <jsp:useBean id="logs" scope="page" class="Controllers.LogsController" />
<body>
  <header>
        <h1>Account Logs</h1>
    <nav>
        <button onclick="location.href='index.jsp'">Home</button>
        <button onclick="location.href='account.jsp'">Account</button>
        <button onclick="location.href='logout.jsp'">Logout</button>
    </nav>
  </header>
  
  <main>

    <div class="container">
        <div class ="card" style ="width:450px" style = "background-color: #f1f1f1">
             <form name="FilterForm" method="POST">
                <label for="day">Year: </label><input type="text" name="year" value="<%=filterYear%>" size="10" />
                <label for="day">Month: </label><input type="text" name="month" value="<%=filterMonth%>" size="5" />
                <label for="day">Day: </label><input type="text" name="day" value="<%=filterDay%>" size="5" />
                <input type="submit" value="Search" name="searchButton" />
                <input type="submit" value="Clear" name="searchButton" />
            </form>
        <table border='1' style='border-style: solid; border-width: 1px 1px 1px 1px ; border-collapse: collapse; overflow-y: scroll; width:450px; height:400px; display:block;'>
            <tr>
                <th style = "width:50px">log No</th>
                <th style = "width:200px">login time</th>
                <th style = "width:200px">logout time</th>
            </tr>
            
        <%
         logs.retreiveLogs(Integer.valueOf(account_info.getId()));
         int size = logs.getSize(Integer.valueOf(account_info.getId()));
         for (int i = 1; i < size; i++){
            String[] log_info = logs.getLog(i);
            String logDates = log_info[1].substring(0, 10);
            String[] logSplit = logDates.split("-");
            
            if (logSplit[0].contains(filterYear) & logSplit[1].contains(filterMonth) & logSplit[2].contains(filterDay)){
        %>
            <tr>  
                <td><%=log_info[0]%></td>
                <td><%=log_info[1]%></td>
                <td><%=log_info[2]%></td>
            </tr>
            
        
        <%}}%> 
        
       </table>
            </div>
        </div>
  </main>
  
  <footer>
    <p>&copy; 2023 IoTBay All Rights Reserved</p>
  </footer>
</body>
</html>

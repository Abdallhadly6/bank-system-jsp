<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.util.Calendar"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.time.LocalDate"%>
<%@page import="java.sql.*"%>  
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Banking System</title>
    </head>
    <body>
        <%    
            try{
                LocalDate currentdate = LocalDate.now();
                String checkDate = currentdate.getYear() + "-" + currentdate.getMonthValue() + "-" + currentdate.getDayOfMonth();
                String url = "jdbc:mysql://localhost:3306/bank_data";
                String user = "root";
                String password = "root";
                Connection Con = null;
                String line = "";
                Con = DriverManager.getConnection(url, user, password);
                Statement S = Con.createStatement();
                ResultSet RS2 = S.executeQuery ( "SELECT btcreationdata FROM bank_data.banktransaction WHERE banktransactionid =" +request.getParameter("hiddentid")+";");
                RS2.next();
               if(checkDate.equals(RS2.getString("btcreationdata"))){
                    line = ("DELETE FROM bank_data.banktransaction WHERE banktransactionid =" + request.getParameter("hiddentid") + ";"); 
                    int x = S.executeUpdate(line);
                    //ResultSet RS3 = S.executeQuery ( "(SELECT bacurrentbalance FROM bank_data.bankaccount WHERE bankaccountid ='" +request.getParameter("hiddento")+"')");
//                    String temp = "";
//                    while (RS3.next()){
//                        temp = RS3.getString("bacurrentbalance");
//                    }
//                    String line2 = "UPDATE bank_data.bankaccount "
//                            + "SET "
//                            + "bacurrentbalance = "+ (Integer.parseInt(temp)-Integer.parseInt(request.getParameter("hiddenamount"))) + " "
//                            + "WHERE "
//                            + "bankaccountid = "+Integer.parseInt(request.getParameter("hiddento"))+ ";";
//                    int x1 = S.executeUpdate(line2);
//                    ResultSet RS4 = S.executeQuery ( "(SELECT bacurrentbalance FROM bank_data.bankaccount WHERE bankaccountid ='" +request.getParameter("hiddenfrom")+"')");
//                    String temp2 = "";
//                    while (RS4.next()){
//                        temp2 = RS4.getString("bacurrentbalance");
//                    }
//                    String line3 = "UPDATE bank_data.bankaccount "
//                            + "SET "
//                            + "bacurrentbalance = "+ (Integer.parseInt(temp2)+Integer.parseInt(request.getParameter("hiddenamount"))) + " "
//                            + "WHERE "
//                            + "bankaccountid = "+Integer.parseInt(request.getParameter("hiddenfrom"))+ ";";
//                    int x2 = S.executeUpdate(line3);

                    
               }
               response.sendRedirect("transactions.jsp");
                
            }catch (Exception ex) {
                ex.printStackTrace();
            }
        %>
    </body>
</html>

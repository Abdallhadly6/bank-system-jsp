<%@page import="java.time.LocalDate"%>
<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Banking System</title>
    </head>
    <body>
        <%    
            try{
                String customer_id = request.getSession().getAttribute("session_cust_id").toString();
                String url = "jdbc:mysql://localhost:3306/bank_data";
                String user = "root";
                String password = "root";
                Connection Con = null;
                Con = DriverManager.getConnection(url, user, password);
                String to_account_id = request.getParameter("to");
                String amount_send = request.getParameter("amount");
                Statement S = Con.createStatement();
                Statement Stmt = null;
                Stmt = Con.createStatement();
                ResultSet RS = S.executeQuery ( "(SELECT bankaccountid , bacurrentbalance FROM bank_data.bankaccount where customerid ='" + customer_id +"')");             
                String baidfrom = "";
                String balanceoffrom = "";
                LocalDate date = LocalDate.now();
                while (RS.next()){
                    baidfrom = RS.getString("bankaccountid");
                    balanceoffrom = RS.getString("bacurrentbalance");
                }
                ResultSet RS2 = S.executeQuery ( "(SELECT bankaccountid , bacurrentbalance FROM bank_data.bankaccount where bankaccountid ='" + to_account_id +"')"); 
                String baidto = "";
                String balanceofto = "";
                while (RS2.next()){
                    baidto = RS2.getString("bankaccountid");
                    balanceofto = RS2.getString("bacurrentbalance");
                }
                if(to_account_id.equals(baidto)&& Integer.parseInt(to_account_id)!= Integer.parseInt(baidfrom) &&(Integer.parseInt(balanceoffrom) > Integer.parseInt(amount_send))){                
                    String line = "UPDATE bankaccount "
                            + "SET "
                            + "bacurrentbalance = "+ (Integer.parseInt(balanceofto)+Integer.parseInt(amount_send)) + " "
                            + "WHERE "
                            + "bankaccountid = "+ Integer.parseInt(baidto) + ";";
                    int x = Stmt.executeUpdate(line);
                    String line2 = "UPDATE bankaccount "
                            + "SET "
                            + "bacurrentbalance = "+ (Integer.parseInt(balanceoffrom)-Integer.parseInt(amount_send)) + " "
                            + "WHERE "
                            + "bankaccountid = "+ Integer.parseInt(baidfrom) + ";";
                    int x1 = Stmt.executeUpdate(line2);
                    
                    String line3 = "INSERT INTO banktransaction(btcreationdata, btamount, btfromaccount,bttoaccount) VALUES("
                    + "' " + date + "',"
                    + amount_send + ","
                    + Integer.parseInt(baidfrom) + ","
                    + Integer.parseInt(baidto) + ");";
                    int x2 = Stmt.executeUpdate(line3); 
                    response.sendRedirect("transactions.jsp");  
                }
                else{
                    response.sendRedirect("transactions.jsp");
                }
               
                
            }catch (Exception ex) {
                ex.printStackTrace();
            }
        %>
    </body>
</html>

<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<% Class.forName("com.mysql.jdbc.Driver").newInstance(); %>
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
                String customer_name = request.getSession().getAttribute("session_cust_name").toString();
                String url = "jdbc:mysql://localhost:3306/bank_data";
                String user = "root";
                String password = "root";
                Connection Con = null;
                Con = DriverManager.getConnection(url, user, password);
                Statement S = Con.createStatement();
                ResultSet RS = S.executeQuery ( "(SELECT * FROM bank_data.bankaccount where customerid ='" + customer_id +"')");             
                int temp = 0;
                String baid = "NO Account";
                String balance = "NO Balance";
                while (RS.next()){      
                    String id = RS.getString("customerid");
                    baid = RS.getString("bankaccountid");
                    balance = RS.getString("bacurrentbalance");
                    if (id.equals(customer_id)){
                        temp++;                 
                    }
                }
                %>
                   
                    <style>
                        body {
                          background:url(background.jpg);
                          margin: 0 15%;
                          font-family: sans-serif;
                          color: #ffffff;
                          }

                        h1 {
                          color: #ffffff;
                          text-align: center;
                          font-family: serif;
                          font-weight: normal;
                          text-transform: uppercase;
                          border-bottom: 2px solid #57b1dc;
                          margin-top: 30px;
                        }
                    </style>
                    <div style="background-color: #152238">
                        <h1>welcome at your home page <br><%=customer_name%> </h1>
                    </div>
                    <table cellspacing="5" cellpadding="5" border="1">
                        <tr>
                            <td align="right">Your Balance:</td>
                            <td><%=balance%></td> 
                        </tr>

                        <tr>
                            <td align="right">Your Account Number:</td>
                            <td><%=baid%></td>
                        </tr>
                    </table>
                    <%
                if(temp == 0){
                    %>
                    <form action="addaccountservlet" method="get" onsubmit="alert('YOUR ACCOUNT CREATED');">
                        <div style="text-align: center; padding-left: 100px ; padding-top: 100px">
                        <input type="submit" value="Add Account" style="width:100px ; height: 40px">
                        </div>
                    </form> 
                    <%
                }
                else{
                    %>
                    <div style="text-align: center; padding-left: 100px ; padding-top: 100px">
                        <button type="button" disabled style=" width:100px ; height: 40px">Add Account</button>
                    </div>
                    <form action="transactions.jsp" method="get">
                        <div style="text-align: center; padding-left: 100px ; padding-top: 50px">
                        <input type="submit" value="Tranactions" style="width:100px ; height: 40px">
                        </div>
                    </form>
                    <%
                }
            }catch (Exception ex) {
                ex.printStackTrace();
            }
        %>
    </body>
</html>

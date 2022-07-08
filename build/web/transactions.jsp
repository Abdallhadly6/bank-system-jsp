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
                        <h1>welcome at your Transaction page <br><%=customer_name%> </h1>
                    </div >
                    <form action="validatetransferdata.jsp" method="get">
                        <div style="padding-top: 30px">
                            <input type="text" name="to" value="Transaction To" onfocus="this.value=''">
                            <input type="text" name="amount" value="Transaction Amount" onfocus="this.value=''">
                        <input type="submit" value="Transfer" >
                        </div>
                    </form>
                    <div style=" text-align: center ; padding-top: 15px">
                        <h2>Your Transactions Data</h2>
                    </div >
                    
                    <%
                String amount = "";
                String date = "";
                String to = "";
                String from = "";
                String tid = "";
                ResultSet RS2 = S.executeQuery ( "SELECT * FROM bank_data.banktransaction WHERE btfromaccount =" +Integer.parseInt(baid)+";");             
                while (RS2.next()){
                    tid = RS2.getString("banktransactionid");
                    amount = RS2.getString("btamount");
                    date = RS2.getString("btcreationdata");
                    to = RS2.getString("bttoaccount");
                    from = RS2.getString("btfromaccount");
                    %>
                    <div style=" text-align: center ;">
                       
                         <table border="1">
                            <tr>
                                <th>Transaction ID </th>
                                <th>Transaction Amount </th>
                                <th>Transaction Date </th>
                                <th>Transaction TO </th>
                                <th>Transaction From </th>
                                <th>Cancel Transaction </th>
                            </tr>
                            <tr>
                                <td><%=tid %></td>
                                <td><%=amount %></td>
                                <td><%=date %></td>
                                <td><%=to %></td>
                                <td>ME</td>
                                <td>
                                    <form action="checkcancelation.jsp" method="get">
                                        <input type="hidden" value="<%=amount %>" name="hiddenamount">
                                        <input type="hidden" value="<%=from %>" name="hiddenfrom">
                                        <input type="hidden" value="<%=to %>" name="hiddento">
                                        <input type="hidden" value="<%=tid %>" name="hiddentid">
                                        <input type="submit" value="Cancel Transactions within 24 (hours)" style="margin:5px">
                                    </form>
                                </td>
                            </tr>
                            <br>
                         </table>
                               
                    </div > 
                    
                     <%
                }
                %>
                   
                <%
                
            }catch (Exception ex) {
                ex.printStackTrace();
            }
        %>
    </body>
</html>

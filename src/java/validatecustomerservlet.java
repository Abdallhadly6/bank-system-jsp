import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet(urlPatterns = {"/validatecustomerservlet"})
public class validatecustomerservlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            try {

                Class.forName("com.mysql.jdbc.Driver");
                String url = "jdbc:mysql://localhost:3306/bank_data";
                String user = "root";
                String password = "root";
                Connection Con = null;
                Con = DriverManager.getConnection(url, user, password);
                String cust_id = request.getParameter("id");
                String cust_password = request.getParameter("password");
                Statement S = Con.createStatement();
                ResultSet RS = S.executeQuery ( "(SELECT * FROM bank_data.customer where customerid ='" + cust_id + 
                               "' and epassword ='" + cust_password + "')");
                
                int temp = 0;
                String name = " ";
                while (RS.next()){      
                    String id = RS.getString("customerid");
                    String Password = RS.getString("epassword");
                    name = RS.getString("customername");
                    if (id.equals(cust_id) && Password.equals(cust_password)){
                        temp++;                 
                    }
                }
                if(temp == 0){
                    response.sendRedirect("login.html");
                }
                else{
                    HttpSession session = request.getSession(true);
                    session.setAttribute("session_cust_id", cust_id);
                    session.setAttribute("session_cust_name", name);
                    response.sendRedirect("customerhome.jsp");
                }
            }catch (Exception ex) {
                ex.printStackTrace();
            }
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}

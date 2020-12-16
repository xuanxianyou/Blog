package blog;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

import static java.lang.System.out;

@WebServlet(name = "IndexServlet")
public class BlogServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html;charset=utf-8");
        request.setCharacterEncoding("utf-8");
        HttpSession session=request.getSession();
        String email=session.getAttribute("EMAIL").toString();
        if(!email.equals("")){
            String username=request.getParameter("nickname");
            String work=request.getParameter("career");
            String phone=request.getParameter("phone");
            String address=request.getParameter("address");
            saveUserInfo(email,username,work,phone,address);
            out.println(username);
            out.println(work);
            out.println(phone);
            out.println(address);

            request.getRequestDispatcher("blog.jsp").forward(request,response);
        }else{
            request.getRequestDispatcher("login.jsp").forward(request,response);
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html;charset=gb2312");
        request.setCharacterEncoding("gb2312");
        request.getRequestDispatcher("login.jsp");
    }
    protected void saveUserInfo(String email,String username,String work,String phone,String address){
        try{
            //连接数据库
            Class.forName("com.mysql.cj.jdbc.Driver");
            String URL = "jdbc:mysql://127.0.0.1:3306/Login?characterEncoding=utf-8";
            String USER = "root";
            String PASSWORD = "123456";
            Connection conn= DriverManager.getConnection(URL, USER, PASSWORD);
            out.println("Database Connecting...");
            //插入语句
            String updateUserTable="UPDATE USER SET username=?,work=?,phone=?,address=? WHERE email=? ;";
            PreparedStatement statement=conn.prepareStatement(updateUserTable);
            statement.setBytes(1,username.getBytes());
            statement.setBytes(2,work.getBytes());
            statement.setString(3,phone);
            statement.setBytes(4,address.getBytes());
            statement.setString(5,email);
            int result=statement.executeUpdate();
            if (result>0){
                out.println("Update UserInfo Successfully...");
            }
            conn.close();
        }catch (Exception e ){
            e.printStackTrace();
        }
    }
}

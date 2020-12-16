package login;

import utils.SaltCrypto;

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
import java.sql.ResultSet;

import static java.lang.System.out;

@WebServlet(name = "LoginServlet")
public class LoginServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");
        String email=request.getParameter("emailLogin");
        String password=request.getParameter("password");
        if(!(email.equals("")&&password.equals(""))){
            //判断用户状态
            if(verifyUserState(email)){
                if(verifyUserInfo(email,password)){
                    HttpSession session=request.getSession();
                    session.setAttribute("EMAIL",email);
                    request.getRequestDispatcher("blog.jsp").forward(request,response);
                }else{
                    out.println("用户密码不正确！");
                    request.getRequestDispatcher("login.jsp").forward(request,response);
                }
            }else{
                out.println("用户邮箱尚未验证!");
                request.getRequestDispatcher("login.jsp").forward(request,response);
            }

        }else{
            request.getRequestDispatcher("login.jsp").forward(request,response);
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html;charset=gb2312");
        request.setCharacterEncoding("gb2312");
        request.getRequestDispatcher("login.jsp").forward(request,response);
    }
    protected boolean verifyUserState(String email){
        String isChecked="";
        try{
            //连接数据库
            Class.forName("com.mysql.cj.jdbc.Driver");
            String URL = "jdbc:mysql://127.0.0.1:3306/Login?characterEncoding=utf-8";
            String USER = "root";
            String PASSWORD = "123456";
            Connection conn= DriverManager.getConnection(URL, USER, PASSWORD);
            out.println("Database Connecting...");
            //查询语句
            String findUserTable=" SELECT isChecked FROM USER WHERE email=?";
            PreparedStatement statement=conn.prepareStatement(findUserTable);
            statement.setString(1,email);
            ResultSet result=statement.executeQuery();
            while(result.next()){
                isChecked = result.getString(1);
            }
            conn.close();
            return isChecked.equals("True");
        }catch (Exception e ){
            e.printStackTrace();
        }
        return false;
    }
    protected boolean verifyUserInfo(String email,String password){
        String passwordHash="";
        String salt="";
        try{
            //连接数据库
            Class.forName("com.mysql.cj.jdbc.Driver");
            String URL = "jdbc:mysql://127.0.0.1:3306/Login?characterEncoding=utf-8";
            String USER = "root";
            String PASSWORD = "123456";
            Connection conn= DriverManager.getConnection(URL, USER, PASSWORD);
            out.println("Database Connecting...");
            //查询语句
            String findUserTable=" SELECT password,salt FROM USER WHERE email=?";
            PreparedStatement statement=conn.prepareStatement(findUserTable);
            statement.setString(1,email);
            ResultSet result=statement.executeQuery();
            while(result.next()){
                passwordHash = result.getString(1);
                salt=result.getString(2);
            }
            conn.close();
            return SaltCrypto.verifyPassword(password,salt,passwordHash);
        }catch (Exception e ){
            e.printStackTrace();
        }
        return false;
    }
}

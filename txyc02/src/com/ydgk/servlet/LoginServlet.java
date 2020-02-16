package com.ydgk.servlet;

import com.ydgk.dao.AdminDao;
import com.ydgk.dao.impl.AdminDaoImpl;
import com.ydgk.entity.Admin;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.net.URLEncoder;

/**
 * @author asus
 * @create 2019-08-08 19:58
 */
@WebServlet("/login.action")
public class LoginServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        this.doGet(request, response);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        //获取表单传来的参数
        String username=request.getParameter("uloginname");
        String userpwd=request.getParameter("upsw");
        String code=request.getParameter("code");
        String roleid=request.getParameter("role");

        //获取记住密码信息
        String remember=request.getParameter("remember");


        //System.out.println(roleid);
        //判断输入的验证码和session中存的验证码是否一致
        HttpSession session=request.getSession();
        String checkCode = (String) session.getAttribute("code");
        //比较输入的验证码和session中的验证码是否相同，equalsIgnoreCase:不区分大小写的比较
        if (code.equalsIgnoreCase(checkCode)) {
            // 调用AdminDao的登录方法，传入用户名和密码进行数据库查询用户
            AdminDao adminDao=new AdminDaoImpl();
            Admin admin = adminDao.queryByNameAndPwd(username,userpwd,roleid);
            if (admin != null) {
                //判断是否勾选上记住密码
                if("remember-me".equals(remember)){
                    Cookie usernameCookie = new Cookie("username", URLEncoder.encode(admin.getUsername(),"utf-8"));
                    //账号设置记住7天时间

                    usernameCookie.setMaxAge(60*60*24*7);

                    Cookie userpwdCookie= new Cookie("userpwd", admin.getUserpwd());
                    //密码设置记住3天时间
                    userpwdCookie.setMaxAge(60*60*24*3);

                    //角色设置
                    Cookie ridCookie = new Cookie("rid", admin.getRid().toString());
                    ridCookie.setMaxAge(60*60*24*7);

                    //存入response中
                    response.addCookie(usernameCookie);
                    response.addCookie(userpwdCookie);
                    response.addCookie(ridCookie);
                }else{
                    //如果没有勾选上记住密码，删除coolies值
                    Cookie[] cookies = request.getCookies();
                    for (int i=0;i<cookies.length;i++){
                        if ("username".equals(cookies[i].getName())){
                           cookies[i].setMaxAge(0);
                        }
                        if ("userpwd".equals(cookies[i].getName())){
                            cookies[i].setMaxAge(0);
                        }
                        if ("rid".equals(cookies[i].getName())){
                            cookies[i].setMaxAge(0);
                        }
                    }
                }

                // 如果登录成功，跳转到后台主页
                // 1.将管理员对象保存在session
                session.setAttribute("admin", admin);
                if (roleid.equals("1")){
                    //跳转到学生页面
                    request.getRequestDispatcher("student.action?method=login").forward(request, response);
                }else if(roleid.equals("2")){
                    //跳转到教师页面
                    request.getRequestDispatcher("teacher.action?method=login").forward(request, response);

                }else {
                    //跳转到教务处管理员页面
                    request.getRequestDispatcher("admin.action?method=login").forward(request, response);
                }


            } else {
                // 登录失败，跳转到登录页面
                // 1.将错误信息存到request中
                request.setAttribute("errorMsg", "账号不存在！");
                // 2.转发到登录页面
                request.getRequestDispatcher("login.jsp").forward(request, response);

            }

        } else {
            // 验证码错误，跳转到登录页面
            // 1.将错误信息存到request中
            request.setAttribute("errorMsg", "验证码错误!");
            // 2.转发到登录页面
            request.getRequestDispatcher("login.jsp").forward(request, response);

        }

    }
}

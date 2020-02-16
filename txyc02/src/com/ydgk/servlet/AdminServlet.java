package com.ydgk.servlet;

import com.ydgk.dao.AdminDao;
import com.ydgk.dao.impl.AdminDaoImpl;
import com.ydgk.entity.Admin;
import com.ydgk.entity.Grade;
import com.ydgk.entity.Infomation;
import com.ydgk.util.PageBean;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.lang.reflect.Method;
import java.util.List;

/**
 * @author asus
 * @create 2019-08-11 22:15
 */
//使用注解的形式来配置Servlet
@WebServlet("/admin.action")
public class AdminServlet extends HttpServlet {
    //为下面调用adminDaoImpl里面的方法做准备
    AdminDao adminDao = new AdminDaoImpl();

    //重写HttpServlet中的doPost和doGet方法，这里为了方便，直接将请求交给doGet进行受理。
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        this.doGet(request, response);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        //防止POST请求出现中文乱码
        request.setCharacterEncoding("UTF-8");
        //获取method参数的值
        String methodName = request.getParameter("method");
        try {
            //利用反射调用与method参数值同名的方法，方法签名必须和doGet一样
            Method method = this.getClass().getDeclaredMethod(methodName, HttpServletRequest.class, HttpServletResponse.class);
            method.invoke(this, request, response);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    //登录进入到管理员页面
    protected void login(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("WEB-INF/jsp/admin/admin.jsp").forward(request, response);
    }

    //从登录页面进入到注册添加页面
    protected void toAdd(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("WEB-INF/jsp/main/add.jsp").forward(request, response);
    }

    //注册添加用户
    protected void add(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        //获取表单传来的参数
        String username = request.getParameter("uloginname");
        String userpwd = request.getParameter("upsw");
        String problem = request.getParameter("problem");
        String answer = request.getParameter("answer");
        String rid = request.getParameter("role");
        //封装成admin对象
        Admin admin = new Admin();
        admin.setUsername(username);
        admin.setUserpwd(userpwd);
        admin.setRid(Integer.parseInt(rid));
        admin.setAnswer(answer);
        admin.setProblem(problem);
        //调用dao中的方法,添加用户
        int i = adminDao.insert(admin);
        if (i > 0) {
            //i大于0表示添加成功，跳转到登录页面
            request.getRequestDispatcher("WEB-INF/success/success.html").forward(request, response);

            //response.sendRedirect("success.html");
        }
    }

    //账户管理，用户分页查询，包括了模糊查询
     protected void queryByPage(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        //获取前台页面传过来的页号参数
        //获取需要查询的字段
        String name = request.getParameter("name");
        String roleid = request.getParameter("role");
        if (roleid == null || roleid.isEmpty()) {
            roleid = "1";
        }
        //将name保存到request域中，用于回显查询的参数
        request.setAttribute("name", name);
        request.setAttribute("roleid", roleid);
        String pageStr = request.getParameter("pageNum");
        //保存页号的变量
        int pageNum = 1;
        if (pageStr != null) {
            pageNum = Integer.parseInt(pageStr);
        }
        //封装一个PageBean对象
        PageBean<Admin> pb = new PageBean<>();
        //封装每页条数和页号
        pb.setPageNum(pageNum);
        pb.setPageSize(3);
        //调用Dao方法
        //获取当前页的数据集合
        List<Admin> list = adminDao.queryList(pb, name, roleid);
        //获取总记录数
        int totalCount = adminDao.queryCount(name, roleid);
        //封装当前页数据的集合和总记录数
        pb.setList(list);
        pb.setTotalCount(totalCount);
        //把pageBean对象保存到作用域对象中
        request.setAttribute("pb", pb);
        //请求转发跳转到列表页面
        request.getRequestDispatcher("WEB-INF/jsp/admin/list.jsp").forward(request, response);
    }

    //通过id删除用户
    protected void deleteAdmin(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        //获取页码，用于返回该页码的查询列表
        String pageNum = request.getParameter("pageNum");
        request.setAttribute("pageNum", pageNum);

        //删除后返回保持在本角色页面
        String roleid = request.getParameter("role");
        request.setAttribute("roleid", roleid);

        //获取前台页面要删除用户的id
        String id = request.getParameter("id");
        //调用dao方法
        int i = adminDao.deleteAdminById(id);
        request.setAttribute("operate", "删除用户");
        if (i > 0) {
            request.getRequestDispatcher("WEB-INF/success/adminSuccess.jsp").forward(request, response);
        }
    }

    //通过本方法去跳转到修改密码的页面
    protected void toUpdate(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        //获取页码，用于返回该页码的查询列表
        String pageNum = request.getParameter("pageNum");
        request.setAttribute("pageNum", pageNum);

        //删除后返回保持在本页面
        String roleid = request.getParameter("role");
        request.setAttribute("roleid", roleid);

        //获取前台页面要修改用户的id
        String id = request.getParameter("id");
        //调用dao方法，查询用户信息
        Admin admin = adminDao.queryAdmin(id);
        //将admin对象保存到request域中
        request.setAttribute("admin", admin);
        request.getRequestDispatcher("/WEB-INF/jsp/admin/update.jsp").forward(request, response);
    }

    //通过id进行密码修改
    protected void update(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        //获取页码，用于返回该页码的查询列表
        String pageNum = request.getParameter("pageNum");
        request.setAttribute("pageNum", pageNum);

        //删除后返回保持在本页面
        String roleid = request.getParameter("role");
        request.setAttribute("roleid", roleid);

        //获取前台数据
        String id = request.getParameter("userid");
        String userpwd = request.getParameter("upsw");
        //调用dao方法
        int i = adminDao.update(id, userpwd);
        request.setAttribute("operate", "修改密码");
        if (i > 0) {
            request.getRequestDispatcher("WEB-INF/success/adminSuccess.jsp").forward(request, response);
        }
    }

    //对密码进行初始化
    protected void initPassword(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        //获取页码，用于返回该页码的查询列表
        String pageNum = request.getParameter("pageNum");
        request.setAttribute("pageNum", pageNum);

        //删除后返回保持在本页面
        String roleid = request.getParameter("role");
        request.setAttribute("roleid", roleid);

        //获取需要初始化用户的id
        String userid = request.getParameter("userid");
        //调用dao中的初始化方法
        int i = adminDao.init(userid);
        request.setAttribute("operate", "初始化密码");
        if (i > 0) {
            request.getRequestDispatcher("WEB-INF/success/adminSuccess.jsp").forward(request, response);
        }
    }

    //对所有学生用户的分数进行查询
    protected void queryGradeByPage(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        //获取前台页面传过来的页号参数
        //获取需要查询的字段
        String name = request.getParameter("name");
        //String gorder = "1";
        String gorder = request.getParameter("gorder");
        //System.out.println(order);
        /*if (order!=null&&order!=""){
            gorder=order;
        }*/
        //将name和gorder保存到request域中，用于回显查询的参数
        request.setAttribute("name", name);
        request.setAttribute("gorder", gorder);
        String pageStr = request.getParameter("pageNum");
        //保存页号的变量
        int pageNum = 1;
        if (pageStr != null) {
            pageNum = Integer.parseInt(pageStr);
        }
        //封装一个PageBean对象
        PageBean<Grade> pb = new PageBean<>();
        //封装每页条数和页号
        pb.setPageNum(pageNum);
        pb.setPageSize(3);
        //调用Dao方法
        //获取当前页的数据集合
        List<Grade> list = adminDao.gradeQueryList(pb, name, gorder);

        //获取总记录数
        int totalCount = adminDao.gradeQueryCount(name, gorder);
        //封装当前页数据的集合和总记录数
        pb.setList(list);
        pb.setTotalCount(totalCount);
        //把pageBean对象保存到作用域对象中
        request.setAttribute("pb", pb);
        //请求转发跳转到列表页面
        request.getRequestDispatcher("WEB-INF/jsp/admin/gradeList.jsp").forward(request, response);
    }


    //登录模块，忘记密码的实现

    //根据用户名查找用户所设置的问题
    protected void queryQuestion(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        //获取用户名
        String username = request.getParameter("username");
        //调用adminDao的方法
        Admin admin = adminDao.queryAdminByName(username);
        //将admin对象保存到request域中
        request.setAttribute("admin", admin);
        if (admin != null) {
            request.getRequestDispatcher("WEB-INF/jsp/admin/forget2.jsp").forward(request, response);
        } else {
            request.getRequestDispatcher("WEB-INF/error/error3.jsp").forward(request, response);
        }


    }

    //去到修改用户密码或用户问题的页面
    protected void toUpdateAdminInfo(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        //获取用户姓名
        String username = request.getParameter("username");
        String answer = request.getParameter("answer");
        //调用adminDao的方法
        Admin admin = adminDao.queryAdminByAnswer(username, answer);
        //将admin对象保存到request域中
        request.setAttribute("admin", admin);
        if (admin != null) {
            request.getRequestDispatcher("WEB-INF/jsp/main/updateAdminPwd.jsp").forward(request, response);
        } else {
            request.getRequestDispatcher("WEB-INF/error/error2.jsp").forward(request, response);
        }

    }

    //修改用户密码、设置的问题等信息
    protected void updateAdminInfo(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        //获取用户姓名
        String username = request.getParameter("username");
        String userpwd = request.getParameter("userpwd");
        String problem = request.getParameter("problem");
        String answer = request.getParameter("answer");

        //调用adminDao的方法
        int i = adminDao.updateAdminPwd(username, userpwd, problem, answer);
        request.setAttribute("operate", "信息修改");
        if (i > 0) {
            request.getRequestDispatcher("WEB-INF/success/success3.jsp").forward(request, response);

        }

    }

    //跳转到发布公告页面
    protected void toAddInfomation(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        //查询发布的消息
        AdminDao adminDao = new AdminDaoImpl();
        List<Infomation> list = adminDao.getInfomationList();
        request.setAttribute("infomationList", list);
        request.getRequestDispatcher("WEB-INF/jsp/admin/addInfomation.jsp").forward(request, response);

    }

    //发布公告
    protected void addInfomation(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        //获取发布的信息
        String text = request.getParameter("text");

        //调用adminDao方法
        int i = adminDao.insertInfomation(text);

        if (i > 0) {
            request.getRequestDispatcher("WEB-INF/success/success5.jsp").forward(request, response);
        }

    }

    //删除公告

    protected void deleteInfomation(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        //获取公告id
        String nid = request.getParameter("nid");
        int i = adminDao.deleteInfomationById(nid);
        if (i > 0) {
            request.getRequestDispatcher("admin.action?method=toAddInfomation").forward(request, response);

        }
    }

    //跳转到课程注册页面
    protected void toAddCourse(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

       //查询教师信息
        List<Admin> adminlist=adminDao.queryTeacherList();
        request.setAttribute("list",adminlist);
        request.getRequestDispatcher("WEB-INF/jsp/admin/addCourse.jsp").forward(request, response);
    }

    //课程注册
    protected void addCourse(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String coursename=request.getParameter("coursename");
        String courseclass=request.getParameter("courseclass");
        String tid=request.getParameter("tid");
        int i=adminDao.insertCourse(coursename,courseclass,tid);
        if (i>0){
            request.getRequestDispatcher("WEB-INF/success/success6.jsp").forward(request,response);
        }
    }

}


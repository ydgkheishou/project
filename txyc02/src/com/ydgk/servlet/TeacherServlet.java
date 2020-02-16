package com.ydgk.servlet;


import com.ydgk.dao.TeacherDao;
import com.ydgk.dao.impl.TeacherDaoImpl;
import com.ydgk.entity.Admin;
import com.ydgk.entity.Grade;
import com.ydgk.util.PageBean;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.lang.reflect.Method;
import java.util.List;

/**
 * @author asus
 * @create 2019-12-12 10:24
 */
@WebServlet("/teacher.action")
public class TeacherServlet extends HttpServlet {
    //为下面调用adminDaoImpl里面的方法做准备
    TeacherDao teacherDao = new TeacherDaoImpl();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        this.doGet(request, response);
    }

    @Override
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

    //登录跳转到teacher页面
    protected void login(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        request.getRequestDispatcher("WEB-INF/jsp/teacher/teacher.jsp").forward(request, response);
    }

    //学生用户分页查询，包括了模糊查询
    protected void queryByPage(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        //获取前台页面传过来的页号参数
        //获取需要查询的字段
        String name = request.getParameter("name");
        //将name保存到request域中，用于回显查询的参数
        request.setAttribute("name", name);
        String pageStr = request.getParameter("pageNum");

        //获取当前用户的信息,用来查找当前教师的学生和成绩
        HttpSession session = request.getSession();
        Admin admin = (Admin) session.getAttribute("admin");
        Integer userid = admin.getUserid();

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
        List<Admin> list = teacherDao.studentQueryList(pb, name, userid);
        //获取总记录数
        int totalCount = teacherDao.studentQueryCount(name, userid);
        //封装当前页数据的集合和总记录数
        pb.setList(list);
        pb.setTotalCount(totalCount);
        //把pageBean对象保存到作用域对象中
        request.setAttribute("pb", pb);
        //请求转发跳转到列表页面
        request.getRequestDispatcher("WEB-INF/jsp/teacher/list.jsp").forward(request, response);
    }

    //对本次教师的学生用户的分数进行查询
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

        //获取当前用户的信息,用来查找当前教师的学生和成绩
        HttpSession session = request.getSession();
        Admin admin = (Admin) session.getAttribute("admin");
        Integer userid = admin.getUserid();

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
        List<Grade> list = teacherDao.gradeQueryList(pb, name, gorder, userid);

        //获取总记录数
        int totalCount = teacherDao.gradeQueryCount(name, gorder, userid);
        //封装当前页数据的集合和总记录数
        pb.setList(list);
        pb.setTotalCount(totalCount);
        //把pageBean对象保存到作用域对象中
        request.setAttribute("pb", pb);
        //请求转发跳转到列表页面
        request.getRequestDispatcher("WEB-INF/jsp/teacher/gradeList.jsp").forward(request, response);
    }

    /* //对学生用户的分数进行查询
     protected void queryGradeByPageAll(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
         //获取前台页面传过来的页号参数
         //获取需要查询的字段
         String name = request.getParameter("name");
         //将name和gorder保存到request域中，用于回显查询的参数
         request.setAttribute("name", name);
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
         List<Grade> list = teacherDao.gradeQueryListAll(pb, name);

         //获取总记录数
         int totalCount = teacherDao.gradeQueryCount();
         //封装当前页数据的集合和总记录数
         pb.setList(list);
         pb.setTotalCount(totalCount);
         //把pageBean对象保存到作用域对象中
         request.setAttribute("pb", pb);
         //请求转发跳转到列表页面
         request.getRequestDispatcher("WEB-INF/jsp/teacher/allGradelist.jsp").forward(request, response);
     }
 */
    //点击修改成绩按钮后，跳转到修改页面
    protected void toUpdate(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        //获取页码，用于返回该页码的查询列表
        String pageNum = request.getParameter("pageNum");
        request.setAttribute("pageNum", pageNum);

        //获取前台页面要修改学生的id
        String userid = request.getParameter("userid");
        //获取前台页面要修改学生成绩的id
        String gid = request.getParameter("gid");
        //调用dao方法
        Grade grade = teacherDao.queryGrade(userid, gid);
        //将grade对象保存到request域中
        request.setAttribute("grade", grade);
        request.getRequestDispatcher("WEB-INF/jsp/teacher/updateGrade2.jsp").forward(request, response);


    }

    //通过gid进行成绩修改
    protected void update(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        //获取页码，用于返回该页码的查询列表
        String pageNum = request.getParameter("pageNum");
        request.setAttribute("pageNum", pageNum);

        //获取前台数据
        String gid = request.getParameter("gid");
        String chinese = request.getParameter("chinese");
        String math = request.getParameter("math");
        String english = request.getParameter("english");
        //获取userid,当学生没有gid时，可以新建关系，将userid赋值给sid
        String userid = request.getParameter("userid");
        //String sum = request.getParameter("sum");
        //调用dao方法
        int i = teacherDao.update(gid, chinese, math, english, userid);
        request.setAttribute("operate", "修改");
        if (i > 0) {
            //获取当前用户的信息,用来查找当前教师的学生和成绩
            HttpSession session = request.getSession();
            Admin admin = (Admin) session.getAttribute("admin");
            Integer rid = admin.getRid();
            if (rid == 2) {
                request.getRequestDispatcher("WEB-INF/success/success.jsp").forward(request, response);
            } else {
                request.getRequestDispatcher("WEB-INF/success/success2.jsp").forward(request, response);

            }


        }
    }

    //为选定的学生去到上传或添加成绩的页面
    protected void toUploadGrade(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        //获取页码，用于返回该页码的查询列表
        String pageNum = request.getParameter("pageNum");
        request.setAttribute("pageNum", pageNum);


        //将学生userid作为分数里面的sid
        String sid = request.getParameter("userid");
        String username = request.getParameter("username");
        request.setAttribute("sid", sid);
        request.setAttribute("username", username);
        request.getRequestDispatcher("WEB-INF/jsp/teacher/uploadGrade.jsp").forward(request, response);

    }

    //上传或添加学生成绩
    protected void gradeInsert(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        //获取页码，用于返回该页码的查询列表
        String pageNum = request.getParameter("pageNum");
        request.setAttribute("pageNum", pageNum);

        //获取需要传入的各个属性的值
        String chinese = request.getParameter("chinese");
        String math = request.getParameter("math");
        String english = request.getParameter("english");
        //String sum = request.getParameter("sum");
        String gorder = request.getParameter("gorder");
        //学生id
        String sid = request.getParameter("sid");
        //封装成一个对象
        Grade grade = new Grade();
        grade.setChinese(Integer.valueOf(chinese));
        grade.setMath(Integer.valueOf(math));
        grade.setEnglish(Integer.valueOf(english));
        //grade.setSum(Integer.valueOf(sum));
        grade.setGorder(Integer.valueOf(gorder));
        grade.setSid(Integer.parseInt(sid));
        //调用teacherDao中的方法
        int i = teacherDao.insert(grade);
        request.setAttribute("operate", "上传");
        if (i > 0) {
            //获取当前用户的信息,用来查找当前教师的学生和成绩
            HttpSession session = request.getSession();
            Admin admin = (Admin) session.getAttribute("admin");
            Integer rid = admin.getRid();
            if (rid == 2) {
                request.getRequestDispatcher("WEB-INF/success/success.jsp").forward(request, response);
            } else {
                request.getRequestDispatcher("WEB-INF/success/success2.jsp").forward(request, response);

            }
        }


    }

    //去添加新生成绩页面
    protected void toAddGrade(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("WEB-INF/jsp/teacher/addGrade.jsp").forward(request, response);

    }

    //删除成绩
    protected void deleteGrade(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        //获取页码，用于返回该页码的查询列表
        String pageNum = request.getParameter("pageNum");
        request.setAttribute("pageNum", pageNum);

        //获取要删除学生的id
        String gid = request.getParameter("gid");
        if (gid.equals("undefined") || gid.isEmpty()) {
            request.setAttribute("operate", "您要删除成绩的学生还没有成绩哦！");
            request.getRequestDispatcher("WEB-INF/error/error.jsp").forward(request, response);
        }
        //调用dao中的方法
        int i = teacherDao.delete(gid);
        request.setAttribute("operate", "删除");
        if (i > 0) {
            //获取当前用户的信息,用来查找当前教师的学生和成绩
            HttpSession session = request.getSession();
            Admin admin = (Admin) session.getAttribute("admin");
            Integer rid = admin.getRid();
            if (rid == 2) {
                request.getRequestDispatcher("WEB-INF/success/success.jsp").forward(request, response);
            } else {
                request.getRequestDispatcher("WEB-INF/success/success2.jsp").forward(request, response);

            }
        }

    }


}

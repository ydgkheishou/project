package com.ydgk.servlet;

import com.ydgk.dao.StudentDao;
import com.ydgk.dao.TeacherDao;
import com.ydgk.dao.impl.StudentDaoImpl;
import com.ydgk.dao.impl.TeacherDaoImpl;
import com.ydgk.entity.Admin;
import com.ydgk.entity.Course;
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
 * @create 2019-12-15 8:52
 */
@WebServlet("/student.action")
public class StudentServlet extends HttpServlet {

    TeacherDao teacherDao = new TeacherDaoImpl();

    StudentDao studentDao = new StudentDaoImpl();

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

    //登录跳转到学生页面
    protected void login(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("WEB-INF/jsp/student/student.jsp").forward(request, response);
    }

    //对学生用户的分数进行查询
    protected void queryGradeByPage(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        //获取前台页面传过来的页号参数
        //获取需要查询的字段
        HttpSession session = request.getSession();
        Admin admin = (Admin) session.getAttribute("admin");
        String username = admin.getUsername();
        // String gorder = "1";
        String gorder = request.getParameter("gorder");
        //System.out.println(order);
        /*if (order != null && order != "") {
            gorder = order;
        }*/
        //将name和gorder保存到request域中，用于回显查询的参数
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
        List<Grade> list = studentDao.gradeQueryList(pb, username, gorder);

        //获取总记录数
        int totalCount = studentDao.gradeQueryCount(username, gorder);
        //封装当前页数据的集合和总记录数
        pb.setList(list);
        pb.setTotalCount(totalCount);
        //把pageBean对象保存到作用域对象中
        request.setAttribute("pb", pb);
        //请求转发跳转到列表页面
        request.getRequestDispatcher("WEB-INF/jsp/student/gradeList.jsp").forward(request, response);
    }

    //跳转到选课页面
    protected void toChoose(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        //获取当前用户的信息
        HttpSession session = request.getSession();
        Admin admin = (Admin) session.getAttribute("admin");
        Integer userid = admin.getUserid();

        //获取前台传入过来的页面
        String pageStr = request.getParameter("pageNum");
        request.setAttribute("pageNum", pageStr);
        //保存页号的变量
        int pageNum = 1;
        if (pageStr != null&&!pageStr.isEmpty()) {
            pageNum = Integer.parseInt(pageStr);
        }
        //封装一个PageBean对象
        PageBean<Course> pb = new PageBean<>();
        //封装每页条数和页号
        pb.setPageNum(pageNum);
        pb.setPageSize(3);
        //调用Dao方法
        //获取当前页的数据集合
        List<Course> list = studentDao.queryCourseList(pb);
        //获取总记录数
        int totalCount = studentDao.queryCourseCount();
        //封装当前页数据的集合和总记录数
        pb.setList(list);
        pb.setTotalCount(totalCount);
        //把pageBean对象保存到作用域对象中
        request.setAttribute("pb", pb);
        //请求转发跳转到列表页面

        request.getRequestDispatcher("WEB-INF/jsp/student/courseList.jsp").forward(request, response);
    }

    //学生进行选课
    protected void choose(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        //获取前台传入过来的页面
        String pageStr = request.getParameter("pageNum");
        request.setAttribute("pageNum", pageStr);

        //获取当前用户的信息
        HttpSession session = request.getSession();
        Admin admin = (Admin) session.getAttribute("admin");
        Integer userid = admin.getUserid();

        //获取所选课程的一个或多个id，也就是数组
        String cid[] = request.getParameterValues("cid");

       /* System.out.println(Arrays.toString(cid));
        for(String pre:cid){
            System.out.println(pre);    //下面的实例有将取到的数据组合，这个没有
        }*/

        int i = studentDao.insert(cid, userid);

        if (i > 0) {
            request.setAttribute("result","选课成功！");
            request.getRequestDispatcher("WEB-INF/success/courseSuccess.jsp").forward(request, response);
        }else{
            request.setAttribute("result","选课失败！您没有选中的课程或您选的课可能已经存在");
            request.getRequestDispatcher("WEB-INF/success/courseSuccess.jsp").forward(request, response);
        }

    }

    //对选课进行查询
    protected void queryOptionCourse(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        //获取当前用户的信息
        HttpSession session = request.getSession();
        Admin admin = (Admin) session.getAttribute("admin");
        Integer userid = admin.getUserid();

        //获取前台传入过来的页面
        String pageStr = request.getParameter("pageNum");
        //保存页号的变量
        int pageNum = 1;
        if (pageStr != null) {
            pageNum = Integer.parseInt(pageStr);
        }
        //封装一个PageBean对象
        PageBean<Course> pb = new PageBean<>();
        //封装每页条数和页号
        pb.setPageNum(pageNum);
        pb.setPageSize(3);
        //调用Dao方法
        //获取当前页的数据集合
        List<Course> list = studentDao.queryOptionCourseList(pb,userid);
        //获取总记录数
        int totalCount = studentDao.queryOptionCourseCount(userid);
        //封装当前页数据的集合和总记录数
        pb.setList(list);
        pb.setTotalCount(totalCount);
        //把pageBean对象保存到作用域对象中
        request.setAttribute("pb", pb);
        //请求转发跳转到列表页面
        request.getRequestDispatcher("WEB-INF/jsp/student/optionCourseList.jsp").forward(request, response);

    }

    //删除选课
    protected void deleteOptionCourse(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        //获取页码，用于返回该页码的查询列表
        String pageNum=request.getParameter("pageNum");
        request.setAttribute("pageNum",pageNum);

        String cid=request.getParameter("cid");

        //调用studentDao中的方法
        int i=studentDao.deleteCourse(cid);
        if (i>0){
            request.getRequestDispatcher("student.action?method=queryOptionCourse&pageNum="+pageNum).forward(request, response);

        }
    }


}

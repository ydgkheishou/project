package com.ydgk.dao.impl;

import com.ydgk.dao.StudentDao;
import com.ydgk.entity.Admin;
import com.ydgk.entity.Course;
import com.ydgk.entity.Grade;
import com.ydgk.util.JdbcUtil;
import com.ydgk.util.PageBean;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

/**
 * @author asus
 * @create 2019-12-15 11:13
 */
public class StudentDaoImpl implements StudentDao {

    @Override
    public List<Grade> gradeQueryList(PageBean<Grade> pb, String name, String gorder) {
        List<Grade> list = new ArrayList<>();

        String sql = null;
        List<Map<String, Object>> mapList = null;
        if (gorder == null || gorder.isEmpty()) {
            sql = "select g.gid,g.chinese,g.math,g.english,g.sum,g.gorder,a.userid,a.username from grade g left join t_admin a on g.sid=a.userid  where rid=1 and username=?  limit ?,?";
            mapList = JdbcUtil.queryForRows(sql, name, (pb.getPageNum() - 1) * pb.getPageSize(), pb.getPageSize());
        } else {
            sql = "select g.gid,g.chinese,g.math,g.english,g.sum,g.gorder,a.userid,a.username from grade g left join t_admin a on g.sid=a.userid  where rid=1 and gorder=? and username=?  limit ?,?";
            mapList = JdbcUtil.queryForRows(sql, gorder, name, (pb.getPageNum() - 1) * pb.getPageSize(), pb.getPageSize());
        }
        for (Map<String, Object> map : mapList) {
            //创建一个Grade对象
            Grade grade = new Grade();
            //获取map中的每列数据，封装到grade对象中
           /* 而valueOf()返回的是包装类Integer  Integer是可以使用对象方法的  而int类型就不能和Object类型进行互相转换

            Integer.parseInt(chuan)返回值是int型的.
            Integer.valueOf(chuan)返回值是Integer型的.把Integer赋值给int型的话,JRE会自己完成这些工作.*/
            if (map.get("gid") != null) {
                grade.setGid(Integer.valueOf(map.get("gid").toString()));
                grade.setChinese(Integer.valueOf(map.get("chinese").toString()));
                grade.setMath(Integer.valueOf(map.get("math").toString()));
                grade.setEnglish(Integer.valueOf(map.get("english").toString()));
                grade.setSum(Integer.valueOf(map.get("sum").toString()));
                grade.setGorder(Integer.valueOf(map.get("gorder").toString()));
            }

            Admin admin = new Admin();
            admin.setUserid(Integer.valueOf(map.get("userid").toString()));
            admin.setUsername(map.get("username").toString());
            grade.setAdmin(admin);
            list.add(grade);

        }
        return list;
    }

    @Override
    public int gradeQueryCount(String name, String gorder) {
        int i = 0;

        String sql = null;
        long count = 0;
        if (gorder == null || gorder.isEmpty()) {
            sql = "select count(*) from grade g right join t_admin a on g.sid=a.userid  where rid=1 and username=?";
            count = JdbcUtil.queryForRow(Long.class, sql, name);
        } else {
            sql = "select count(*) from grade g left join t_admin a on g.sid=a.userid  where rid=1 and gorder=? and username=?";
            count = JdbcUtil.queryForRow(Long.class, sql, gorder, name);
        }

        i = (int) count;
        return i;

    }

    @Override
    public List<Course> queryCourseList(PageBean<Course> pb) {
        List<Course> list = new ArrayList<>();
        String sql = "select c.cid,c.coursename,c.courseclass,a.userid,a.username from course c inner join t_admin a on  c.tid=a.userid limit ?,?";
        List<Map<String, Object>> mapList = JdbcUtil.queryForRows(sql, (pb.getPageNum() - 1) * pb.getPageSize(), pb.getPageSize());
        for (Map<String, Object> map : mapList) {
            //创建一个Course
            Course course = new Course();
            course.setCid(Integer.valueOf(map.get("cid").toString()));
            course.setCoursename(map.get("coursename").toString());
            course.setCourseclass(map.get("courseclass").toString());

            //创建一个admin对象
            Admin admin = new Admin();
            admin.setUserid(Integer.valueOf(map.get("userid").toString()));
            admin.setUsername(map.get("username").toString());

            course.setAdmin(admin);
            list.add(course);
        }

        return list;
    }

    @Override
    public int queryCourseCount() {
        int i = 0;
        long count = 0;
        String sql = "select count(*) from course";
        count = JdbcUtil.queryForRow(Long.class, sql);
        i = (int) count;
        return i;
    }

    @Override
    public int insert(String[] cid, Integer userid) {
        int i = 0;
        String sql = null;
        String sql2 = null;
        List<Map<String, Object>> mapList = null;

        if (cid != null) {
            //遍历所选课程的id数组
            for (String pre : cid) {
                //根据当前所选课程id和当前学生id进行查询
                sql2 = "select * from center where sid=? and cid=?";
                mapList = JdbcUtil.queryForRows(sql2, userid, pre);
                if (mapList.isEmpty()) {
                    //当学生还没进行选这门课时，给他添加上这门课
                    sql = "insert into center(cid,sid) values(?,?)";
                    i = JdbcUtil.executeUpdate(sql, pre, userid);

                }
            }
        }

        return i;
    }

    @Override
    public List<Course> queryOptionCourseList(PageBean<Course> pb, Integer userid) {
        List<Course> list = new ArrayList<>();
        String sql = "select c.cid,c.coursename,c.courseclass,t.userid,t.username from course c inner join center ct inner join t_admin t on  " +
                " ct.cid=c.cid and c.tid=t.userid  where ct.sid=? limit ?,?";
        List<Map<String, Object>> mapList = JdbcUtil.queryForRows(sql, userid,(pb.getPageNum() - 1) * pb.getPageSize(), pb.getPageSize());
        for (Map<String, Object> map : mapList) {
            //创建一个Course
            Course course = new Course();
            course.setCid(Integer.valueOf(map.get("cid").toString()));
            course.setCoursename(map.get("coursename").toString());
            course.setCourseclass(map.get("courseclass").toString());

            //创建一个admin对象
            Admin admin = new Admin();
            admin.setUserid(Integer.valueOf(map.get("userid").toString()));
            admin.setUsername(map.get("username").toString());

            course.setAdmin(admin);
            list.add(course);
        }
        return list;
    }


    @Override
    public int queryOptionCourseCount(Integer userid) {
        int i=0;
        long count=0;
        String sql="select count(*) from course c inner join center ct inner join t_admin t on   ct.cid=c.cid and c.tid=t.userid  where ct.sid=? ";
        count=JdbcUtil.queryForRow(Long.class,sql,userid);
        i=(int)count;
        return i;
    }

    @Override
    public int deleteCourse(String cid) {
        int i=0;
        String sql="delete from center where cid=?";
        i=JdbcUtil.executeUpdate(sql,cid);
        return i;
    }
}

       /* for (String pre : cid) {
            if (mapList.isEmpty()) {
                sql = "insert into center(cid,sid) values(?,?)";
                i = JdbcUtil.executeUpdate(sql, pre, userid);
            } else {
                for (Map<String, Object> map : mapList) {
                    //Center center=new Center();
                    if (pre.equals(map.get("cid").toString())) {

                        continue;
                    }

                }

                continue;
            }
        }
        return i;
    }*/


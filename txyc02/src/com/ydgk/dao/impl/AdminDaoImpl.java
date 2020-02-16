package com.ydgk.dao.impl;

import com.ydgk.dao.AdminDao;
import com.ydgk.entity.Admin;
import com.ydgk.entity.Grade;
import com.ydgk.entity.Infomation;
import com.ydgk.util.JdbcUtil;
import com.ydgk.util.PageBean;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

/**
 * @author asus
 * @create 2019-08-08 19:26
 */
public class AdminDaoImpl implements AdminDao {
    @Override
    public Admin queryByNameAndPwd(String username, String userpwd, String roleid) {
        Admin admin = null;
        String sql = "select * from t_admin where username=? and userpwd=? and rid=?";
        Map<String, Object> map = JdbcUtil.queryForRow(sql, username, userpwd, roleid);
        if (map != null) {
            admin = new Admin();
            admin.setUserid(Integer.valueOf(map.get("userid").toString()));
            admin.setUsername(map.get("username").toString());
            admin.setUserpwd(map.get("userpwd").toString());
            admin.setRid(Integer.valueOf(map.get("rid").toString()));
        }
        return admin;
    }

    @Override
    public int insert(Admin admin) {
        int i = 0;
        String sql = "insert into t_admin(username,userpwd,problem,answer,rid) values(?,?,?,?,?)";
        i = JdbcUtil.executeUpdate(sql, admin.getUsername(), admin.getUserpwd(), admin.getProblem(), admin.getAnswer(), admin.getRid());
        return i;
    }

    @Override
    public List<Admin> queryList(PageBean<Admin> pb, String name, String roleid) {
        List<Admin> list = new ArrayList<>();
        String sql = "select userid,username,userpwd from t_admin  where username like ? and rid=? limit ?,?";
        if (name == null) {
            name = "%";
        }
        String s = "%" + name + "%";
        List<Map<String, Object>> mapList = JdbcUtil.queryForRows(sql, s, roleid, (pb.getPageNum() - 1) * pb.getPageSize(), pb.getPageSize());
        for (Map<String, Object> map : mapList) {
            //创建一个Admin对象
            Admin admin = new Admin();
            //获取Map中的每列的数据，封装到admin对象中
            admin.setUserid(Integer.valueOf(map.get("userid").toString()));
            admin.setUsername(map.get("username").toString());
            admin.setUserpwd(map.get("userpwd").toString());
            //添加到集合中
            list.add(admin);
        }
        return list;
    }

    @Override
    public int queryCount(String name, String roleid) {
        int i = 0;
        if (name == null) {
            name = "%";
        }
        String s = "%" + name + "%";
        String sql = "select count(*) from t_admin where rid=? and username like ?";
        long count = JdbcUtil.queryForRow(Long.class, sql, roleid, s);
        i = (int) count;
        return i;
    }

    @Override
    public int deleteAdminById(String id) {
        int i = 0;
        String sql = "delete from t_admin where userid=?";
        i = JdbcUtil.executeUpdate(sql, id);
        return i;
    }

    @Override
    public Admin queryAdmin(String id) {
        Admin admin = null;
        String sql = "select userid,username,userpwd from t_admin where userid=?";
        Map<String, Object> map = JdbcUtil.queryForRow(sql, id);
        if (map != null) {
            admin = new Admin();
            //获取Map中每列的数据,封装到hotel对象中
            admin.setUserid(Integer.valueOf(map.get("userid").toString()));
            admin.setUsername(map.get("username").toString());
            admin.setUserpwd(map.get("userpwd").toString());
        }
        return admin;
    }

    @Override
    public int update(String id, String userpwd) {
        int i = 0;
        String sql = "update t_admin set userpwd=? where userid=? ";
        i = JdbcUtil.executeUpdate(sql, userpwd, id);
        return i;
    }

    @Override
    public int init(String userid) {
        int i = 0;
        String sql = "update t_admin set userpwd=888888 where userid=?";
        i = JdbcUtil.executeUpdate(sql, userid);
        return i;
    }


    @Override
    public List<Grade> gradeQueryList(PageBean<Grade> pb, String name, String gorder) {
        List<Grade> list = new ArrayList<>();
        if (name == null) {
            name = "%";
        }
        String s = "%" + name + "%";
        String sql = null;
        List<Map<String, Object>> mapList = null;
        if (gorder == null || gorder.isEmpty()) {
            sql = "select g.gid,g.chinese,g.math,g.english,g.sum,g.gorder,a.userid,a.username from grade g right join t_admin a on g.sid=a.userid  where rid=1 and username like ?  limit ?,?";
            mapList = JdbcUtil.queryForRows(sql, s, (pb.getPageNum() - 1) * pb.getPageSize(), pb.getPageSize());
        } else {
            sql = "select g.gid,g.chinese,g.math,g.english,g.sum,g.gorder,a.userid,a.username from grade g left join t_admin a on g.sid=a.userid  where rid=1 and gorder=? and username like ?  limit ?,?";
            mapList = JdbcUtil.queryForRows(sql, gorder, s, (pb.getPageNum() - 1) * pb.getPageSize(), pb.getPageSize());
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
        if (name == null) {
            name = "%";
        }
        String s = "%" + name + "%";
        String sql = null;
        long count = 0;
        if (gorder == null || gorder.isEmpty()) {
            sql = "select count(*) from grade g right join t_admin a on g.sid=a.userid  where rid=1 and username like ?";
            count = JdbcUtil.queryForRow(Long.class, sql, s);
        } else {
            sql = "select count(*) from grade g left join t_admin a on g.sid=a.userid  where rid=1 and gorder=? and username like ?";
            count = JdbcUtil.queryForRow(Long.class, sql, gorder, s);
        }

        i = (int) count;
        return i;

    }

    @Override
    public Admin queryAdminByName(String username) {
        Admin admin = null;
        String sql = "select userid,username,problem from t_admin where username= ?";
        Map<String, Object> map = JdbcUtil.queryForRow(sql, username);
        if (map != null) {
            admin = new Admin();
            //获取Map中每列的数据,封装到hotel对象中
            admin.setUserid(Integer.valueOf(map.get("userid").toString()));
            admin.setUsername(map.get("username").toString());
            admin.setProblem(map.get("problem").toString());
        }

        return admin;
    }

    @Override
    public Admin queryAdminByAnswer(String username, String answer) {
        Admin admin = null;
        String sql = "select userid,username,problem,userpwd,answer from t_admin where username= ? and answer=?";
        Map<String, Object> map = JdbcUtil.queryForRow(sql, username, answer);
        if (map != null) {
            admin = new Admin();
            //获取Map中每列的数据,封装到hotel对象中
            admin.setUserid(Integer.valueOf(map.get("userid").toString()));
            admin.setUsername(map.get("username").toString());
            admin.setProblem(map.get("problem").toString());
            admin.setUserpwd(map.get("userpwd").toString());
            admin.setAnswer(map.get("answer").toString());
        }

        return admin;
    }

    @Override
    public int updateAdminPwd(String username, String userpwd, String problem, String answer) {
        int i = 0;
        String sql = "update t_admin set userpwd=?,problem=?,answer=? where username= ?";
        i = JdbcUtil.executeUpdate(sql, userpwd, problem, answer, username);

        return i;
    }

    @Override
    public List<Infomation> getInfomationList() {
        List<Infomation> list = new ArrayList<>();
        String sql = "select nid,text,time from infomation";
        List<Map<String, Object>> mapList = JdbcUtil.queryForRows(sql);
        for (Map<String, Object> map : mapList) {
            Infomation infomation = new Infomation();
            infomation.setNid(Integer.valueOf(map.get("nid").toString()));
            infomation.setText(map.get("text").toString());
            //日期格式化对象
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            try {
                Date time = sdf.parse(map.get("time").toString());
                infomation.setTime(time);
            } catch (ParseException e) {
                e.printStackTrace();
            }
            list.add(infomation);
        }
        return list;
    }

    @Override
    public int insertInfomation(String text) {
        int i = 0;
        String sql = "insert into infomation(text,time) values(?,?)";
        i = JdbcUtil.executeUpdate(sql, text, new Date());
        return i;
    }

    @Override
    public int deleteInfomationById(String nid) {
        int i = 0;
        String sql = "delete from infomation where nid=?";
        i = JdbcUtil.executeUpdate(sql, nid);
        return i;
    }

    @Override
    public List<Admin> queryTeacherList() {
        List<Admin> list = new ArrayList<>();
        String sql = "select userid,username from t_admin where rid=2";
        List<Map<String, Object>> mapList = JdbcUtil.queryForRows(sql);
        for (Map<String, Object> map : mapList) {
            Admin admin = new Admin();
            admin.setUserid(Integer.valueOf(map.get("userid").toString()));
            admin.setUsername(map.get("username").toString());
            list.add(admin);
        }

        return list;
    }

    @Override
    public int insertCourse(String coursename, String courseclass, String tid) {
        int i = 0;
        String sql = "insert into course(coursename,courseclass,tid) values(?,?,?) ";
        i = JdbcUtil.executeUpdate(sql, coursename, courseclass, tid);
        return i;
    }

}

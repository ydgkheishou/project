package com.ydgk.dao.impl;

import com.ydgk.dao.TeacherDao;
import com.ydgk.entity.Admin;
import com.ydgk.entity.Grade;
import com.ydgk.util.JdbcUtil;
import com.ydgk.util.PageBean;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

/**
 * @author asus
 * @create 2019-12-13 8:50
 */
public class TeacherDaoImpl implements TeacherDao {

    //教师页面操作方法
    @Override
    public List<Admin> studentQueryList(PageBean<Admin> pb, String name,Integer userid) {
        List<Admin> list = new ArrayList<>();
        String sql = "select s.userid,s.username,s.userpwd from  t_admin s   inner join  center ct  inner join  course c " +
                " on c.cid=ct.cid  and ct.sid=s.userid   where c.tid=? and s.username like ?  limit ?,?";
        if (name == null) {
            name = "%";
        }
        String s = "%" + name + "%";
        List<Map<String, Object>> mapList = JdbcUtil.queryForRows(sql, userid, s, (pb.getPageNum() - 1) * pb.getPageSize(), pb.getPageSize());
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
    public int studentQueryCount(String name,Integer userid) {
        int i = 0;
        if (name == null) {
            name = "%";
        }
        String s = "%" + name + "%";
        String sql =  " select count(*) from  t_admin s   inner join  center ct  inner join  course c " +
                " on c.cid=ct.cid  and ct.sid=s.userid   where c.tid=? and s.username like ?";
        long count = JdbcUtil.queryForRow(Long.class, sql,userid,s);
        i = (int) count;
        return i;
    }

    @Override
    public List<Grade> gradeQueryList(PageBean<Grade> pb, String name,String gorder,Integer userid) {
        List<Grade> list = new ArrayList<>();
        if (name == null) {
            name = "%";
        }
        String s = "%" + name + "%";
        String sql=null;
        List<Map<String, Object>> mapList =null;
      /*  if (gorder==null||gorder.isEmpty()){
            sql = "select s.userid,s.username,s.userpwd,g.gorder,g.gid,g.chinese,g.math,g.english,g.sum from  t_admin s   inner join  center ct  inner join  course c " +
                    " inner join grade g on c.cid=ct.cid  and ct.sid=s.userid  and s.userid=g.sid   where c.tid=? and s.username like ?  limit ?,?";
            mapList = JdbcUtil.queryForRows(sql, userid,s, (pb.getPageNum() - 1) * pb.getPageSize(), pb.getPageSize());
        }else {
            sql = "select s.userid,s.username,s.userpwd,g.gorder,g.gid,g.chinese,g.math,g.english,g.sum from  t_admin s   inner join  center ct  inner join  course c " +
                    " inner join grade g on c.cid=ct.cid  and ct.sid=s.userid  and s.userid=g.sid   where c.tid=? and g.gorder=? and s.username like ?  limit ?,?";
            mapList = JdbcUtil.queryForRows(sql,userid,gorder, s, (pb.getPageNum() - 1) * pb.getPageSize(), pb.getPageSize());
        }*/
        if (gorder==null||gorder.isEmpty()){
            sql = "select l.userid,l.username,l.userpwd,l.gorder,l.gid,l.chinese,l.math,l.english,l.sum from  course c  inner join  center ct inner join (select * from grade g right join t_admin s  on s.userid=g.sid where  s.rid=1 ) l " +
                    " on c.cid=ct.cid and ct.sid= l.userid   where c.tid=? and l.username like ?  limit ?,?";
            mapList = JdbcUtil.queryForRows(sql, userid,s, (pb.getPageNum() - 1) * pb.getPageSize(), pb.getPageSize());
        }else {
            sql = "select l.userid,l.username,l.userpwd,l.gorder,l.gid,l.chinese,l.math,l.english,l.sum from  course c  inner join  center ct inner join (select * from grade g right join t_admin s  on s.userid=g.sid where  s.rid=1 ) l " +
                    " on c.cid=ct.cid and ct.sid= l.userid   where c.tid=? and l.gorder=? and l.username like ?  limit ?,?";
            mapList = JdbcUtil.queryForRows(sql,userid,gorder, s, (pb.getPageNum() - 1) * pb.getPageSize(), pb.getPageSize());
        }
        for (Map<String, Object> map : mapList) {
            //创建一个Grade对象
            Grade grade = new Grade();
            //获取map中的每列数据，封装到grade对象中
           /* 而valueOf()返回的是包装类Integer  Integer是可以使用对象方法的  而int类型就不能和Object类型进行互相转换

            Integer.parseInt(chuan)返回值是int型的.
            Integer.valueOf(chuan)返回值是Integer型的.把Integer赋值给int型的话,JRE会自己完成这些工作.*/
            if(map.get("gid")!=null){
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
            admin.setUserpwd(map.get("userpwd").toString());
            grade.setAdmin(admin);
            list.add(grade);

        }
        return list;
    }

    @Override
    public int gradeQueryCount(String name,String gorder,Integer userid) {
        int i = 0;
        if (name == null) {
            name = "%";
        }
        String s = "%" + name + "%";
        String sql=null;
        long count=0;
        /*if (gorder==null||gorder.isEmpty()){
            sql = " select count(*) from  t_admin s   inner join  center ct  inner join  course c " +
                    " inner join grade g on c.cid=ct.cid  and ct.sid=s.userid  and s.userid=g.sid   where c.tid=? and s.username like ?";
            count = JdbcUtil.queryForRow(Long.class,sql,userid,s);
        }else {
            sql = "select count(*) from  t_admin s   inner join  center ct  inner join  course c " +
                    "inner join grade g on c.cid=ct.cid  and ct.sid=s.userid  and s.userid=g.sid   where c.tid=? and gorder=? and username like ?";
            count = JdbcUtil.queryForRow(Long.class,sql,userid,gorder,s);
        }*/
        if (gorder==null||gorder.isEmpty()){
            sql = " select count(*) from  course c  inner join  center ct inner join (select * from grade g right join t_admin s  on s.userid=g.sid where  s.rid=1 ) l " +
                    " on c.cid=ct.cid and ct.sid= l.userid   where c.tid=? and l.username like ? ";
            count = JdbcUtil.queryForRow(Long.class,sql,userid,s);
        }else {
            sql =  "select count(*) from  course c  inner join  center ct inner join (select * from grade g right join t_admin s  on s.userid=g.sid where  s.rid=1 ) l " +
                    " on c.cid=ct.cid and ct.sid= l.userid   where c.tid=? and l.gorder=? and l.username like ? ";
            count = JdbcUtil.queryForRow(Long.class,sql,userid,gorder,s);
        }

        i = (int) count;
        return i;

    }

    @Override
    public Grade queryGrade(String userid,String gid) {
        Grade grade = null;
        String sql=null;
        Map<String, Object> map =null;
        if (gid==null||gid.isEmpty()||gid.equals("undefined")){
             sql = "select g.gid,g.chinese,g.math,g.english,g.sum,g.gordera.userid,a.username from grade g right join t_admin a on g.sid=a.userid  where userid=?";
             map = JdbcUtil.queryForRow(sql, userid);
        }else {
            sql = "select g.gid,g.chinese,g.math,g.english,g.sum,g.gorder,a.userid,a.username from grade g right join t_admin a on g.sid=a.userid  where userid=? and gid=?";
            map = JdbcUtil.queryForRow(sql, userid,gid);
        }
        if (map != null) {
            grade = new Grade();
            if (map.get("gid")!=null){
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

        }
        return grade;
    }

    @Override
    public int update(String gid, String chinese, String math, String english,String userid) {
        String sql=null;
        int a=0;
        String sum=null;
        int i=0;
        //当学生成绩不存在时，添加学生成绩
        if (gid==null||gid.isEmpty()){
             sql = "insert into grade(chinese,math,english,sum,gorder,sid) VALUES(?,?,?,?,?,?)";
             a=Integer.parseInt(chinese)+Integer.parseInt(math)+Integer.parseInt(english);
             sum=String.valueOf(a);
             i = JdbcUtil.executeUpdate(sql, chinese, math, english, sum,1,userid);
        }else {
            //成绩存在时，则进行修改
            sql = "update grade set chinese=?,math=?,english=?,sum=? where gid=?";
            a=Integer.parseInt(chinese)+Integer.parseInt(math)+Integer.parseInt(english);
            sum=String.valueOf(a);

            i = JdbcUtil.executeUpdate(sql, chinese, math, english, sum, gid);
        }

        return i;
    }

    @Override
    public int insert(Grade grade) {
        int i = 0;
        String sql = "insert into grade(chinese,math,english,sum,gorder,sid) VALUES(?,?,?,?,?,?)";
        Integer sum=grade.getChinese()+ grade.getMath()+grade.getEnglish();
        i = JdbcUtil.executeUpdate(sql, grade.getChinese(), grade.getMath(), grade.getEnglish(),sum, grade.getGorder(), grade.getSid());
        return i;
    }

    @Override
    public int delete(String gid) {
        int i=0;
        String sql="delete from grade where gid=?";
        i=JdbcUtil.executeUpdate(sql,gid);
        return i;
    }

   /* @Override
    public List<Grade> gradeQueryListAll(PageBean<Grade> pb, String name) {
        List<Grade> list = new ArrayList<>();
        if (name == null) {
            name = "%";
        }
        String s = "%" + name + "%";
        String sql=null;
        List<Map<String, Object>> mapList =null;
        sql = "select g.gid,g.chinese,g.math,g.english,g.sum,g.gorder,a.userid,a.username from grade g right join t_admin a on g.sid=a.userid  where rid=1 and username like ?  limit ?,?";
        mapList = JdbcUtil.queryForRows(sql, s, (pb.getPageNum() - 1) * pb.getPageSize(), pb.getPageSize());
        for (Map<String, Object> map : mapList) {
            //创建一个Grade对象
            Grade grade = new Grade();
            //获取map中的每列数据，封装到grade对象中
           *//* 而valueOf()返回的是包装类Integer  Integer是可以使用对象方法的  而int类型就不能和Object类型进行互相转换

            Integer.parseInt(chuan)返回值是int型的.
            Integer.valueOf(chuan)返回值是Integer型的.把Integer赋值给int型的话,JRE会自己完成这些工作.*//*
            System.out.println(map.get("chinese").toString());
            grade.setGid(Integer.valueOf(map.get("gid").toString()));
            grade.setChinese(Integer.valueOf(map.get("chinese").toString()));
            grade.setMath(Integer.valueOf(map.get("math").toString()));
            grade.setEnglish(Integer.valueOf(map.get("english").toString()));
            grade.setSum(Integer.valueOf(map.get("sum").toString()));
            grade.setGorder(Integer.valueOf(map.get("gorder").toString()));

            Admin admin = new Admin();
            admin.setUserid(Integer.valueOf(map.get("userid").toString()));
            admin.setUsername(map.get("username").toString());
            grade.setAdmin(admin);
            list.add(grade);

        }
        return list;
    }*/

}

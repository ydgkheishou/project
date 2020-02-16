package com.ydgk.entity;

/**
 * @author asus
 * @create 2019-12-12 17:07
 */
public class Grade {
private Integer gid;
private Integer chinese;
private Integer math;
private Integer english;
private Integer sum;
private Integer sid;
private Integer gorder;
private Admin  admin;

    @Override
    public String toString() {
        return "Grade{" +
                "gid=" + gid +
                ", chinese=" + chinese +
                ", math=" + math +
                ", english=" + english +
                ", sum=" + sum +
                ", sid=" + sid +
                ", gorder=" + gorder +
                ", admin=" + admin +
                '}';
    }

    public Integer getGorder() {
        return gorder;
    }

    public void setGorder(Integer gorder) {
        this.gorder = gorder;
    }

    public Integer getGid() {
        return gid;
    }

    public void setGid(Integer gid) {
        this.gid = gid;
    }

    public Integer getChinese() {
        return chinese;
    }

    public void setChinese(Integer chinese) {
        this.chinese = chinese;
    }

    public Integer getMath() {
        return math;
    }

    public void setMath(Integer math) {
        this.math = math;
    }

    public Integer getEnglish() {
        return english;
    }

    public void setEnglish(Integer english) {
        this.english = english;
    }

    public Integer getSum() {
        return sum;
    }

    public void setSum(Integer sum) {
        this.sum = sum;
    }

    public Integer getSid() {
        return sid;
    }

    public void setSid(Integer sid) {
        this.sid = sid;
    }

    public Admin getAdmin() {
        return admin;
    }

    public void setAdmin(Admin admin) {
        this.admin = admin;
    }
}

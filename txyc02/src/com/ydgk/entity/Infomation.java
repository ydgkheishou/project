package com.ydgk.entity;

import java.util.Date;

/**
 * @author asus
 * @create 2019-12-21 19:54
 */
public class Infomation {
    private Integer nid;
    private String text;
    private Date time;

    public Date getTime() {
        return time;
    }

    public void setTime(Date time) {
        this.time = time;
    }

    public Integer getNid() {
        return nid;
    }

    public void setNid(Integer nid) {
        this.nid = nid;
    }

    public String getText() {
        return text;
    }

    public void setText(String text) {
        this.text = text;
    }
}

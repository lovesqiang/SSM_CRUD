package com.qiang.pojo;

import java.util.HashMap;
import java.util.Map;

//通用返回类
public class Msg {

    //状态码：100表示失败，200表示成功
    private Integer code;

    //处理结果后的消息
    private String msg;

    //用户返回给浏览器的数据【可用于链式操作】
    private Map<String,Object> data = new HashMap<>();

    public static Msg success(){
        Msg msg = new Msg();
        msg.setCode(200);
        msg.setMsg("处理成功");
        return msg;
    }

    public static Msg fail(){
        Msg msg = new Msg();
        msg.setCode(100);
        msg.setMsg("处理失败");
        return msg;
    }

    public Msg add(String key,Object value){
        this.getData().put(key,value);
        return this;
    }

    public Integer getCode() {
        return code;
    }

    public void setCode(Integer code) {
        this.code = code;
    }

    public String getMsg() {
        return msg;
    }

    public void setMsg(String msg) {
        this.msg = msg;
    }

    public Map<String, Object> getData() {
        return data;
    }

    public void setData(Map<String, Object> data) {
        this.data = data;
    }
}

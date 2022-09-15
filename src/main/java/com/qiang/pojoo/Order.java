package com.qiang.pojoo;

import java.util.Date;

public class Order {
    private Integer orderId;

    private String orderNumber;

    private Integer orderUserId;

    private String orderTotal;

    private Date orderTime;

    private Integer orderStatus;

    private Integer orderIsdelete;

    public Integer getOrderId() {
        return orderId;
    }

    public void setOrderId(Integer orderId) {
        this.orderId = orderId;
    }

    public String getOrderNumber() {
        return orderNumber;
    }

    public void setOrderNumber(String orderNumber) {
        this.orderNumber = orderNumber == null ? null : orderNumber.trim();
    }

    public Integer getOrderUserId() {
        return orderUserId;
    }

    public void setOrderUserId(Integer orderUserId) {
        this.orderUserId = orderUserId;
    }

    public String getOrderTotal() {
        return orderTotal;
    }

    public void setOrderTotal(String orderTotal) {
        this.orderTotal = orderTotal == null ? null : orderTotal.trim();
    }

    public Date getOrderTime() {
        return orderTime;
    }

    public void setOrderTime(Date orderTime) {
        this.orderTime = orderTime;
    }

    public Integer getOrderStatus() {
        return orderStatus;
    }

    public void setOrderStatus(Integer orderStatus) {
        this.orderStatus = orderStatus;
    }

    public Integer getOrderIsdelete() {
        return orderIsdelete;
    }

    public void setOrderIsdelete(Integer orderIsdelete) {
        this.orderIsdelete = orderIsdelete;
    }
}
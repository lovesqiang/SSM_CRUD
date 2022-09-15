package com.qiang.service;

import com.qiang.pojo.Employee;

import java.util.List;

public interface EmployeeService {
    List<Employee> findAllEmployee();

    void saveEmp(Employee employee);

    boolean checkName(String empName);

    Employee getEmp(Integer id);

    void updateEmp(Employee employee);

    //单个删除
    void deleteEmp(Integer id);

    //批量删除
    void deleteBatch(List<Integer> ids);
}

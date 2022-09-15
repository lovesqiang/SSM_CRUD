package com.qiang.service.Impl;

import com.qiang.mapper.DepartmentMapper;
import com.qiang.pojo.Department;
import com.qiang.service.DepartmentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class DepartmentServiceImpl implements DepartmentService {

    @Autowired
    private DepartmentMapper departmentMapper;

    @Override
    public List<Department> findAllDept() {
        return departmentMapper.selectByExample(null);  //没有查询条件，就写null
    }
}

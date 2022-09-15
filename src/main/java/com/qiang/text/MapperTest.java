package com.qiang.text;

import com.qiang.mapper.DepartmentMapper;
import com.qiang.mapper.EmployeeMapper;
import com.qiang.pojo.Employee;
import org.apache.ibatis.session.SqlSession;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.UUID;

//RunWith:用哪个单元测试来运行    ContextConfiguration：指定Spring配置文件的路径
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath:applicationContext_dao.xml","classpath:applicationContext_service.xml"})
public class MapperTest {

    @Autowired
    private DepartmentMapper departmentMapper;

    @Autowired
    private EmployeeMapper employeeMapper;

    @Autowired
    private SqlSession sqlSession;

    @Test
    public void testCRUD(){
        System.out.println(departmentMapper);

        //插入几个部门
//        Department dept3 = new Department();
//        dept3.setDeptId(3);
//        dept3.setDeptName("开发部");
//        departmentMapper.insertSelective(dept3);

        //生成员工信息，测试员工插入
        //employeeMapper.insertSelective(new Employee(1,"king","M","king@qiang.com",2));

        //批量插入多个员工,批量：可以执行批量操作的sqlSession
        EmployeeMapper mapper = sqlSession.getMapper(EmployeeMapper.class);
        for (int i = 0; i < 1000; i++) {
            String uid = UUID.randomUUID().toString().substring(0, 5)+i;
            mapper.insertSelective(new Employee(null,uid,"M",uid+"@qiang.com",2));
        }
        System.out.println("批量成功");
    }



}

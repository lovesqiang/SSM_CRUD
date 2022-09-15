package com.qiang.text;

import com.github.pagehelper.PageInfo;
import com.qiang.pojo.Employee;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mock.web.MockHttpServletRequest;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.MvcResult;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;

import java.util.List;

@RunWith(SpringJUnit4ClassRunner.class)     //使用Spring的单元测试
@WebAppConfiguration    //使IOC容器能够@Autowired容器自己
@ContextConfiguration(locations = {"classpath:applicationContext_dao.xml","classpath:applicationContext_service.xml","classpath:springmvc.xml"})
public class MvcTest {

    @Autowired
    private WebApplicationContext context;

    //虚拟mvc请求，获取处理结果
    private MockMvc mockMvc;

    @Before     //每次使用都要进行初始化   注意：导入的是import org.junit.Before;
    public void initMockMvc(){

        mockMvc = MockMvcBuilders.webAppContextSetup(context).build();
    }

    @Test
    public void testPage() throws Exception {
        //模拟请求拿到返回值
        MvcResult result = mockMvc.perform(MockMvcRequestBuilders.get("/emps").param("pn", "1")).andReturn();
        //请求成功后，请求域中会有pageInfo,我们可以取出pageInfo进行验证
        MockHttpServletRequest request = result.getRequest();
        PageInfo<Employee> info = (PageInfo<Employee>) request.getAttribute("pageInfo");
        System.out.println("当前页码"+info.getPageNum());
        System.out.println("总页数"+info.getPages());
        System.out.println("总记录数"+info.getTotal());
        System.out.println("在页面连续显示的页码");
        int[] nums = info.getNavigatepageNums();
        for (int num : nums) {
            System.out.print(" "+num);
        }
        System.out.println("获取员工数据");
        List<Employee> list = info.getList();
        for (Employee employee : list) {
            System.out.println("员工编号"+employee.getEmpId()+"---->员工姓名"+employee.getEmpName());
        }

    }
}

package com.qiang.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.qiang.pojo.Employee;
import com.qiang.pojo.Msg;
import com.qiang.service.EmployeeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import javax.validation.Valid;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class EmployeeController {

    @Autowired
    private EmployeeService employeeService;

    //@RequestMapping("/emps")
    public String getEmps(@RequestParam(value = "pn", defaultValue = "1") Integer pn, Model model) {

        //在查询之前需要调用,传入页码，以及每页显示几条数据
        PageHelper.startPage(pn, 5);
        //startPage后面紧跟的查询就是分页查询
        List<Employee> list = employeeService.findAllEmployee();
        //用PageInfo对结果的封装,传入连续显示的页数
        PageInfo<Employee> pageInfo = new PageInfo<Employee>(list, 5);

        //将info传递到页面
        model.addAttribute("pageInfo", pageInfo);

        return "list";
    }

    @RequestMapping("/emps")
    @ResponseBody
    public Msg getEmpsAjax(@RequestParam(value = "pn", defaultValue = "1") Integer pn) {
        //在查询之前需要调用,传入页码，以及每页显示几条数据
        PageHelper.startPage(pn, 5);
        //startPage后面紧跟的查询就是分页查询
        List<Employee> list = employeeService.findAllEmployee();
        //用PageInfo对结果的封装,传入连续显示的页数
        PageInfo<Employee> pageInfo = new PageInfo<Employee>(list, 5);
        return Msg.success().add("pageInfo", pageInfo);
    }

    //保存新增员工（使用REST风格）
    @RequestMapping(value = "/emp", method = RequestMethod.POST)
    @ResponseBody
    public Msg savEmp(@Valid Employee employee, BindingResult result) {
        if (result.hasErrors()) {
            Map<String, Object> map = new HashMap<>();
            List<FieldError> fieldErrors = result.getFieldErrors();
            for (FieldError fieldError : fieldErrors) {
                System.out.println("错误字段名" + fieldError.getField());
                System.out.println("错误字段信息" + fieldError.getDefaultMessage());
                map.put(fieldError.getField(), fieldError.getDefaultMessage());
            }
            return Msg.fail().add("errorFields", map);
        } else {
            employeeService.saveEmp(employee);
            return Msg.success();
        }
    }


    /**
    * @Description:  检验用户名是否重复
    * @param: empName
    * @return: com.qiang.pojo.Msg
    * @Author: yueqiang
    * @Date: 2021/10/20
    */
    @RequestMapping("/changeName")
    @ResponseBody
    public Msg changeName(@RequestParam("empName") String empName) {     //@RequestParam表示明确告诉SprinMvc在请求参数中取得的值

        //先判断用户名是否合法
        String regx = "(^[a-zA-Z0-9_-]{3,16}$)|(^[\\u2E80-\\u9FFF]{2,10})";
        if (!empName.matches(regx)) {
            return Msg.fail().add("va_msg", "用户名不合法");
        }

        //数据库用户名重复校验
        if (employeeService.checkName(empName)) {
            return Msg.success();
        } else {
            return Msg.fail().add("va_msg", "用户名不可用");
        }
    }


    /**
    * @Description:根据员工id查询员工信息
    * @param: id
    * @return: com.qiang.pojo.Msg
    * @Author: yueqiang
    * @Date: 2021/10/20
    */
    @RequestMapping(value = "/emp/{id}", method = RequestMethod.GET)
    @ResponseBody
    public Msg getEmp(@PathVariable("id") Integer id) {  //表示这个id是从路径中获取的
        Employee emp = employeeService.getEmp(id);
        return Msg.success().add("emp", emp);
    }

    /**
    * @Description: 更新员工信息
    * @param: employee
    * @return: com.qiang.pojo.Msg
    * @Author: yueqiang
    * @Date: 2021/10/20
    */
    @ResponseBody
    @RequestMapping(value = "/emp/{empId}", method = RequestMethod.PUT)  //empId封装在Employee中，所以empId不能写成id
    public Msg updateEmp(Employee employee) {
        employeeService.updateEmp(employee);
        return Msg.success();
    }


    /**
    * @Description: 单个删除和多个删除二合一
    * @param: ids：所有员工使用“-”拼接而成的字符串
    * @return: com.qiang.pojo.Msg
    * @Author: yueqiang
    * @Date: 2021/10/20
    */
    @ResponseBody
    @RequestMapping(value = "/emp/{ids}", method = RequestMethod.DELETE)
    public Msg deleteEmp(@PathVariable("ids") String ids) {  //@PathVariable : 可以将 URL 中占位符参数绑定到控制器处理方法的入参中：URL 中的 {xxx} 占位符可以通过@PathVariable(“xxx“) 绑定到操作方法的入参中;
        if (ids.contains("-")) {
            List<Integer> del_ids = new ArrayList<>();
            String[] str_ids = ids.split("-");
            //组装id的集合
            for (String str_id : str_ids) {
                del_ids.add(Integer.parseInt(str_id));
            }
            employeeService.deleteBatch(del_ids);
        } else {
            Integer id = Integer.parseInt(ids);
            employeeService.deleteEmp(id);
        }
        return Msg.success();
    }

}

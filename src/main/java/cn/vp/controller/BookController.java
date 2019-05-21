package cn.vp.controller;

import cn.vp.Service.BookService;
import cn.vp.Service.BookTypeService;
import cn.vp.bean.BookInfo;
import cn.vp.bean.BookType;
import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.context.ServletContextAware;
import org.springframework.web.multipart.commons.CommonsMultipartFile;

import javax.servlet.ServletContext;
import java.io.File;
import java.util.List;

@Controller
@SessionAttributes({"bookTypes", "bookInfos"})
public class BookController implements ServletContextAware {

    private ServletContext servletContext;

    @Autowired
    BookTypeService bookTypeService;

    @Autowired
    BookService bookService;

    /**
     * 跳转到首页
     * @param map 保存的数据类似于request
     * @return
     */
    @RequestMapping("/add.htm")
    public String getBookType(ModelMap map) {
        List<BookType> bookTypes = bookTypeService.queryAll();
        PageHelper.startPage(1, 3);
        List<BookInfo> bookInfos = bookService.queryAll();
        PageInfo<BookInfo> pageInfo = new PageInfo<BookInfo>(bookInfos);
        map.put("pageInfo", pageInfo);
        System.out.println(bookInfos);
        map.put("bookTypes", bookTypes);
        return "forward:/list.jsp";
    }


    @Override
    public void setServletContext(ServletContext servletContext) {
        this.servletContext = servletContext;
    }


    /**
     * 根据图书id删除图书   参数为数组是因为可以批量删除 也可以穿单个bookid
     * @param bookid 图书id
     * @return 跳转到查询
     */
    @RequestMapping(value = "/ajaxDelect.htm",produces={"application/json;","text/html;charset=UTF-8;"})
    public  String ajaxDelect(Integer[] bookid){
        int i = bookService.deleteByIds(bookid);
        System.err.println("受影响的行数："+i);
        System.out.println("1111111");
        return "forward:/ajaxQuety.htm";
    }



    //点击详情 先把数据查询出来跳转到详情页面并赋值
    // 因为修改和详情都会调用这个方法 所以多加一个参数
    @RequestMapping("queryByid.htm")
    public String queryByid(@RequestParam("bookid")Integer bookid,ModelMap modelMap,Integer type){
        BookInfo bookInfo = bookService.queryByid(bookid);
        modelMap.put("bookInfo",bookInfo);
        //如果为type==1则为修改页面 2为详情页面
        if (type==1) {
            return "forward:/edit.jsp";
        }else {
            return "forward:/showBook.jsp";
        }
    }

    /**
     * 修改
     * @param bookInfo 图书
     * @return 跳转到首页
     */
    @RequestMapping("editBookInfoById.htm")
    public String editBookInfoById(BookInfo bookInfo){
        String path = bookInfo.getPath();
        System.err.println(path);
        int i = bookService.updateBookInfo(bookInfo);
        System.err.println("修改条数"+i);
        return "forward:/add.htm";
    }

    /**
     * 新增
     * @param bookInfo 图书
     * @return 返回到首页
     */
    @RequestMapping("addBook.htm")
    public String addBook(BookInfo bookInfo){
        int i = bookService.addBook(bookInfo);
        System.err.println("新增的条数"+i);
        return "forward:/add.htm";
    }


    /**
     * ajax 查询
     * @param bookTypeid 图书类型id
     * @param bookname 图书名称
     * @param borrow 是否借阅
     * @param now 当前页数
     * @return 返回json类型的图书集合
     */
    @RequestMapping(value = "/ajaxQuety.htm",produces={"application/json;","text/html;charset=UTF-8;"})
    @ResponseBody//返回结果不会被解析为跳转路径
    public String ajaxQuery(@RequestParam(value="bookTypeid",required=false,defaultValue="0")String bookTypeid,
                            String bookname,
                            @RequestParam(value="borrow",required=false,defaultValue="-1")  String borrow,
                            @RequestParam(value = "now", required = false, defaultValue = "1")Integer now) {
        System.out.println("bookTypeid:"+bookTypeid+"bookname:"+ bookname+"borrow:"+borrow);
        //分页 now 页码  pagesize 显示几条
        PageHelper.startPage(now, 3);
        List<BookInfo> bookInfos = bookService.query(bookTypeid, bookname, borrow);
        //将数据库获取到数据放入pageInfo里  在jsp页面上获取 需要通过pageInfo.list获取
        PageInfo<BookInfo> pageInfo = new PageInfo<BookInfo>(bookInfos);
        //转成json返回出去
        JSONObject jsonObject = new JSONObject();
        jsonObject.put("pageInfo", pageInfo);
        //因为里面有date类型数据所以需要转换一下
        return JSON.toJSONStringWithDateFormat(jsonObject, "yyyy-MM-dd");
    }




    /**
     * 照片上传和回显
     * @param fileImage 图片名称
     * @return json类型的对象
     */
    @RequestMapping("imageupload.htm")
    @ResponseBody
    public String imageUpload(@RequestParam("fileImage") CommonsMultipartFile fileImage) {
        System.out.println("111111");
        // 获取上传图片的位置
        String path = servletContext.getRealPath("/images/");
        System.out.println("上传的路径为:" + path);
        // 获取文件名称
        String name = fileImage.getOriginalFilename();
        // 创建file对象 写入
        File file = new File(path, name);
        try {
            fileImage.getFileItem().write(file);
        } catch (Exception e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        // 将上传的图片路径以json的方式返回客户端
        String imagePath = "images/" + name;
        JSONObject jsonObject = new JSONObject();
        jsonObject.put("imagePath", imagePath);
        // 将对象转为json格式
        String json = jsonObject.toJSONString();
        System.out.println("json:" + json);
        return json;
    }

}

package cn.vp.Service.impl;

import cn.vp.Service.BookService;
import cn.vp.bean.BookInfo;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.List;

import static org.junit.Assert.*;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath*:/applicationContext.xml" ,"classpath*:/springmvc-servlet.xml" })
public class BookServiceImplTest {

    @Autowired
    BookService bookService;
    @Test
    public void queryAll() {
        List<BookInfo> bookInfos = bookService.queryAll();
        for (BookInfo b:bookInfos
             ) {
            System.out.println(b);
        }

    }
}
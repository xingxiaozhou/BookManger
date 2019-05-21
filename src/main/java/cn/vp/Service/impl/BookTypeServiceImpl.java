package cn.vp.Service.impl;

import cn.vp.Service.BookTypeService;
import cn.vp.bean.BookInfo;
import cn.vp.bean.BookType;
import cn.vp.dao.BookInfoMapper;
import cn.vp.dao.BookTypeMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class BookTypeServiceImpl implements BookTypeService{

    @Autowired
    BookTypeMapper bookTypeMapper;


    @Override
    public List<BookType> queryAll() {
        return bookTypeMapper.queryAll();
    }
}

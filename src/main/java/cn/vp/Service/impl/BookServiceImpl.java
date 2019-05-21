package cn.vp.Service.impl;

import cn.vp.Service.BookService;
import cn.vp.bean.BookInfo;
import cn.vp.dao.BookInfoMapper;
import cn.vp.dao.BookTypeMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class BookServiceImpl implements BookService {
    @Autowired
    BookInfoMapper bookInfoMapper;


    @Override
    public List<BookInfo> queryAll() {
        return bookInfoMapper.queryAll();
    }


    @Override
    public int deleteByIds(Integer[] ids){
        return bookInfoMapper.deleteByIds(ids);
    }

    @Override
    public BookInfo queryByid(Integer bookid) {
        return bookInfoMapper.queryByid(bookid);
    }

    @Override
    public int updateBookInfo(BookInfo bookInfo) {
        return bookInfoMapper.updateByPrimaryKeySelective(bookInfo);
    }

    @Override
    public int addBook(BookInfo bookInfo) {
        if (bookInfo.getIsBorrow()==null)
            bookInfo.setIsBorrow(0);
        return bookInfoMapper.insertSelective(bookInfo);
    }

    @Override
    public List<BookInfo> query(String bookTypeid, String bookname, String borrow) {
        return bookInfoMapper.query(bookTypeid,bookname,borrow);
    }
}

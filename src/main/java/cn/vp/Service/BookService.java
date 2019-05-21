package cn.vp.Service;

import cn.vp.bean.BookInfo;

import java.util.List;

public interface BookService {

    List<BookInfo> queryAll();

        //多条件查询
    List<BookInfo> query(String bookTypeid, String bookname,String borrow);

    //批量删除
    int deleteByIds(Integer[] ids);

    //根据id查询
    BookInfo queryByid(Integer bookid);

    //更新
    int updateBookInfo(BookInfo bookInfo);

    //新增
    int addBook(BookInfo bookInfo);

}

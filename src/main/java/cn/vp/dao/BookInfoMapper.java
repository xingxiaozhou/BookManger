package cn.vp.dao;

import cn.vp.bean.BookInfo;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * 图书信息
 */
public interface BookInfoMapper {
    //根据id 删除图书
    int deleteByPrimaryKey(Integer bookId);

    int deleteByIds(Integer[] bookiId);

    //新增
    int insert(BookInfo record);

    //新增（动态sql）
    int insertSelective(BookInfo record);

    //根据id 查询图书
    BookInfo selectByPrimaryKey(Integer bookId);

    //查询所有图书
    List<BookInfo> queryAll();

    //多条件查询
    List<BookInfo> query(@Param("bookTypeid") String bookTypeid, @Param("bookname") String bookname,@Param("borrow") String borrow);

    //更新图书（动态sql）
    int updateByPrimaryKeySelective(BookInfo record);

    //更新图书
    int updateByPrimaryKey(BookInfo record);

    BookInfo queryByid(Integer bookid);
}
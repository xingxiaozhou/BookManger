package cn.vp.dao;

import cn.vp.bean.BookType;

import java.util.List;

public interface BookTypeMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(BookType record);

    int insertSelective(BookType record);

    BookType selectByPrimaryKey(Integer id);

    List<BookType> queryAll();

    int updateByPrimaryKeySelective(BookType record);

    int updateByPrimaryKey(BookType record);
}
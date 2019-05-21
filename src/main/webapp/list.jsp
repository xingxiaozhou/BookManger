<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/4/12 0012
  Time: 10:31
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt" %>
<html>
<head>
    <title>Title</title>
    <script type="text/javascript" src="/js/jquery-1.8.3.js"></script>
    <script type="text/javascript" src="/js/jquery.form.js"></script>
</head>
<body>
<div style="height: 600px; width: 800px; margin: 0px auto;">


    <form action="" method="post" id="query">
        图书分类<select name="bookTypeid">
        <option value="0">全部</option>
        <c:forEach items="${bookTypes}" var="type">
            <option value="${type.id}"
                    <c:if test="${type.id==bookType.id}">selected="selected"</c:if>>${type.typeName}</option>
        </c:forEach>
    </select> &nbsp; 图书名称<input name="bookname" value="${bookname}">
        &nbsp;是否借阅 <select name="borrow">
        <option value="-1">请选择</option>
        <option value="0"
                <c:if test="${borrow==0 }">selected="selected" </c:if>>未借阅
        </option>
        <option value="1"
                <c:if test="${borrow==1 }">selected="selected" </c:if>>已借阅
        </option>
    </select> <input type="hidden" name="now" id="pageno">
        <input type="button" onclick="queryBooks()" value="查询">
    </form>


    <a href="add.jsp">添加</a> &nbsp;
    <button onclick="deleteAll();">批量删除</button>
    <form id="delete" action="bookservlet.do" method="post">
        <input type="hidden" name="choose" value="7">
        <table border="1">
            <thead>
            <tr>
                <td><input type="checkbox"
                           onclick="changecheckBox(this.checked);"></td>
                <td>图书编号</td>
                <td>图书分类</td>
                <td>图书名称</td>
                <td>作者</td>
                <td>出版社</td>
                <td>图片</td>
                <td>操作</td>
                <td>详情</td>
                <td>删除</td>
                <td>修改</td>
            </tr>
            </thead>
            <tbody id="bookbody">
            <c:forEach items="${pageInfo.list}" var="book">
                <tr>
                    <td><input type="checkbox" name="bookid" id="bookid"
                               value="${book.bookId }"></td>
                    <td>${book.bookCode }</td>
                    <td>${book.bookType.typeName}</td>
                    <td>${book.bookName }</td>
                    <td>${book.bookAuthor }</td>
                    <td>${book.publishPress }</td>
                    <td><img src="/${book.path }"></td>
                    <td><c:if test="${book.isBorrow ==0 }">未借阅</c:if> <c:if
                            test="${book.isBorrow ==1 }">已借阅</c:if></td>
                    <td><a href="/queryByid.htm?bookid=${book.bookId}&&type=2">详情</a></td>
                    <td><a href="javascript:delect(${book.bookId});">删除</a></td>
                    <td><a href="/queryByid.htm?bookid=${book.bookId}&&type=1">修改</a></td>
                </tr>
            </c:forEach>
            </tbody>
            <tfoot id="bookfoot">
            <tr>
                <td colspan="9"><a href="javascript:queryBooks(1);">首页</a>&nbsp;&nbsp;
                    <a href="javascript:queryBooks(${pageInfo.pageNum-1});">上一页</a>&nbsp;&nbsp;
                    <a href="javascript:queryBooks(${pageInfo.pageNum+1});">下一页</a>&nbsp;&nbsp;
                    <a href="javascript:queryBooks(${pageInfo.pages});">末页</a>&nbsp;&nbsp;
                    ${pageInfo.pageNum}/${pageInfo.pages}页
                </td>
            </tr>
            </tfoot>
        </table>
    </form>
</div>
</body>
<script type="text/javascript">

    // 全选
    function changecheckBox(checked) {
        $("input[name='bookid']").attr("checked", checked);
    }

    function delect(bookid) {
        $.ajax({
            url: "/ajaxDelect.htm?bookid=" + bookid,
            dataType: "json",
            type: "post",
            success: function (data) {
                alert("删除成功");
                loaddata(data);
            }
        });
    }

    function deleteAll() {
        var obj = {
            url: "/ajaxDelect.htm",
            dataType: "json",
            type: "post",
            success: function (data) {
                loaddata(data);
            }
        };
        $("#delete").ajaxSubmit(obj);
    }


    function queryBooks(pageno) {
        $("#pageno").attr("value", pageno);
        //编写ajax
        var obj = {
            url: "/ajaxQuety.htm",
            dataType: "json",
            type: "post",
            success: function (data) {
                loaddata(data);
            }
        };
        //jqeury.from ajax提交表单
        $("#query").ajaxSubmit(obj);

    }

    function loaddata(data) {
        $("#bookbody").html("");
        $(data.pageInfo.list).each(function () {
            var borrow = (this.isBorrow == 0) ? "未借阅" : "已借阅";
            $("#bookbody").append(' <tr>\n' +
                '                    <td><input type="checkbox" id="bookid" name="bookid"\n' +
                '                               value="' + this.bookId + '"></td>\n' +
                '                    <td>' + this.bookCode + '</td>\n' +
                '                    <td>' + this.bookType.typeName + '</td>\n' +
                '                    <td>' + this.bookName + '</td>\n' +
                '                    <td>' + this.bookAuthor + '</td>\n' +
                '                    <td>' + this.publishPress + '</td>\n' +
                '                    <td><img src="/' + this.path + '"></td>\n' +
                '                    <td>' + borrow + '</td>\n' +
                '                    <td><a href="/queryByid.htm?bookid=\'+this.bookId+\'&&type=2">详情</a></td>\n' +
                '                    <td><a href="javascript:delect(' + this.bookId + ');">删除</a></td>\n' +
                '                    <td><a href="/queryByid.htm?bookid=' + this.bookId + '&&type=1">修改</a></td>\n' +
                '                </tr>');

        });
        $("#bookfoot").html("");
        $("#bookfoot").append(' <tr>\n' +
            '                <td colspan="9"><a href="javascript:queryBooks(1);">首页</a>&nbsp;&nbsp;\n' +
            '                    <a href="javascript:queryBooks(' + (data.pageInfo.pageNum - 1) + ');">上一页</a>&nbsp;&nbsp;\n' +
            '                    <a href="javascript:queryBooks(' + (data.pageInfo.pageNum + 1) + ');">下一页</a>&nbsp;&nbsp;\n' +
            '                    <a href="javascript:queryBooks(' + (data.pageInfo.pages) + ');">末页</a>&nbsp;&nbsp;\n' +
            '                    ' + (data.pageInfo.pageNum) + '/' + (data.pageInfo.pages) + '页\n' +
            '                </td>\n' +
            '            </tr>');
    }

</script>

</html>

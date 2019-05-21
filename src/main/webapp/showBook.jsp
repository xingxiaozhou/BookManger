<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/4/12 0012
  Time: 10:45
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<html>
<head>
    <title>详情</title>
    <style type="text/css">
        #body {
            margin: 0px auto;
            width: 800px;
            height: 600px;
        }
    </style>

    <script type="text/javascript" src="/js/jquery-1.8.3.js"></script>
    <!-- jQuery.form.js是一个form插件,支持ajax表单提交和ajax文件上传 -->
    <script type="text/javascript" src="/js/jquery.form.js"></script>
</head>

<body>
<div id="body">
    <div style="margin: 0px auto; width: 500px;">
        <form action="/add.htm" method="post" enctype="multipart/form-data" id="imm">
            <table border="1px" style="text-align: center;">
                <tr>
                    <td>图书编号</td>
                    <input type="hidden" readonly name="bookId" value="${bookInfo.bookId} ">
                    <td><input id="code" name="bookCode" readonly onblur="checkCode();" value="${bookInfo.bookCode}"><span
                            id="codeMessage"></span></td>
                </tr>
                <tr>
                    <td>图书名称</td>
                    <td><input name="bookName" readonly value="${bookInfo.bookName}"></td>
                </tr>
                <tr>
                    <td>图书分类</td>
                    <td style="text-align: left;"><select name="bookType.id" disabled>
                        <c:forEach items="${bookTypes}" var="bookTy">
                            <option <c:if test="${bookInfo.bookType.id==bookTy.id}">selected</c:if> value="${bookTy.id }">${bookTy.typeName}</option>
                        </c:forEach>
                    </select></td>
                </tr>
                <tr>
                    <td>作者</td>
                    <td><input name="bookAuthor" readonly value="${bookInfo.bookAuthor}"></td>
                </tr>
                <tr>
                    <td>出版社</td>
                    <td><input name="publishPress" readonly value="${bookInfo.publishPress}"></td>
                </tr>
                <tr>
                    <td>出版时间</td>
                    <td><input type="date" name="publishDate" readonly value="<fmt:formatDate value="${bookInfo.publishDate }" pattern="yyyy-MM-dd"/>"></td>
                </tr>
                <tr>
                    <td>图片上传</td>
                    <td><img id="img" width="50dp" height="50dp" src="/${bookInfo.path }">
                        <%--<input name="fileImage" type="file" onchange="uploadImage();">--%>
                        <input type="text" hidden name="path" id="path" value="${bookInfo.path }">
                    </td>
                </tr>
                <tr>
                    <td colspan="2"><input type="submit" value="返回首页"> </td>

                </tr>
            </table>
        </form>
    </div>

    <script type="text/javascript">

        function uploadImage() {
            //编写ajax
            var obj = {
                url: "/imageupload.htm",
                dataType: "json",
                type: "post",
                success: function (data) {
                    alert("路径"+ data.imagePath);
                    $("#img").attr("src", data.imagePath);
                    $("#path").val(data.imagePath);
                    alert( $("#path").var);

                }
            };
            //提交form
            $("#imm").ajaxSubmit(obj);

        }
    </script>
</div>
</body>


</html>

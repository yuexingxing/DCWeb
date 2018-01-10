<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE html>
<html lang="en">
<head>
<base href="<%=basePath%>">
<meta charset="utf-8" />
<title></title>
<meta name="description" content="overview & stats" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<link href="static/css/bootstrap.min.css" rel="stylesheet" />
<link href="static/css/bootstrap-responsive.min.css" rel="stylesheet" />
<link rel="stylesheet" href="static/css/font-awesome.min.css" />
<!-- 下拉框 -->
<link rel="stylesheet" href="static/css/chosen.css" />
<link rel="stylesheet" href="static/css/ace.min.css" />
<link rel="stylesheet" href="static/css/ace-responsive.min.css" />
<link rel="stylesheet" href="static/css/ace-skins.min.css" />
<link rel="stylesheet" href="static/css/datepicker.css" />
<!-- 日期框 -->
<script type="text/javascript" src="static/js/jquery-1.7.2.js"></script>
<script type="text/javascript" src="static/js/jquery.tips.js"></script>
<script type="text/javascript">

	//保存
	function save() {
	
		if ($("#file").val() == "") {
			$("#file").tips({
				side : 3,
				msg : '请先选择文件',
				bg : '#AE81FF',
				time : 2
			});
			$("#file").focus();
			return false;
		}
		
		if ($("#file").val().endsWith('xls') || $("#file").val().endsWith('xlsx')) {
			$("#file").tips({
				side : 3,
				msg : '请先选择文件',
				bg : '#AE81FF',
				time : 2
			});
			$("#file").focus();
			return false;
		}

		$("#Form").submit();
	}
</script>
</head>
<body>
	<form action="tb_producttag/saveSortOrderNum.do"
		enctype="multipart/form-data" name="Form" id="Form" method="post">

		<div id="zhongxin">

			<div style="margin-top: 5px;">
				<input style="margin-left: 10px;" type="file" id="file" name="file" /> <input type="button" style="width: 80px;"
					class="tooltip-error" value="开始排序" onclick="save();" />
			</div>

			<div
				style="width: 100%; height:80%; text-align: center;margin-top: 30px;">
				<td style="text-align: center;" colspan="10"><a
					style="width: 100px; margin-left: 5px;"
					class="btn btn-mini btn-danger" onclick="top.Dialog.close();">取消</a>
				</td>
			</div>
		</div>

		<div id="zhongxin2" class="center" style="display:none">
			<br /> <br /> <br /> <br /> <br /> <img
				src="static/images/jiazai.gif" /><br />
			<h4 class="lighter block green">提交中...</h4>
		</div>
	</form>

	<!-- 引入 -->
	<script type="text/javascript">window.jQuery || document.write("<script src='static/js/jquery-1.9.1.min.js'>\x3C/script>");
	</script>
	<script src="static/js/bootstrap.min.js"></script>
	<script src="static/js/ace-elements.min.js"></script>
	<script src="static/js/ace.min.js"></script>
	<script type="text/javascript" src="static/js/chosen.jquery.min.js"></script>
	<!-- 下拉框 -->
	<script type="text/javascript"
		src="static/js/bootstrap-datepicker.min.js"></script>
	<!-- 日期框 -->
	<script type="text/javascript">
		$(top.hangge());
		$(function() {
	
			//单选框
			$(".chzn-select").chosen();
			$(".chzn-select-deselect").chosen({
				allow_single_deselect : true
			});
	
			//日期框
			$('.date-picker').datepicker();
	
		});
	</script>
</body>
</html>
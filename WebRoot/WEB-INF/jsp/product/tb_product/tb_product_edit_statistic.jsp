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
		if ($("#product_id").val() == "") {
			$("#product_id").tips({
				side : 3,
				msg : '请输入数据',
				bg : '#AE81FF',
				time : 2
			});
			$("#product_id").focus();
			return false;
		}

		if ($("#join_count").val() == "" || $("#join_count").val() < 0) {
			$("#join_count").tips({
				side : 3,
				msg : '请输入有效的数据',
				bg : '#AE81FF',
				time : 2
			});
			$("#join_count").focus();
			return false;
		}

		if ($("#view_count").val() == "" || $("#view_count").val() < 0) {
			$("#view_count").tips({
				side : 3,
				msg : '请输入有效的数据',
				bg : '#AE81FF',
				time : 2
			});
			$("#view_count").focus();
			return false;
		}

		$("#Form").submit();
	}
</script>
</head>
<body>
	<form action="tb_product/${msg}.do" name="Form" id="Form"
		method="post">
		<input type="hidden" name="type" id="type" value="${pd.type}" />
		<div id="zhongxin">
			<table id="table_report">

				<tr>
					<td style="width:70px;text-align: right;">编码:</td>
					<td><input type="text" name="product_id" id="product_id"
						style="margin-top: 5px; margin-left: 5px; " readonly="true"
						value="${pd.product_id}" maxlength="32" placeholder="" title="编码"/></td>
				</tr>
				<tr>
					<td style="width:70px;text-align: right;">加入数:</td>
					<td><input type="number" name="join_count" id="join_count"
						style="margin-top: 5px; margin-left: 5px;"
						value="${pd.join_count}" maxlength="32" placeholder="" title="" /></td>
				</tr>
				<tr>
					<td style="width:70px;text-align: right;">浏览数:</td>
					<td><input type="number" name="view_count" id="view_count"
						style="margin-top: 5px; margin-left: 5px;"
						value="${pd.view_count}" maxlength="32" placeholder="" title="" /></td>
				</tr>

				<tr style="height: 100px;text-align: center;">
					<td style="" colspan="2"><a
						style="width: 100px;"
						class="btn btn-mini btn-primary" onclick="save();">保存</a> <a
						style="width: 100px; margin-left: 5px;"
						class="btn btn-mini btn-danger" onclick="top.Dialog.close();">取消</a>
					</td>
				</tr>
			</table>
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
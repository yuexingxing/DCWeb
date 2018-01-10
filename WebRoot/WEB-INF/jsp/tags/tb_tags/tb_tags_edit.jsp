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
		if ($("#code").val() == "") {
			$("#code").tips({
				side : 3,
				msg : '请输入编码',
				bg : '#AE81FF',
				time : 2
			});
			$("#code").focus();
			return false;
		}
		if ($("#name").val() == "") {
			$("#name").tips({
				side : 3,
				msg : '请输入名称',
				bg : '#AE81FF',
				time : 2
			});
			$("#name").focus();
			return false;
		}

		if (document.getElementById('form-field-radio1').checked) {
			$("#actived").val('1');
		} else if (document.getElementById('form-field-radio2').checked) {
			$("#actived").val('0');
		} else {
			$("#form-field-radio1").tips({
				side : 3,
				msg : '请选择激活状态',
				bg : '#AE81FF',
				time : 2
			});
			$("#form-field-radio1").focus();
			return false;
		}

		$("#Form").submit();
		$("#zhongxin").hide();
		$("#zhongxin2").show();
	}
</script>
</head>
<body>
	<form action="tb_tags/${msg }.do" name="Form" id="Form" method="post">
		<input type="hidden" name="id" id="id" value="${pd.id}" /> <input
			type="hidden" name="actived" id="actived" value="${pd.actived}" /> <input
			type="hidden" name="type" id="type" value="1" />
		<div id="zhongxin">
			<table id="table_report" style="margin-top: 5px;">
				<tr>
					<td style="width:70px;text-align: right;">编码:</td>
					<td style="margin-top: 5px; margin-left: 5px;"><input
						type="text" name="code" id="code" value="${pd.code}"
						maxlength="32" placeholder="" title="编码" /></td>
				</tr>
				<tr>
					<td style="width:70px;text-align: right;">名称:</td>
					<td style="margin-top: 5px; margin-left: 5px;"><input
						type="text" name="name" id="name" value="${pd.name}"
						maxlength="32" placeholder="" title="名称" /></td>
				</tr>
				<tr>
					<td style="width:70px;text-align: right;">备注:</td>
					<td style="margin-top: 5px; margin-left: 5px;"><input
						type="text" name="remark" id="remark" value="${pd.remark}"
						maxlength="32" placeholder="" title="备注" /></td>
				</tr>
				<tr>
					<td style="width:70px;text-align: right;">其他:</td>
					<td style="margin-top: 5px; margin-left: 5px;"><input
						type="text" name="extra" id="extra" value="${pd.extra}"
						maxlength="32" placeholder="" title="extra" /></td>
				</tr>

				<tr>
					<td style="width:70px;text-align: right;">状态:</td>
					<td style="margin-top: 5px; margin-left: 5px;"><input
						name="radio_1" id="form-field-radio1" type="radio"
						${(pd.actived =='true')?'checked' : ''} value="icon-edit" /> <span
						class="lbl"> 激活</span><input name="radio_1" id="form-field-radio2"
						type="radio" ${(pd.actived =='false')?'checked' : ''}
						value="icon-edit" /> <span class="lbl"> 冻结</span></td>
				</tr>

			</table>

			<div style="margin-top: 20px; margin-left: 30px;">
				<a style="width: 100px;" class="btn btn-mini btn-primary"
					onclick="save();">保存</a> <a style="width: 100px;"
					class="btn btn-mini btn-danger" onclick="top.Dialog.close();">取消</a>
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
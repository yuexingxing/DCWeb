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
		if ($("#interest").val() == "" || $("#interest").val() < 0) {
			$("#interest").tips({
				side : 3,
				msg : '请输入合法的利率',
				bg : '#AE81FF',
				time : 2
			});
			$("#interest").focus();
			return false;
		}

		if (document.getElementById('form-field-radio1').checked) {
			$("#type").val('0');
		} else if (document.getElementById('form-field-radio2').checked) {
			$("#type").val('1');
		} else {
			$("#form-field-radio1").tips({
				side : 3,
				msg : '请选择利率类型',
				bg : '#AE81FF',
				time : 2
			});
			return false;
		}

		$("#Form").submit();
	}
</script>
</head>
<body>
	<form action="tb_product/${msg}.do" name="Form" id="Form" method="post">
		<input type="hidden" name="id" id="id" value="${pd.id}" /> <input
			type="hidden" name="product_id" id="product_id"
			value="${pd.product_id}" /> <input type="hidden" name="type"
			id="type" value="${pd.type}" />
		<div id="zhongxin">
			<table id="table_report" style="margin-top: 10px;">

				<tr>
					<td style="width:70px;text-align: right;">期数:</td>
					<td style="margin-left: 3px;"><select class="chzn-select"
						name="credit_date" id="credit_date" data-placeholder="请选择期数"
						style="">
							<option ${(pd.credit_date == 3)?'selected' : ''}>3</option>
							<option ${(pd.credit_date == 6)?'selected' : ''}>6</option>
							<option ${(pd.credit_date == 12)?'selected' : ''}>12</option>
					</select></td>
				</tr>

				<tr>
					<td style="width:70px;text-align: right;">利率:</td>
					<td><input type="number" name="interest" id="interest"
						style="margin-top: 5px; margin-left: 5px;" value="${pd.interest}"
						maxlength="32" placeholder="" title="" /></td>
				</tr>

				<tr>
					<td><label style="float:left;padding-left: 5px;"><input
							name="radio_1" id="form-field-radio1" type="radio"
							value="icon-edit" ${(pd.type == false)?'checked' : ''}><span
							class="lbl"> 日利率</span></label></td>
					<td><label style="float:left;padding-left: 15px;"><input
							name="radio_1" id="form-field-radio2" type="radio"
							${(pd.type == true)?'checked' : ''} value="icon-edit"><span
							class="lbl"> 月利率</span></label></td>
				</tr>

				<tr style="height: 100px; text-align: center; width: 100%;">
					<td style="text-align: center;" colspan="10"><a
						style="width: 100px;" class="btn btn-mini btn-primary"
						onclick="save();">保存</a> <a
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
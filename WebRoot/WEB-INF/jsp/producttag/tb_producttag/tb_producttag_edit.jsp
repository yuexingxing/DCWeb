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
		if ($("#PRODUCT_ID").val() == "") {
			$("#PRODUCT_ID").tips({
				side : 3,
				msg : '请输入产品id',
				bg : '#AE81FF',
				time : 2
			});
			$("#PRODUCT_ID").focus();
			return false;
		}
		if ($("#TAG_ID").val() == "") {
			$("#TAG_ID").tips({
				side : 3,
				msg : '请输入标签id',
				bg : '#AE81FF',
				time : 2
			});
			$("#TAG_ID").focus();
			return false;
		}
		if ($("#TAG_CODE").val() == "") {
			$("#TAG_CODE").tips({
				side : 3,
				msg : '请输入标签编码',
				bg : '#AE81FF',
				time : 2
			});
			$("#TAG_CODE").focus();
			return false;
		}
		if ($("#ORDER_NUM").val() == "" || $("#ORDER_NUM").val() < 0) {
			$("#ORDER_NUM").tips({
				side : 3,
				msg : '请输入合法的排序号',
				bg : '#AE81FF',
				time : 2
			});
			$("#ORDER_NUM").focus();
			return false;
		}

		if (document.getElementById('form-field-radio1').checked) {
			$("#ACTIVED").val('1');
		} else if (document.getElementById('form-field-radio2').checked) {
			$("#ACTIVED").val('0');
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
	<form action="tb_producttag/${msg}.do" name="Form" id="Form"
		method="post">
		<input type="hidden" name="ID" id="ID" value="${pd.ID}" /> <input
			type="hidden" name="ACTIVED" id="ACTIVED" value="${pd.ACTIVED}" />
		<div id="zhongxin">
			<table id="table_report">

				<tr>
					<td style="width:70px;text-align: right;">产品id:</td>
					<td style="margin-top: 5px; margin-left: 5px;"><input
						type="text" name="PRODUCT_ID" id="PRODUCT_ID"
						value="${pd.PRODUCT_ID}" placeholder="" readonly="readonly"
						title="产品id" /></td>
				</tr>
				<tr>
					<td style="width:70px;text-align: right;">标签id:</td>
					<td style="margin-top: 5px; margin-left: 5px;"><input
						type="text" name="TAG_ID" id="TAG_ID" value="${pd.TAG_ID}" readonly="readonly"
						readonly placeholder="" title="标签id" /></td>
				</tr>
				<tr>
					<td style="width:70px;text-align: right;">标签编码:</td>
					<td style="margin-top: 5px; margin-left: 5px;"><input
						type="text" name="TAG_CODE" id="TAG_CODE" value="${pd.TAG_CODE}" readonly="readonly"
						readonly placeholder="" title="标签编码" /></td>
				</tr>
				<tr>
					<td style="width:70px;text-align: center;">排序:</td>
					<td style="margin-top: 5px; margin-left: 5px;"><input
						type="number" name="ORDER_NUM" id="ORDER_NUM"
						value="${pd.ORDER_NUM}" placeholder="" title="序号" /></td>
				</tr>
				<tr>
					<td style="width:70px;text-align: right;">状态:</td>
					<td style="margin-top: 5px; margin-left: 5px;"><input
						name="radio_1" id="form-field-radio1" type="radio"
						${(pd.ACTIVED =='true')?'checked' : ''} value="icon-edit" /> <span
						class="lbl"> 激活</span><input name="radio_1" id="form-field-radio2"
						type="radio" ${(pd.ACTIVED =='false')?'checked' : ''}
						value="icon-edit" /> <span class="lbl"> 冻结</span></td>
				</tr>

			</table>

			<div style="margin-top: 20px; margin-left: 30px;">
				<td style="text-align: center;" colspan="10"><a
					style="width: 100px;" class="btn btn-mini btn-primary"
					onclick="save();">保存</a> <a style="width: 100px;"
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
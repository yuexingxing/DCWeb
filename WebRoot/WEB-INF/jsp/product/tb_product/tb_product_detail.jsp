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
<!-- /DCWEB/WebRoot/WEB-INF/jsp/system/admin/top.jsp -->
<%@ include file="../../system/admin/top.jsp"%>
</head>
<body>

	<div class="container-fluid" id="main-container">

		<div id="page-content" class="clearfix">
			<div class="row-fluid">
				<div class="row-fluid">
					<!-- 检索  -->
					<form action="tb_product/saveProduct.do" method="post" name="Form"
						id="Form">
						<!-- 检索  -->
						<input type="hidden" value="no" id="hasTp1" /> <input
							type="hidden" name="id" id="id" value="${pd.id}" /> <input
							type="hidden" name="category_id" id="category_id"
							value="${pd.category_id}" /> <input type="hidden"
							name="category" id="category" value="${pd.category}" /> <input
							type="hidden" name="remark" id="remark" value="${pd.remark}" />
						<input type="hidden" name="proof" id="proof" value="${pd.proof}" />
						<input type="hidden" name="jump_type" id="jump_type"
							value="${pd.jump_type}" /> <input type="hidden"
							name="created_at" id="created_at" value="${pd.created_at}" /> <input
							type="hidden" name="process_img" id="process_img"
							value="${pd.process_img}" /> <input type="hidden" name="remark"
							id="remark" value="${pd.remark}" /> <input type="hidden"
							name="icon_url" id="icon_url" value="${pd.icon_url}" /> <input
							type="hidden" name="product_type" id="product_type"
							value="${pd.product_type}" /> <input type="hidden"
							name="default_repayment" id="default_repayment"
							value="${pd.default_repayment}" /> <input type="hidden"
							name="default_interest" id="default_interest"
							value="${pd.default_interest}" /> <input type="hidden"
							name="default_total_interest" id="default_total_interest"
							value="${pd.default_total_interest}" /> <input type="hidden"
							name="recommend_desc" id="recommend_desc"
							value="${pd.recommend_desc}" /> <input type="hidden" name="tags"
							id="tags" value="${pd.tags}" /> <input type="hidden" name="tags"
							id="jump_url" value="${pd.jump_url}" /><input type="hidden"
							name="version" id="version" value="${pd.version}" />


						<div id="zhongxin">
							<table id="table_report" style="width: 100%;">
								<tr>

									<td style="width:100px;text-align: right;">code:</td>
									<td><input type="text" name="code" id="code"
										style="margin-top: 5px; margin-left: 5px;" readonly
										value="${pd.code}" placeholder="" title="名称" /></td>

									<td style="width:100px;text-align: right;">名称:</td>
									<td><input type="text" name="name" id="name"
										style="margin-top: 5px; margin-left: 5px;" value="${pd.name}"
										placeholder="" title="名称" /></td>

									<td style="width:100px;text-align: right;">联系方式:</td>
									<td><input type="number" name="phone" id="phone"
										style="margin-top: 5px; margin-left: 5px;" value="${pd.phone}"
										placeholder="" title="名称" /></td>

									<td style="width:100px;text-align: right;">贷款下限:</td>
									<td><input type="number" name="credit_min_amount"
										id="credit_min_amount"
										style="margin-top: 5px; margin-left: 5px;"
										value="${pd.credit_min_amount}" placeholder="" title="贷款下限" /></td>

									<td style="width:100px;text-align: right;">贷款上限:</td>
									<td><input type="number" name="credit_max_amount"
										id="credit_max_amount"
										style="margin-top: 5px; margin-left: 5px;"
										value="${pd.credit_max_amount}" placeholder="" title="贷款上限" /></td>

									<td style="width:100px;text-align: right;">排序:</td>
									<td><input type="number" name="order_num" id="order_num"
										style="margin-top: 5px; margin-left: 5px;"
										value="${pd.order_num}" placeholder="" title="贷款下限" /></td>

								</tr>

								<!-- 第二行 -->
								<tr>

									<td style="width:100px;text-align: right;">贷款最小时间:</td>
									<td><input type="number" name="credit_min_date"
										id="credit_min_date"
										style="margin-top: 5px; margin-left: 5px;"
										value="${pd.credit_min_date}" placeholder="" title="名称" /></td>

									<td style="width:100px;text-align: right;">贷款最大时间:</td>
									<td><input type="number" name="credit_max_date"
										id="credit_max_date"
										style="margin-top: 5px; margin-left: 5px;"
										value="${pd.credit_max_date}" placeholder="" title="名称" /></td>

									<td style="width:100px;text-align: right;">默认贷款时间:</td>
									<td><input type="number" name="default_credit_date"
										id="default_credit_date"
										style="margin-top: 5px; margin-left: 5px;"
										value="${pd.default_credit_date}" placeholder="" title="名称" /></td>

									<td style="width:100px;text-align: right;">缺省金额:</td>
									<td><input type="number" name="default_amount"
										id="default_amount" style="margin-top: 5px; margin-left: 5px;"
										value="${pd.default_amount}" placeholder="" title="名称" /></td>

									<td style="width:100px;text-align: right;">图标:</td>
									<td><div style="display: inline;">
											<img style="width: 35px; height: 35px;margin-left: 10px"
												id="img1" src="${pd.icon_url}"
												onclick="goViewPicture('${pd.icon_url}')">
										</div>
										<div style="display: inline;">
											<a class="btn btn-mini btn-success"
												onclick="uploadIcon('${pd.id}', 1);">重新选择</a>
										</div></td>

									<td style="width:100px;text-align: right;">利率类型:</td>
									<td><label style="float:left;padding-left: 5px;"><input
											name="radio_rate_type" id="form-field-radio1_rate_type"
											type="radio" value="icon-edit"
											${(pd.rate_type == false)?'checked' : ''}><span
											class="lbl"> 日利率</span></label> <label
										style="float:left;padding-left: 15px;"><input
											name="radio_rate_type" id="form-field-radio2_rate_type"
											type="radio" ${(pd.rate_type == true)?'checked' : ''}
											value="icon-edit"><span class="lbl"> 月利率</span></label></td>

								</tr>

								<!-- 第三行 -->
								<tr>
									<td style="width:100px;text-align: right;">利率:</td>
									<td><input type="text" name="rate" id="rate"
										style="margin-top: 5px; margin-left: 5px;" value="${pd.rate}"
										placeholder="" title="编码" /></td>

									<td style="width:100px; text-align: right;">利率范围:</td>
									<td><input type="text" name="rate_area" id="rate_area"
										style="margin-top: 5px; margin-left: 5px;"
										value="${pd.rate_area}" placeholder="" title="名称" /></td>

									<td style="width:100px;text-align: right;">公司链接:</td>
									<td><input type="text" name="company_url" id="company_url"
										style="margin-top: 5px; margin-left: 5px;"
										value="${pd.company_url}" placeholder="" title="编码" /></td>

									<td style="width:100px; text-align: right;">公司H5链接:</td>
									<td><input type="text" name="company_h5_url"
										id="company_h5_url" style="margin-top: 5px; margin-left: 5px;"
										value="${pd.company_h5_url}" placeholder="" title="名称" /></td>

									<td style="width:100px;text-align: right;">引导图:</td>
									<td><div style="display: inline;">
											<img style="width: 35px; height: 35px;margin-left: 10px"
												id="img1" src="${pd.process_img}"
												onclick="goViewPicture('${pd.process_img}')">
										</div>
										<div style="display: inline;">
											<a class="btn btn-mini btn-success"
												onclick="uploadIcon('${pd.id}', 2);">重新选择</a>
										</div></td>

									<td style="width:100px;text-align: right;">状态:</td>
									<td><label style="float:left;padding-left: 5px;"><input
											name="radio_actived" id="form-field-radio1_actived"
											type="radio" value="icon-edit"
											${(pd.actived == false)?'checked' : ''}><span
											class="lbl"> 激活</span></label> <label
										style="float:left;padding-left: 15px;"><input
											name="radio_actived" id="form-field-radio2_actived"
											type="radio" ${(pd.actived == true)?'checked' : ''}
											value="icon-edit"><span class="lbl"> 冻结</span></label></td>

								</tr>

								<!-- 第四行 -->
								<tr>
									<td style="width:100px;text-align: right;">更新时间:</td>
									<td><input type="text" name="updated_at" id="updated_at"
										style="margin-top: 5px; margin-left: 5px;"
										value="${pd.updated_at}" placeholder="" title="编码" readonly/></td>

									<td style="width:100px;text-align: right;">申请说明:</td>
									<td><input type="text" name="apply_condition"
										id="apply_condition"
										style="margin-top: 5px; margin-left: 5px;"
										value="${pd.apply_condition}" placeholder="" title="名称" /></td>

									<td style="width:100px;text-align: right;">申请条件:</td>
									<td><input type="text" name="apply_explain"
										id="apply_explain" style="margin-top: 5px; margin-left: 5px;"
										value="${pd.apply_explain}" placeholder="" title="名称" /></td>
								</tr>

							</table>

							<div>
								<a style="width: 100px;margin-left: 20px;"
									class="btn btn-mini btn-primary" onclick="saveProduct();">保存</a>
							</div>

						</div>
						<div style="margin-top: 20px;"></div>
						<table id="table_report" style="margin-top: 10px;"
							class="table table-striped table-bordered table-hover">
							<thead>
								<tr>
									<th class="center">序号</th>
									<th class="center">编码</th>
									<th class="center">期数</th>
									<th class="center">利率</th>
									<th class="center">类型</th>
									<th class="center">更新时间</th>
								</tr>
							</thead>

							<tbody>

								<!-- 开始循环 -->
								<c:choose>
									<c:when test="${not empty interestList}">
										<c:if test="${QX.cha == 1 }">
											<c:forEach items="${interestList}" var="var" varStatus="vs">
												<tr>
													<td class='center'>${vs.index+1}</td>
													<td class='center'>${var.id}</td>
													<td class='center'>${var.credit_date}</td>
													<td class='center'>${var.interest}</td>
													<td class='center'>${var.type}</td>
													<td class='center'>${var.updated_at}</td>
													<td style="width: 30px;" class="center">
														<div class='hidden-phone visible-desktop btn-group'>

															<c:if test="${QX.edit != 1 && QX.del != 1 }">
																<span
																	class="label label-large label-grey arrowed-in-right arrowed-in"><i
																	class="icon-lock" title="无权限"></i></span>
															</c:if>
															<div class="inline position-relative">
																<button class="btn btn-mini btn-info"
																	data-toggle="dropdown">
																	<i class="icon-cog icon-only"></i>
																</button>
																<ul
																	class="dropdown-menu dropdown-icon-only dropdown-light pull-right dropdown-caret dropdown-close">
																	<c:if test="${QX.edit == 1 }">
																		<li><a style="cursor: pointer;" title="编辑"
																			onclick="goEditInterest('${var.id}');"
																			class="tooltip-success" data-rel="tooltip" title=""
																			data-placement="left"><span class="green"><i
																					class="icon-edit"></i></span></a></li>
																	</c:if>
																	<c:if test="${QX.del == 1 }">
																		<li><a style="cursor: pointer;" title="删除"
																			onclick="deleteInterest('${var.id}');"
																			class="tooltip-error" data-rel="tooltip" title=""
																			data-placement="left"><span class="red"><i
																					class="icon-trash"></i></span> </a></li>
																	</c:if>

																</ul>
															</div>
														</div>
													</td>
												</tr>

											</c:forEach>
										</c:if>
										<c:if test="${QX.cha == 0 }">
											<tr>
												<td colspan="100" class="center">您无权查看</td>
											</tr>
										</c:if>
									</c:when>
									<c:otherwise>
										<tr class="main_info">
											<td colspan="100" class="center">没有相关数据</td>
										</tr>
									</c:otherwise>
								</c:choose>

							</tbody>
						</table>

						<div class="page-header position-relative">
							<table style="width: 100%;">
								<tr>
									<td style="vertical-align: top;"><c:if
											test="${QX.add == 1 }">
											<a class="btn btn-small btn-success"
												onclick="addInterest(${pd.id});">新增</a>
										</c:if></td>

									<td style="vertical-align: top;"><div class="pagination"
											style="float: right; padding-top: 0px; margin-top: 0px;">${page.pageStr}</div></td>
								</tr>
							</table>
						</div>

						<table id="table_report" style="margin-top: 10px;"
							class="table table-striped table-bordered table-hover">
							<thead>
								<tr>
									<th class="center">序号</th>
									<th class="center">编码</th>
									<th class="center">加入数</th>
									<th class="center">浏览数</th>
									<th class="center">更新时间</th>
									<th class="center">操作</th>
								</tr>
							</thead>

							<tbody>

								<!-- 开始循环 -->
								<c:choose>
									<c:when test="${not empty statisticList}">
										<c:if test="${QX.cha == 1 }">
											<c:forEach items="${statisticList}" var="var" varStatus="vs">
												<tr>
													<td class='center'>${vs.index+1}</td>
													<td class='center'>${var.product_id}</td>
													<td class='center'>${var.join_count}</td>
													<td class='center'>${var.view_count}</td>
													<td class='center'>${var.updated_at}</td>
													<td style="width: 50px;" class="center"><c:if
															test="${QX.edit == 1 }">
															<li><a style="cursor: pointer;" title="编辑"
																onclick="goEditStatistic(${var.product_id});"
																class="tooltip-success" data-rel="tooltip" title=""
																data-placement="left"><span class="green"><i
																		class="icon-edit"></i></span></a></li>
														</c:if></td>
												</tr>

											</c:forEach>
										</c:if>
										<c:if test="${QX.cha == 0 }">
											<tr>
												<td colspan="100" class="center">您无权查看</td>
											</tr>
										</c:if>
									</c:when>
									<c:otherwise>
										<tr class="main_info">
											<td colspan="100" class="center">没有相关数据</td>
										</tr>
									</c:otherwise>
								</c:choose>

							</tbody>
						</table>


					</form>
				</div>
				<!-- PAGE CONTENT ENDS HERE -->
			</div>
			<!--/row-->

		</div>
		<!--/#page-content-->
	</div>
	<!--/.fluid-container#main-container-->

	<!-- 返回顶部  -->
	<a href="#" id="btn-scroll-up" class="btn btn-small btn-inverse"> <i
		class="icon-double-angle-up icon-only"></i>
	</a>

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
	<script type="text/javascript" src="static/js/bootbox.min.js"></script>
	<!-- 确认窗口 -->
	<!-- 引入 -->
	<script type="text/javascript" src="static/js/jquery.tips.js"></script>
	<!--提示框-->
	<script type="text/javascript">
	
		function uploadIcon(id, type) {
			if ($("#id").val() == "") {
				alert("该功能在编辑模式下使用");
				return;
			}
	
			top.jzts();
			var diag = new top.Dialog();
			diag.Drag = true;
			diag.Title = "添加图片";
			diag.URL = "<%=basePath%>tb_product/goAddPicture.do?id=" + id + "&type=" + type;
			diag.Width = 800;
			diag.Height = 490;
			diag.CancelEvent = function() { //关闭事件
				top.jzts();
				setTimeout("self.location=self.location", 100);
				diag.close();
			};
			diag.show();
		}
	
		function goViewPicture(url) {
			if (url == "") {
				alert("当前没有图片");
				return;
			}
	
			top.jzts();
			var diag = new top.Dialog();
			diag.Drag = true;
			diag.Title = "图片浏览";
			diag.URL = "<%=basePath%>tb_product/goViewPicture.do?icon_url=" + url;
			diag.Width = 600;
			diag.Height = 600;
			diag.CancelEvent = function() { //关闭事件
				top.jzts();
				setTimeout("self.location=self.location", 100);
				diag.close();
			};
			diag.show();
		}
	
	
		function checkInputStr(str) {
			if ($(str).val() == "" || $(str).val() == null) {
				$(str).tips({
					side : 3,
					msg : '请输入数据',
					bg : '#AE81FF',
					time : 2
				});
				$(str).focus();
				return true;
			}
	
			return false;
		}
	
		function checkInputNumber(str) {
			if ($(str).val() == "" || $(str).val() < 0) {
				$(str).tips({
					side : 3,
					msg : '请输入有效的数据',
					bg : '#AE81FF',
					time : 2
				});
				$(str).focus();
				return true;
			}
	
			return false;
		}
	
		//保存
		function saveProduct() {
			var flag = true;
	
			var chArrStr = [
				"#name", "#rate_area"
			];
	
			var chArrNum = [
				"#phone", "#credit_min_amount", "#credit_max_amount", "#order_num", "#credit_max_date",
				"#credit_max_date", "#credit_min_date", "#default_credit_date", "#default_amount", "#rate"
			];
	
			for (var i = 0; i < chArrStr.length; i++) {
	
				if (checkInputStr(chArrStr[i])) {
					flag = false;
					break;
				}
			}
	
			if (flag == false) {
				return false;
			}
	
			for (var i = 0; i < chArrNum.length; i++) {
	
				if (checkInputNumber(chArrNum[i])) {
					flag = false;
					break;
				}
			}
	
			if (flag == false) {
				return false;
			}
	
			var id = $("#id").val();
			var code = $("#code").val();
			var name = $("#name").val();
			var phone = $("#phone").val();
			var icon_url = $("#icon_url").val();
			var category_id = $("#category_id").val();
			var category = $("#category").val();
			var product_type = $("#product_type").val();
			var company_url = $("#company_url").val();
			var company_h5_url = $("#company_h5_url").val();
			var credit_max_amount = parseInt($("#credit_max_amount").val());
			var credit_min_amount = parseInt($("#credit_min_amount").val());
			var credit_max_date = parseInt($("#credit_max_date").val());
			var credit_min_date = parseInt($("#credit_min_date").val());
			var default_credit_date = $("#default_credit_date").val();
			var default_amount = parseInt($("#default_amount").val());
			var default_repayment = $("#default_repayment").val();
			var default_total_interest = $("#default_total_interest").val();
			var default_interest = $("#default_interest").val();
			var rate = $("#rate").val();
			var rate_area = $("#rate_area").val();
			var apply = $("#apply").val();
			var apply_condition = $("#apply_condition").val();
			var apply_explain = $("#apply_explain").val();
			var process_img = $("#process_img").val();
			var remark = $("#remark").val();
			var recommend_desc = $("#recommend_desc").val();
			var proof = $("#proof").val();
			var tags = $("#tags").val();
			var jump_type = $("#jump_type").val();
			var jump_url = $("#jump_url").val();
			var version = $("#version").val();
			var order_num = $("#order_num").val();
			var created_at = $("#created_at").val();
			var updated_at = $("#updated_at").val();
	
			var rate_type;
			if (document.getElementById('form-field-radio1_rate_type').checked) {
				rate_type = 0; //日利率
			} else if (document.getElementById('form-field-radio2_rate_type').checked) {
				rate_type = 1; //月利率
			} else {
				$("#form-field-radio1_rate_type").tips({
					side : 3,
					msg : '请选择利率类型',
					bg : '#AE81FF',
					time : 2
				});
				return false;
			}
	
			var actived;
			if (document.getElementById('form-field-radio1_actived').checked) {
				actived = 0;
			} else if (document.getElementById('form-field-radio2_actived').checked) {
				actived = 1;
			} else {
				$("#form-field-radio1_actived").tips({
					side : 3,
					msg : '请选择激活状态',
					bg : '#AE81FF',
					time : 2
				});
				return false;
			}
	
			if (default_amount < credit_min_amount) {
	
				$("#default_amount").tips({
					side : 3,
					msg : '缺省金额不能低于贷款下限',
					bg : '#AE81FF',
					time : 2
				});
				$("#default_amount").focus();
				return false;
			}
	
			if (credit_min_amount > credit_max_amount) {
	
				$("#credit_min_amount").tips({
					side : 3,
					msg : '贷款下限不能超过上限',
					bg : '#AE81FF',
					time : 2
				});
				$("#credit_min_amount").focus();
				return false;
			}
	
			if (credit_min_date > credit_max_date) {
				$("#credit_min_date").tips({
					side : 3,
					msg : '贷款最小时间不能超过最大时间',
					bg : '#AE81FF',
					time : 2
				});
				$("#credit_min_date").focus();
				return false;
			}
	
			var data = {
				id : id,
				code : code,
				name : name,
				phone : phone,
				category_id : category_id,
				category : category,
				product_type : product_type,
				company_url : company_url,
				company_h5_url : company_h5_url,
				credit_max_amount : credit_max_amount,
				credit_min_amount : credit_min_amount,
				credit_min_date : credit_min_date,
				credit_max_date : credit_max_date,
				default_credit_date : default_credit_date,
				default_amount : default_amount,
				default_repayment : default_repayment,
				default_total_interest : default_total_interest,
				default_interest : default_interest,
				rate : rate,
				rate_area : rate_area,
				rate_type : rate_type,
				apply : apply,
				apply_condition : apply_condition,
				apply_explain : apply_explain,
				process_img : process_img,
				remark : remark,
				recommend_desc : recommend_desc,
				proof : proof,
				tags : tags,
				jump_type : jump_type,
				jump_url : jump_url,
				version : version,
				order_num : order_num,
				actived : actived,
				created_at : created_at,
				updated_at : updated_at
			};
	
			$.ajax({
				type : "POST",
				url : '<%=basePath%>tb_product/saveProduct.do',
				data : data,
				dataType : 'json',
				cache : false,
				success : function(data) {
	
					$(top.hangge());
					alert(data.msg)
					if ("success" == data.errInfo) {
						document.location.reload();
					} else {
	
					}
				}
			});
	
		}
	
		var fmid = "fhindex";
		var mid = "fhindex";
		function siMenu(id, fid, MENU_NAME, MENU_URL) {
			if (id != mid) {
				$("#" + mid).removeClass();
				mid = id;
			}
			if (fid != fmid) {
				$("#" + fmid).removeClass();
				fmid = fid;
			}
			$("#" + fid).attr("class", "active open");
			$("#" + id).attr("class", "active");
			top.mainFrame.tabAddHandler(id, MENU_NAME, MENU_URL);
			if (MENU_URL != "druid/index.html") {
				jzts();
			}
		}
	
		$(top.hangge());
	
		//检索
		function search() {
			top.jzts();
			$("#Form").submit();
		}
	
		//新增
		function add() {
			top.jzts();
			var diag = new top.Dialog();
			diag.Drag = true;
			diag.Title = "新增";
			diag.URL = '<%=basePath%>tb_product/goAdd.do';
			diag.Width = 450;
			diag.Height = 600;
			diag.CancelEvent = function() { //关闭事件
	
				top.hangge();
				setTimeout("self.location=self.location", 100);
				diag.close();
				document.location.reload();
			};
			diag.show();
		}
	
		//新增---利率
		function addInterest(product_id) {
			if ($("#id").val() == "") {
				alert("该功能在编辑模式下使用");
				return;
			}
	
			top.jzts();
			var diag = new top.Dialog();
			diag.Drag = true;
			diag.Title = "新增";
			diag.URL = "<%=basePath%>tb_product/goAddInterest.do?product_id=" + product_id;
			diag.Width = 350;
			diag.Height = 500;
			diag.CancelEvent = function() { //关闭事件
	
				top.hangge();
				setTimeout("self.location=self.location", 100);
				diag.close();
				document.location.reload();
			};
			diag.show();
		}
	
		//新增---统计
		function addStatistic(product_id) {
			top.jzts();
			var diag = new top.Dialog();
			diag.Drag = true;
			diag.Title = "新增";
			diag.URL = "<%=basePath%>tb_product/goAddStatistic.do?product_id=" + product_id;
			diag.Width = 450;
			diag.Height = 600;
			diag.CancelEvent = function() { //关闭事件
	
				top.hangge();
				setTimeout("self.location=self.location", 100);
				diag.close();
				document.location.reload();
			};
			diag.show();
		}
	
		//删除
		function deleteInterest(Id) {
			bootbox.confirm("确定要删除吗?", function(result) {
				if (result) {
					top.jzts();
					var url = '<%=basePath%>tb_product/deleteInterest.do?id=' + Id;
	
					$.get(url, function(data) {
	
						document.location.reload();
						top.hangge();
					});
				}
			});
		}
	
		//修改--利率
		function goEditInterest(id) {
			top.jzts();
			var diag = new top.Dialog();
			diag.Drag = true;
			diag.Title = "编辑";
			diag.URL = '<%=basePath%>tb_product/goEditInterest.do?id=' + id;
			diag.Width = 350;
			diag.Height = 500;
			diag.CancelEvent = function() { //关闭事件
	
				top.hangge();
				setTimeout("self.location=self.location", 100);
				diag.close();
				document.location.reload();
			};
			diag.show();
		}
	
		//修改--统计
		function goEditStatistic(product_id) {
			top.jzts();
			var diag = new top.Dialog();
			diag.Drag = true;
			diag.Title = "编辑";
			diag.URL = '<%=basePath%>tb_product/goEditStatistic.do?product_id=' + product_id;
			diag.Width = 350;
			diag.Height = 500;
			diag.CancelEvent = function() { //关闭事件
	
				top.hangge();
				setTimeout("self.location=self.location", 100);
				diag.close();
				document.location.reload();
			};
			diag.show();
		}
	</script>

	<script type="text/javascript">
		
		$(function() {
			
			//下拉框
			$(".chzn-select").chosen(); 
			$(".chzn-select-deselect").chosen({allow_single_deselect:true}); 
			
			//日期框
			$('.date-picker').datepicker();
			
			//复选框
			$('table th input:checkbox').on('click' , function(){
				var that = this;
				$(this).closest('table').find('tr > td:first-child input:checkbox')
				.each(function(){
					this.checked = that.checked;
					$(this).closest('tr').toggleClass('selected');
				});
					
			});
			
		});
		
		
		//批量操作
		function makeAll(msg){
			bootbox.confirm(msg, function(result) {
				if(result) {
					var str = '';
					for(var i=0;i < document.getElementsByName('ids').length;i++)
					{
						  if(document.getElementsByName('ids')[i].checked){
						  	if(str=='') str += document.getElementsByName('ids')[i].value;
						  	else str += ',' + document.getElementsByName('ids')[i].value;
						  }
					}
					if(str==''){
						bootbox.dialog("您没有选择任何内容!", 
							[
							  {
								"label" : "关闭",
								"class" : "btn-small btn-success",
								"callback": function() {
									//Example.show("great success");
									}
								}
							 ]
						);
						
						$("#zcheckbox").tips({
							side:3,
				            msg:'点这里全选',
				            bg:'#AE81FF',
				            time:8
				        });
						
						return;
					}else{
						if(msg == '确定要删除选中的数据吗?'){
							top.jzts();
							$.ajax({
								type: "POST",
								url: '<%=basePath%>tb_product/deleteAll.do?tm='+new Date().getTime(),
						    	data: {DATA_IDS:str},
								dataType:'json',
								//beforeSend: validateData,
								cache: false,
								success: function(data){
									 $.each(data.list, function(i, list){
											nextPage(${page.currentPage});
									 });
								}
							});
						}
					}
				}
			});
		}
		
		//导出excel
		function toExcel(){
			window.location.href='<%=basePath%>tb_product/excel.do';
		}
		
		window.addEventListener('beforeunload', function(event) {
    		alert("I am the 1st one.beforeunload");
  		});
  		
  		window.addEventListener('unload', function(event) {
    		alert("I am the 3rd one.unload");
  		});
		</script>

</body>
</html>


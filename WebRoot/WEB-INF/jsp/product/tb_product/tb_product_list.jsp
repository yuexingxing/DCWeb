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
					<form action="tb_product/list.do" method="post" name="Form"
						id="Form">
						<table>
							<tr>
								<td><span class="input-icon"> <input
										autocomplete="off" id="search_data" type="text"
										name="search_data" value="${pd.search_data}"
										placeholder="这里输入关键词" /> <i id="nav-search-icon"
										class="icon-search"></i>
								</span></td>
								<td style="vertical-align: top;"><button
										class="btn btn-mini btn-light" onclick="search();" title="检索">
										<i id="nav-search-icon" class="icon-search"></i>
									</button></td>
							</tr>
						</table>
						<!-- 检索  -->

						<table id="table_report"
							class="table table-striped table-bordered table-hover"
							style="height: 300px;">
							<thead>
								<tr>
									<th class="center">序号</th>
									<th class="center">编码</th>
									<th class="center">名称</th>
									<th class="center">电话</th>
									<th class="center">最大金额</th>
									<th class="center">最小金额</th>
									<th class="center">利率</th>
									<th class="center">排序</th>
									<th class="center" style="width: 150px;">操作</th>
								</tr>
							</thead>

							<tbody>

								<!-- 开始循环 -->
								<c:choose>
									<c:when test="${not empty varList}">
										<c:if test="${QX.cha == 1 }">
											<c:forEach items="${varList}" var="var" varStatus="vs">
												<tr>
													<input type="hidden" name="id" id="id" value="${var.id}" />
													<td class='center'>${vs.index+1}</td>
													<td class='center'>${var.code}</td>
													<td class='center'>${var.name}</td>
													<td class='center'>${var.phone}</td>
													<td class='center'>${var.credit_max_amount}</td>
													<td class='center'>${var.credit_min_amount}</td>
													<td class='center'>${var.rate_area}</td>
													<td class='center'>${var.order_num}</td>

													<td class='center'>
														<div class="inline position-relative">

															<c:if test="${QX.del == 1 }">
																<a class="btn btn-small btn-failed"
																	style="cursor: pointer;" target="mainFrame"
																	onclick="deleteProduct('${var.id}')">删 除</a>
															</c:if>

															<c:if test="${QX.edit == 1 }">
																<!--  下面是新加的，选中一个产品ID，跳转到新的全屏界面的代码-->
																<a class="btn btn-small btn-success"
																	style="cursor: pointer;" target="mainFrame"
																	onclick="siMenu('z10000','lm10000','产品详情','tb_product/product_detail.do?id=${var.id 

}')">产品详情</a>
															</c:if>
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
												onclick="siMenu('z10001','lm10001','新增','tb_product/product_detail.do?id=')">新
												增</a>
										</c:if></td>

									<td style="vertical-align: top;"><div class="pagination"
											style="float: right; padding-top: 0px; margin-top: 0px;">${page.pageStr}</div></td>
								</tr>

							</table>
						</div>
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
	
		$(top.hangge());
	
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
		
		//检索
		function search(){
			top.jzts();
			$("#Form").submit();
		}
		
		//新增
		function add(){
			 top.jzts();
			 var diag = new top.Dialog();
			 diag.Drag=true;
			 diag.Title ="新增";
			 diag.URL = '<%=basePath%>tb_product/goAddProduct.do';
			 diag.Width = 450;
			 diag.Height = 600;
			 diag.CancelEvent = function(){ //关闭事件
			
				top.jzts();
				setTimeout("self.location=self.location",100);
				diag.close();
				document.location.reload();
			 };
			 diag.show();
		}
		
		//删除
		function del(Id){
			bootbox.confirm("确定要删除吗?", function(result) {
				if(result) {
					top.jzts();
					var url = "<%=basePath%>tb_product/delete.do?TB_PRODUCT_ID="+Id+"&tm="+new Date().getTime();
					$.get(url,function(data){
						nextPage(${page.currentPage});
					});
				}
			});
		}
		
		//删除
		function deleteProduct(Id){
		
			bootbox.confirm("确定要删除吗?", function(result) {
				if(result) {
					top.jzts();
					var url = "<%=basePath%>tb_product/deleteProduct.do?id="+Id;
					$.get(url,function(data){
						
						document.location.reload();
						top.hangge();
					});
				}
			});
		}
		
		//修改
		function edit(Id){
			 top.jzts();
			 var diag = new top.Dialog();
			 diag.Drag=true;
			 diag.Title ="编辑";
			 diag.URL = '<%=basePath%>tb_product/goEdit.do?TB_PRODUCT_ID='+Id;
			 diag.Width = 450;
			 diag.Height = 600;
			 diag.CancelEvent = function(){ //关闭事件
				
				top.hangge();
				document.location.reload();
				diag.close();
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
		</script>

</body>
</html>


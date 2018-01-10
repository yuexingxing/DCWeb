package com.fh.controller.producttag.tb_producttag;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.tools.Tool;

import org.apache.http.util.TextUtils;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.session.Session;
import org.apache.shiro.subject.Subject;

import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.fh.controller.base.BaseController;
import com.fh.entity.Page;
import com.fh.presenter.product.tb_product.ProductPresenter;
import com.fh.util.AppUtil;
import com.fh.util.ObjectExcelView;
import com.fh.util.Const;
import com.fh.util.PageData;
import com.fh.util.Tools;
import com.fh.util.UuidUtil;
import com.sun.istack.internal.NotNull;
import com.fh.util.Jurisdiction;
import com.fh.service.product.tb_product.TB_ProductService;
import com.fh.service.producttag.tb_producttag.TB_ProductTagService;

/** 
 * 类名称：TB_ProductTagController
 * 创建人：FH 
 * 创建时间：2017-12-22
 */
@Controller
@RequestMapping(value="/tb_producttag")
public class TB_ProductTagController extends BaseController {

	String menuUrl = "tb_producttag/list.do"; //菜单地址(权限用)
	@Resource(name="tb_producttagService")
	private TB_ProductTagService tb_producttagService;

	@Resource(name="tb_productService")
	private TB_ProductService tb_productService;

	/**
	 * 新增
	 */
	@RequestMapping(value="/save")
	public ModelAndView save() throws Exception{
		logBefore(logger, "新增TB_ProductTag");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "add")){return null;} //校验权限
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();

		pd.put("ID", tb_producttagService.findMaxId());	//主键
		pd.put("CREATED_AT", Tools.getTime());
		pd.put("UPDATED_AT", Tools.getTime());
		tb_producttagService.save(pd);
		mv.addObject("msg","success");
		mv.setViewName("save_result");
		return mv;
	}

	/**
	 * 删除
	 */
	@RequestMapping(value="/delete")
	public void delete(PrintWriter out){
		logBefore(logger, "删除TB_ProductTag");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "del")){return;} //校验权限
		PageData pd = new PageData();
		try{
			pd = this.getPageData();
			tb_producttagService.delete(pd);
			out.write("success");
			out.close();
		} catch(Exception e){
			logger.error(e.toString(), e);
		}

	}

	/**
	 * 修改
	 */
	@RequestMapping(value="/edit")
	public ModelAndView edit() throws Exception{
		logBefore(logger, "修改TB_ProductTag");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "edit")){return null;} //校验权限
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();

		pd.put("UPDATED_AT", Tools.getTime());
		tb_producttagService.edit(pd);
		mv.addObject("msg","success");
		mv.setViewName("save_result");
		return mv;
	}

	/**
	 * 列表
	 */
	@RequestMapping(value="/list")
	public ModelAndView list(Page page){
		logBefore(logger, "列表TB_ProductTag");
		//if(!Jurisdiction.buttonJurisdiction(menuUrl, "cha")){return null;} //校验权限
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		try{
			pd = this.getPageData();

			String searchData=null;
			List<PageData> varList;
			if(pd.containsKey("search_data")){
				searchData = pd.get("search_data").toString();
			}

			System.out.println("-----searchData------" + searchData);
			pd.put("search_data", searchData);
			page.setPd(pd);
			if(TextUtils.isEmpty(searchData)){
				varList = tb_producttagService.list(page);	//列出TB_ProductTag列表
			}else{
				varList = tb_producttagService.listSearch(searchData);
			}

			mv.setViewName("producttag/tb_producttag/tb_producttag_list");
			mv.addObject("varList", varList);
			mv.addObject("pd", pd);
			mv.addObject(Const.SESSION_QX,this.getHC());	//按钮权限
		} catch(Exception e){
			logger.error(e.toString(), e);
		}
		return mv;
	}

	/**
	 * 去新增页面
	 */
	@RequestMapping(value="/goAdd")
	public ModelAndView goAdd(){
		logBefore(logger, "去新增TB_ProductTag页面");
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		try {

			pd.put("ACTIVED", "true");
			mv.setViewName("producttag/tb_producttag/tb_producttag_edit");
			mv.addObject("msg", "save");
			mv.addObject("pd", pd);
		} catch (Exception e) {
			logger.error(e.toString(), e);
		}						
		return mv;
	}	

	/**
	 * 去修改页面
	 */
	@RequestMapping(value="/goEdit")
	public ModelAndView goEdit(){
		logBefore(logger, "去修改TB_ProductTag页面");
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		try {
			pd = tb_producttagService.findById(pd);	//根据ID读取
			mv.setViewName("producttag/tb_producttag/tb_producttag_edit");
			mv.addObject("msg", "edit");
			mv.addObject("pd", pd);
		} catch (Exception e) {
			logger.error(e.toString(), e);
		}						
		return mv;
	}	


	/**
	 * 去排序界面
	 */
	@RequestMapping(value="/goSortOrderNum")
	public ModelAndView goSortOrderNum(){

		logBefore(logger, "去新增goSortOrderNum页面");
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		try {
			pd.put("id", tb_productService.findMaxId_product() + "");
			mv.setViewName("producttag/tb_producttag/tb_product_sort_ordernum");
			mv.addObject("pd", pd);
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(e.toString(), e);
		}						

		System.out.println("pd.id" + pd.get("id"));

		return mv;
	}	


	/**
	 * 批量删除
	 */
	@RequestMapping(value="/deleteAll")
	@ResponseBody
	public Object deleteAll() {
		logBefore(logger, "批量删除TB_ProductTag");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "dell")){return null;} //校验权限
		PageData pd = new PageData();		
		Map<String,Object> map = new HashMap<String,Object>();
		try {
			pd = this.getPageData();
			List<PageData> pdList = new ArrayList<PageData>();
			String DATA_IDS = pd.getString("DATA_IDS");
			if(null != DATA_IDS && !"".equals(DATA_IDS)){
				String ArrayDATA_IDS[] = DATA_IDS.split(",");
				tb_producttagService.deleteAll(ArrayDATA_IDS);
				pd.put("msg", "ok");
			}else{
				pd.put("msg", "no");
			}
			pdList.add(pd);
			map.put("list", pdList);
		} catch (Exception e) {
			logger.error(e.toString(), e);
		} finally {
			logAfter(logger);
		}
		return AppUtil.returnObject(pd, map);
	}

	/*
	 * 导出到excel
	 * @return
	 */
	@RequestMapping(value="/excel")
	public ModelAndView exportExcel(){
		logBefore(logger, "导出TB_ProductTag到excel");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "cha")){return null;}
		ModelAndView mv = new ModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		try{
			Map<String,Object> dataMap = new HashMap<String,Object>();
			List<String> titles = new ArrayList<String>();
			titles.add("id");	//1
			titles.add("产品id");	//2
			titles.add("标签id");	//3
			titles.add("标签编码");	//4
			titles.add("序号");	//5
			titles.add("状态");	//6
			titles.add("创建时间");	//7
			titles.add("更新时间");	//8
			dataMap.put("titles", titles);
			List<PageData> varOList = tb_producttagService.listAll(pd);
			List<PageData> varList = new ArrayList<PageData>();
			for(int i=0;i < varOList.size();i++){
				PageData vpd = new PageData();
				vpd.put("var1", varOList.get(i).getString("ID"));	//1
				vpd.put("var2", varOList.get(i).getString("PRODUCT_ID"));	//2
				vpd.put("var3", varOList.get(i).getString("TAG_ID"));	//3
				vpd.put("var4", varOList.get(i).getString("TAG_CODE"));	//4
				vpd.put("var5", varOList.get(i).getString("ORDER_NUM"));	//5
				vpd.put("var6", varOList.get(i).getString("ACTIVED"));	//6
				vpd.put("var7", varOList.get(i).getString("CREATED_AT"));	//7
				vpd.put("var8", varOList.get(i).getString("UPDATED_AT"));	//8
				varList.add(vpd);
			}
			dataMap.put("varList", varList);
			ObjectExcelView erv = new ObjectExcelView();
			mv = new ModelAndView(erv,dataMap);
		} catch(Exception e){
			logger.error(e.toString(), e);
		}
		return mv;
	}

	/**
	 * 保存---排序
	 */
	@RequestMapping(value="/saveSortOrderNum", method = RequestMethod.POST)
	public ModelAndView saveSortOrderNum(@NotNull @RequestParam("file") MultipartFile file, HttpServletRequest request ) throws Exception{

		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();

		try {
			String OriginalFilename = file.getOriginalFilename();//上传的文件的原始名称

			String ATTACHMENT_ID = null;

			//判断是不是excel文件
			if(OriginalFilename.endsWith(".xlsx")){
				ATTACHMENT_ID = System.currentTimeMillis() + ".xlsx";
			}if(OriginalFilename.endsWith(".xls")){
				ATTACHMENT_ID = System.currentTimeMillis() + ".xls";
			}

			if(!TextUtils.isEmpty(ATTACHMENT_ID)){

				String pictureSavePath = "c:\\tmpPic\\";//服务器tmp临时磁盘路径

				String filename = UuidUtil.get32UUID();
				Path pach_file_path = Paths.get(pictureSavePath, filename);
				String abs_save_file_save_path = Paths.get(pictureSavePath, filename, ATTACHMENT_ID).toString();

				System.out.println(OriginalFilename);
				System.out.println(pictureSavePath);
				System.out.println(abs_save_file_save_path);

				// 接收上传文件.....
				boolean saveFlag = uploadFile(file.getBytes(), pach_file_path.toString(), abs_save_file_save_path.toString());
				if (saveFlag) {

					ProductPresenter.editOrderNum(tb_productService, tb_producttagService, abs_save_file_save_path.toString());
				} else {
					logger.error("文件上传失败!");
				}
			}
		} catch (Exception e) {
			logger.error(e.getMessage());
		}

		mv.addObject("msg","success");
		mv.setViewName("save_result");
		return mv;
	}

	private boolean uploadFile( byte[] file, String filePath, String fileName ) throws Exception {
		try {
			File targetFile = new File(filePath);
			if (!targetFile.exists()) {
				targetFile.mkdirs();
			}
			FileOutputStream out = new FileOutputStream(fileName);
			out.write(file);
			out.flush();
			out.close();
			return true;
		} catch (IOException e) {
			logger.error("uploadFile异常:" + e.getMessage());
			return false;
		}
	}


	/* ===============================权限================================== */
	public Map<String, String> getHC(){
		Subject currentUser = SecurityUtils.getSubject();  //shiro管理的session
		Session session = currentUser.getSession();
		return (Map<String, String>)session.getAttribute(Const.SESSION_QX);
	}
	/* ===============================权限================================== */

	@InitBinder
	public void initBinder(WebDataBinder binder){
		DateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		binder.registerCustomEditor(Date.class, new CustomDateEditor(format,true));
	}
}

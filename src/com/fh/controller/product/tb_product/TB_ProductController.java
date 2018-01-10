package com.fh.controller.product.tb_product;

import java.io.File;
import java.io.PrintWriter;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.annotation.Resource;
import org.apache.commons.fileupload.disk.DiskFileItem;
import org.apache.commons.io.FileUtils;
import org.apache.http.util.TextUtils;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.session.Session;
import org.apache.shiro.subject.Subject;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.commons.CommonsMultipartFile;
import org.springframework.web.servlet.ModelAndView;
import com.fh.controller.base.BaseController;
import com.fh.entity.Page;
import com.fh.util.AppUtil;
import com.fh.util.Const;
import com.fh.util.GetPinyin;
import com.fh.util.GetStartedSample;
import com.fh.util.PageData;
import com.fh.util.Tools;
import com.fh.util.Jurisdiction;
import com.fh.service.product.tb_product.TB_ProductService;
import com.fh.service.producttag.tb_producttag.TB_ProductTagService;
import com.fh.service.tags.tb_tags.TB_tagsService;

/** 
 * 类名称：TB_ProductController
 * 创建人：FH 
 * 创建时间：2017-12-15
 */
@Controller
@RequestMapping(value="/tb_product")
public class TB_ProductController extends BaseController {

	String menuUrl = "tb_product/list.do"; //菜单地址(权限用)
	@Resource(name="tb_productService")
	private TB_ProductService tb_productService;

	@Resource(name="tb_producttagService")
	private TB_ProductTagService tb_productTagService;

	@Resource(name="tb_tagsService")
	private TB_tagsService tb_tagService;
	public static String currentId;//当前所操作商品对应id，选择上传图片用
	public static String hanldeType;//操作类型，1-icon 2-process_img

	/**
	 * 新增
	 */
	@RequestMapping(value="/save")
	public ModelAndView save() throws Exception{
		logBefore(logger, "新增TB_Product");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "add")){return null;} //校验权限
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		pd.put("TB_PRODUCT_ID", this.get32UUID());	//主键
		tb_productService.save(pd);
		mv.addObject("msg","success");
		mv.setViewName("save_result");
		return mv;
	}

	/**
	 * 保存---商品
	 */
	@RequestMapping(value="/saveProduct")
	@ResponseBody
	public Object saveProduct() throws Exception{

		Map<String,String> map = new HashMap<String,String>();
		String errInfo = "success";
		String msg = "";
		PageData pd = new PageData();
		pd = this.getPageData();

		System.out.println("-------------------" + pd.get("id").toString());
		try{

			String id = "";
			if(pd.containsKey("id")){
				id = pd.get("id").toString();
			}

			pd.put("code", GetPinyin.getPingYin(pd.get("name").toString()));
			pd.put("updated_at", Tools.getTime());
			pd.put("category_id", "1");
			pd.put("product_type", "1");
			pd.put("jump_type", "1");
			pd.put("version", "1");
			pd.put("default_repayment", "1");
			pd.put("default_interest", "0");
			pd.put("default_total_interest", "0");

			//新增加
			if(TextUtils.isEmpty(id)){

				id = tb_productService.findMaxId_product() + "";
				pd.put("id", id);
				pd.put("created_at", Tools.getTime());

				tb_productService.saveProduct(pd);

				String product_id = pd.get("id").toString();

				//每增加一个product记录，需要在statistic统计表加上对应的一条数据，初始字段为0
				pd.put("product_id", product_id);
				pd.put("join_count", 0);
				pd.put("view_count", 0);
				pd.put("version", "1");
				if(tb_productService.checkStatisticById(pd) == 0){
					tb_productService.saveStatistic(pd);
				}

				//product_tag插入多条数据
				List<PageData> productTagList = null;
				productTagList = tb_tagService.list(new Page());
				for(int i=0; i<productTagList.size(); i++){

					PageData pdTag = productTagList.get(i);
					System.out.println(pdTag.get("name") + "/" + pdTag.get("code"));
					if(TextUtils.isEmpty(pdTag.get("code").toString())){
						continue;
					}

					id = tb_productTagService.findMaxId() + "";

					PageData pdProductTag = new PageData();
					pdProductTag.put("id", id);
					pdProductTag.put("product_id", product_id);
					pdProductTag.put("tag_id", pdTag.get("id"));
					pdProductTag.put("tag_code", pdTag.get("code"));
					pdProductTag.put("order_num", pd.get("order_num"));
					pdProductTag.put("actived", pd.get("actived"));
					pdProductTag.put("created_at", Tools.getTime());
					pdProductTag.put("updated_at", Tools.getTime());
					tb_productTagService.save(pdProductTag);
				}

				msg = "保存成功";
			}
			//修改
			else{

				tb_productService.editProduct(pd);
				msg = "更新成功";
			}

		}catch(Exception e){
			e.printStackTrace();
			errInfo = "failed";
			msg = "保存失败" + e.getLocalizedMessage();
		}

		map.put("msg", msg);	
		map.put("errInfo", errInfo);
		return AppUtil.returnObject(new PageData(), map);
	}

	/**
	 * 保存---利率
	 */
	@RequestMapping(value="/saveInterest")
	public ModelAndView saveInterest(PrintWriter out) throws Exception{

		System.out.println("saveInterest");
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();

		try{
			pd.put("created_at", Tools.getTime());
			pd.put("updated_at", Tools.getTime());

			pd.put("version", 0);
			pd.put("actived", 1);

			tb_productService.saveInterest(pd);

			mv.addObject("msg","success");
		}catch(Exception e){
			e.printStackTrace();
			mv.addObject("msg","failed");
		}

		mv.setViewName("save_result");
		return mv;
	}

	/**
	 * 保存---统计
	 */
	@RequestMapping(value="/saveStatistic")
	public ModelAndView saveStatistic() throws Exception{

		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();

		try{
			pd.put("created_at", Tools.getTime());
			pd.put("updated_at", Tools.getTime());

			pd.put("version", 0);
			pd.put("actived", 1);

			tb_productService.saveStatistic(pd);

			mv.addObject("msg","success");
		}catch(Exception e){
			mv.addObject("msg","failed");
		}


		mv.setViewName("save_result");
		return mv;
	}
	
	/**
	 * 删除---利率
	 */
	@RequestMapping(value="/deleteInterest")
	public ModelAndView deleteInterest(PrintWriter out){
		logBefore(logger, "删除deleteInterest");
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		try{
			pd = this.getPageData();

			System.out.println("----删除deleteInterest------" + pd.get("id").toString());
			tb_productService.deleteInterest(pd.get("id").toString());
			out.write("success");
			out.close();
		} catch(Exception e){
			logger.error(e.toString(), e);
		}

		mv.addObject("msg","success");
		mv.setViewName("save_result");

		return mv;
	}

	/**
	 * 删除
	 */
	@RequestMapping(value="/delete")
	public void delete(PrintWriter out){
		logBefore(logger, "删除TB_Product");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "del")){return;} //校验权限
		PageData pd = new PageData();
		try{
			pd = this.getPageData();
			tb_productService.delete(pd);
			out.write("success");
			out.close();
		} catch(Exception e){
			logger.error(e.toString(), e);
		}
	}

	/**
	 * 删除---商品
	 */
	@RequestMapping(value="/deleteProduct")
	public void deleteProduct(PrintWriter out){
		logBefore(logger, "删除deleteProduct");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "del")){return;} //校验权限
		PageData pd = new PageData();
		try{
			pd = this.getPageData();

			System.out.println("-------"+pd.get("id").toString());
			tb_productService.deleteProduct(pd);
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
		logBefore(logger, "修改TB_Product");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "edit")){return null;} //校验权限
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		tb_productService.edit(pd);
		mv.addObject("msg","success");
		mv.setViewName("save_result");
		return mv;
	}

	/**
	 * 修改---利率
	 */
	@RequestMapping(value="/editInterest")
	public ModelAndView editInterest() throws Exception{
		logBefore(logger, "修改editInterest");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "edit")){return null;} //校验权限
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();

		pd.put("updated_at", Tools.getTime());

		tb_productService.editInterest(pd);

		mv.addObject("msg","editInterest");
		mv.setViewName("save_result");
		return mv;
	}

	/**
	 * 修改---统计
	 */
	@RequestMapping(value="/editStatistic")
	public ModelAndView editStatistic() throws Exception{
		logBefore(logger, "修改editStatistic");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "edit")){return null;} //校验权限
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();

		pd.put("updated_at", Tools.getTime());

		tb_productService.editStatistic(pd);

		mv.addObject("msg","success");
		mv.setViewName("save_result");
		return mv;
	}

	/**
	 * 列表
	 */
	@RequestMapping(value="/list")
	public ModelAndView list(Page page){
		logBefore(logger, "列表TB_Product");
		//if(!Jurisdiction.buttonJurisdiction(menuUrl, "cha")){return null;} //校验权限
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		try{
			pd = this.getPageData();
			page.setPd(pd);

			String searchData=null;
			List<PageData> varList;
			if(pd.containsKey("search_data")){
				searchData = pd.get("search_data").toString();
			}

			System.out.println("-----searchData------" + searchData);
			pd.put("search_data", searchData);
			page.setPd(pd);
			if(TextUtils.isEmpty(searchData)){
				varList = tb_productService.list_product(page);	//列出TB_ProductTag列表
//				varList = productService.list(page);	//列出TB_ProductTag列表
			}else{
				varList = tb_productService.list_product_search(searchData);
			}

//			for(int i=0; i<varList.size(); i++){
//
//				PageData pageData = varList.get(i);
//
//				System.out.println(pageData.get("name").toString() + ","+pageData.get("rate_type").toString());
//			}

			mv.setViewName("product/tb_product/tb_product_list");
			mv.addObject("varList", varList);
			mv.addObject("pd", pd);
			mv.addObject(Const.SESSION_QX,this.getHC());	//按钮权限
		} catch(Exception e){
			logger.error(e.toString(), e);
		}
		return mv;
	}

	/**
	 * 去新增页面---商品
	 */
	@RequestMapping(value="/goAddProduct")
	public ModelAndView goAddProduct(){
		logBefore(logger, "去新增TB_Product页面");
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		try {
			pd.put("id", tb_productService.findMaxId_product() + "");
			mv.setViewName("product/tb_product/tb_product_detail");
			mv.addObject("pd", pd);
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(e.toString(), e);
		}						

		System.out.println("pd.id" + pd.get("id"));

		return mv;
	}	

	/**
	 * 去新增页面---利率
	 */
	@RequestMapping(value="/goAddInterest")
	public ModelAndView goAddInterest(Page page){

		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		try {

			pd.put("id", tb_productService.findMaxId_interest());	//主键
			mv.setViewName("product/tb_product/tb_product_edit_interest");//

			mv.addObject("pd", pd);

			mv.addObject("msg","saveInterest");
			System.out.println("-----------"+pd.get("product_id").toString());
		} catch (Exception e) {
			logger.error(e.toString(), e);
		}						
		return mv;
	}	

	/**
	 * 去新增页面---统计
	 */
	@RequestMapping(value="/goAddStatistic")
	public ModelAndView goAddStatistic(){

		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		try {
			mv.setViewName("product/tb_product/tb_product_add_statistic");
			mv.addObject("pd", pd);
			mv.addObject("msg","saveStatistic");

		} catch (Exception e) {
			logger.error(e.toString(), e);
		}						
		return mv;
	}	

	/**
	 * 去修改页面---利率
	 */
	@RequestMapping(value="/goEditInterest")
	public ModelAndView goEditInterest(){

		logBefore(logger, "去修改goEditInterest页面");
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		try {

			List<PageData> varList = (List<PageData>) tb_productService.findById_interest(pd.get("id").toString());	//根据ID读取

			if(varList.size() > 0){
				pd = varList.get(0);
			}

			mv.setViewName("product/tb_product/tb_product_edit_interest");
			mv.addObject("msg", "editInterest");
			mv.addObject("pd", pd);

		} catch (Exception e) {
			logger.error(e.toString(), e);
		}						

		return mv;
	}	

	/**
	 * 去修改页面---统计
	 */
	@RequestMapping(value="/goEditStatistic")
	public ModelAndView goEditStatistic(){

		logBefore(logger, "去修改goEditStatistic页面");
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		try {

			List<PageData> varList = (List<PageData>) tb_productService.findById_statistic(pd.get("product_id").toString());	//根据ID读取

			if(varList.size() > 0){
				pd = varList.get(0);
			}

			mv.setViewName("product/tb_product/tb_product_edit_statistic");
			mv.addObject("msg", "editStatistic");
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
		logBefore(logger, "去修改TB_Product页面");
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		try {
			pd = tb_productService.findById(pd);	//根据ID读取
			mv.setViewName("product/tb_product/tb_product_edit");
			mv.addObject("msg", "edit");
			mv.addObject("pd", pd);
		} catch (Exception e) {
			logger.error(e.toString(), e);
		}						
		return mv;
	}	

	/**
	 * 图片浏览
	 */
	@RequestMapping(value="/goViewPicture")
	public ModelAndView goViewPicture(Page page){

		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		try {

			mv.setViewName("product/tb_product/picture_view");//

			mv.addObject("pd", pd);
		} catch (Exception e) {
			logger.error(e.toString(), e);
		}						
		return mv;
	}	

	/**
	 * 产品详情
	 */
	@RequestMapping(value = "/product_detail")
	public ModelAndView product_detail() throws Exception {

		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();

		String id = pd.get("id").toString();
		pd = tb_productService.findById_product(id);
		List<PageData> interestList = tb_productService.findByProductId_interest(id);
		List<PageData> statisticList = tb_productService.findById_statistic(id);


		for(int i=0; i<interestList.size(); i++){

			PageData pageData = interestList.get(i);
			if(pageData.containsKey("type")){

				if((boolean) pageData.get("type") == false){
					pageData.put("type", "日利率");
				}else{
					pageData.put("type", "月利率");
				}
			}
		}

		mv.setViewName("product/tb_product/tb_product_detail");
		mv.addObject("interestList", interestList);
		mv.addObject("statisticList", statisticList);
		mv.addObject("pd", pd);

		return mv;
	}

	/**
	 * 去新增页面---选择图片
	 */
	@RequestMapping(value="/goAddPicture")
	public ModelAndView goAddPicture(){

		logBefore(logger, "去新增Pictures页面");
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		try {
			currentId = pd.getString("id").toString();
			hanldeType = pd.getString("type").toString();
			mv.setViewName("product/tb_product/pictures_add");
			mv.addObject("pd", pd);
		} catch (Exception e) {
			logger.error(e.toString(), e);
		}						
		return mv;
	}	

	/**
	 * 新增
	 */
	@RequestMapping(value="/uploadPicture")
	@ResponseBody
	public Object savePicture(@RequestParam(required=false) MultipartFile file) throws Exception{

		logBefore(logger, "新增Pictures");

		Map<String,String> map = new HashMap<String,String>();
		PageData pd = this.getPageData();
		if(Jurisdiction.buttonJurisdiction(menuUrl, "add")){

			if (null != file && !file.isEmpty()) {

				if (file.getOriginalFilename().lastIndexOf(".") >= 0){

					CommonsMultipartFile cf= (CommonsMultipartFile)file; 
					DiskFileItem fi = (DiskFileItem)cf.getFileItem(); 
					File f = fi.getStoreLocation();

					String path = "C:/";
					String name = get32UUID() + ".png";
					File file2 = new File(path, name);  

					FileUtils.copyInputStreamToFile(file.getInputStream(), file2);  

					String picUrl = Const.ALIYUNCS + "banner/" + name;

					pd.put("id", currentId);
					pd.put("updated_at", Tools.getTime());
					if(hanldeType.equals("1")){
						pd.put("icon_url", picUrl);	
						tb_productService.editProductIcon(pd);
					}else{
						pd.put("process_img", picUrl);	
						tb_productService.editProductProcessImg(pd);
					}

					System.out.println("extName = " + f.getName());
					GetStartedSample.key = "banner/" + name;
					GetStartedSample.test(file2);
				}
			}else{
				System.out.println("上传失败");
			}

		}

		map.put("result", "ok");
		return AppUtil.returnObject(pd, map);
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

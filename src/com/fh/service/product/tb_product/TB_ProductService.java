package com.fh.service.product.tb_product;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.fh.dao.DaoSupport;
import com.fh.entity.Page;
import com.fh.util.PageData;


@Service("tb_productService")
public class TB_ProductService {

	@Resource(name = "daoSupport")
	private DaoSupport dao;

	/*
	 * 获取最大利率id + 1作为主键
	 */
	public int findMaxId_product()throws Exception{
		return (int) dao.findForObject("TB_ProductMapper.findMaxId_product", "") + 1;
	}

	/*
	 * 获取最大利率id + 1作为主键
	 */
	public int findMaxId_interest()throws Exception{
		return (int) dao.findForObject("TB_ProductMapper.findMaxId_interest", "") + 1;
	}

	/*
	 * 新增--商品
	 */
	public void saveProduct(PageData pd)throws Exception{
		dao.save("TB_ProductMapper.saveProduct", pd);
	}

	/*
	 * 新增--利率
	 */
	public void saveInterest(PageData pd)throws Exception{
		dao.save("TB_ProductMapper.saveInterest", pd);
	}

	/*
	 * 新增--统计
	 */
	public void saveStatistic(PageData pd)throws Exception{
		dao.save("TB_ProductMapper.saveStatistic", pd);
	}

	/*
	 * 判断--统计表是否有对应product_id数
	 */
	public int checkStatisticById(PageData pd)throws Exception{
		return (int) dao.findForObject("TB_ProductMapper.checkStatisticById", pd);
	}

	/*
	 * 新增
	 */
	public void save(PageData pd)throws Exception{
		dao.save("TB_ProductMapper.save", pd);
	}

	/*
	 * 删除
	 */
	public void delete(PageData pd)throws Exception{
		dao.delete("TB_ProductMapper.delete", pd);
	}

	/*
	 * 删除---货物
	 */
	public void deleteProduct(PageData pd)throws Exception{
		dao.delete("TB_ProductMapper.deleteProduct", pd);
	}

	/*
	 * 删除---利率
	 */
	public void deleteInterest(String id)throws Exception{
		dao.delete("TB_ProductMapper.deleteInterest", id);
	}

	/*
	 * 修改
	 */
	public void edit(PageData pd)throws Exception{
		dao.update("TB_ProductMapper.edit", pd);
	}

	/*
	 * 修改---商品
	 */
	public void editProduct(PageData pd)throws Exception{
		dao.update("TB_ProductMapper.editProduct", pd);
	}

	/*
	 * 修改---商品图片icon
	 */
	public void editProductIcon(PageData pd)throws Exception{
		dao.update("TB_ProductMapper.editProductIcon", pd);
	}

	/*
	 * 修改---商品图片process_img
	 */
	public void editProductProcessImg(PageData pd)throws Exception{
		dao.update("TB_ProductMapper.editProductProcessImg", pd);
	}

	/*
	 * 修改---利率
	 */
	public void editInterest(PageData pd)throws Exception{
		dao.update("TB_ProductMapper.editInterest", pd);
	}

	/*
	 * 修改---统计
	 */
	public void editStatistic(PageData pd)throws Exception{
		dao.update("TB_ProductMapper.editStatistic", pd);
	}

	/*
	 *产品列表
	 */
	public List<PageData> list_product(Page page)throws Exception{
		return (List<PageData>)dao.findForList("TB_ProductMapper.datalistPage", page);
	}

	/*
	 *产品列表--搜索
	 */
	public List<PageData> list_product_search(String data)throws Exception{
		return (List<PageData>)dao.findForList("TB_ProductMapper.list_product_search", "%"+data+"%");
	}

	/*
	 *利率列表
	 */
	public List<PageData> list_interest(Page page)throws Exception{
		return (List<PageData>)dao.findForList("TB_ProductMapper.list_interest", page);
	}

	/*
	 *列表(全部)
	 */
	public List<PageData> listAll(PageData pd)throws Exception{
		return (List<PageData>)dao.findForList("TB_ProductMapper.listAll", pd);
	}

	/*
	 * 通过id获取数据
	 */
	public PageData findById(PageData pd)throws Exception{
		return (PageData)dao.findForObject("TB_ProductMapper.findById", pd);
	}

	/*
	 * 通过name获取数据
	 */
	public PageData findByProductName(PageData pd)throws Exception{
		return (PageData)dao.findForObject("TB_ProductMapper.findByProductName", pd);
	}

	/*
	 * 通过id获取数据
	 */
	public PageData findById_product(String id)throws Exception{
		return (PageData)dao.findForObject("TB_ProductMapper.findById_product", id);
	}

	/*
	 * 通过id获取对应利息数据
	 */
	public List<PageData> findByProductId_interest(String product_id)throws Exception{
		return (List<PageData>)dao.findForList("TB_ProductMapper.findByProductId_interest", product_id);
	}

	/*
	 * 通过id获取对应---利息数据
	 */
	public List<PageData> findById_interest(String id)throws Exception{
		return (List<PageData>)dao.findForList("TB_ProductMapper.findById_interest", id);
	}

	/*
	 * 通过id获取对应---统计数据
	 */
	public List<PageData> findById_statistic(String id)throws Exception{
		return (List<PageData>)dao.findForList("TB_ProductMapper.findById_statistic", id);
	}

	/*
	 * 批量删除
	 */
	public void deleteAll(String[] ArrayDATA_IDS)throws Exception{
		dao.delete("TB_ProductMapper.deleteAll", ArrayDATA_IDS);
	}

	/*
	 * 修改---产品表排序信息
	 */
	public void editOrderNum(PageData pd)throws Exception{
		dao.update("TB_ProductMapper.editOrderNum", pd);
	}

}


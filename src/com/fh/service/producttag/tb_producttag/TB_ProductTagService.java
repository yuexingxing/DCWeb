package com.fh.service.producttag.tb_producttag;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.fh.dao.DaoSupport;
import com.fh.entity.Page;
import com.fh.util.PageData;


@Service("tb_producttagService")
public class TB_ProductTagService {

	@Resource(name = "daoSupport")
	private DaoSupport dao;
	
	/*
	 * 获取最大利率id + 1作为主键
	 */
	public int findMaxId()throws Exception{
		return (int) dao.findForObject("TB_ProductTagMapper.findMaxId", "") + 1;
	}
	
	/*
	* 新增
	*/
	public void save(PageData pd)throws Exception{
		dao.save("TB_ProductTagMapper.save", pd);
	}
	
	/*
	* 删除
	*/
	public void delete(PageData pd)throws Exception{
		dao.delete("TB_ProductTagMapper.delete", pd);
	}
	
	/*
	* 修改
	*/
	public void edit(PageData pd)throws Exception{
		dao.update("TB_ProductTagMapper.edit", pd);
	}
	
	/*
	*列表
	*/
	public List<PageData> list(Page page)throws Exception{
		return (List<PageData>)dao.findForList("TB_ProductTagMapper.datalistPage", page);
	}
	
	/*
	*列表--搜索
	*/
	public List<PageData> listSearch(String data)throws Exception{
		return (List<PageData>)dao.findForList("TB_ProductTagMapper.datalistSearchPage", data);
	}
	
	/*
	*列表(全部)
	*/
	public List<PageData> listAll(PageData pd)throws Exception{
		return (List<PageData>)dao.findForList("TB_ProductTagMapper.listAll", pd);
	}
	
	/*
	* 通过id获取数据
	*/
	public PageData findById(PageData pd)throws Exception{
		return (PageData)dao.findForObject("TB_ProductTagMapper.findById", pd);
	}
	
	/*
	* 批量删除
	*/
	public void deleteAll(String[] ArrayDATA_IDS)throws Exception{
		dao.delete("TB_ProductTagMapper.deleteAll", ArrayDATA_IDS);
	}
	
	/*
	 * 修改---产品tag表排序信息
	 */
	public void editOrderNum(PageData pd)throws Exception{
		dao.update("TB_ProductTagMapper.editOrderNum", pd);
	}
}


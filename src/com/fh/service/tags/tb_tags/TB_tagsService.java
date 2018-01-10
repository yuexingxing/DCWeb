package com.fh.service.tags.tb_tags;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.fh.dao.DaoSupport;
import com.fh.entity.Page;
import com.fh.util.PageData;


@Service("tb_tagsService")
public class TB_tagsService {

	@Resource(name = "daoSupport")
	private DaoSupport dao;
	
	/*
	 * 获取最大利率id + 1作为主键
	 */
	public int findMaxId_tags()throws Exception{
		return (int) dao.findForObject("TB_tagsMapper.findMaxId_tags", "") + 1;
	}
	
	/*
	* 新增
	*/
	public void save(PageData pd)throws Exception{
		dao.save("TB_tagsMapper.save", pd);
	}
	
	/*
	* 删除
	*/
	public void delete(PageData pd)throws Exception{
		dao.delete("TB_tagsMapper.delete", pd);
	}
	
	/*
	* 修改
	*/
	public void edit(PageData pd)throws Exception{
		dao.update("TB_tagsMapper.edit", pd);
	}
	
	/*
	*列表
	*/
	public List<PageData> list(Page page)throws Exception{
		return (List<PageData>)dao.findForList("TB_tagsMapper.datalistPage", page);
	}
	
	/*
	*列表(全部)
	*/
	public List<PageData> listAll(PageData pd)throws Exception{
		return (List<PageData>)dao.findForList("TB_tagsMapper.listAll", pd);
	}
	
	/*
	* 通过id获取数据
	*/
	public PageData findById(PageData pd)throws Exception{
		return (PageData)dao.findForObject("TB_tagsMapper.findById", pd);
	}
	
	/*
	* 批量删除
	*/
	public void deleteAll(String[] ArrayDATA_IDS)throws Exception{
		dao.delete("TB_tagsMapper.deleteAll", ArrayDATA_IDS);
	}
	
}


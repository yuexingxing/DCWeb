package com.fh.presenter.product.tb_product;

import java.util.List;

import com.fh.entity.SortOrderNum;
import com.fh.service.product.tb_product.TB_ProductService;
import com.fh.service.producttag.tb_producttag.TB_ProductTagService;
import com.fh.util.ExcelUtil;
import com.fh.util.PageData;
import com.fh.util.Tools;

public class ProductPresenter {

	public static final int ORDER_MAX_NUM = 1000;

	/**
	 * 修改排序号
	 * @param tb_productService
	 * @param tb_productTagService
	 * @param productList
	 * @param productTagList
	 * @param filePath
	 */
	public static boolean editOrderNum(
			TB_ProductService tb_productService, TB_ProductTagService tb_productTagService,
			String filePath){

		List<SortOrderNum> dataList = ExcelUtil.getExcelData(filePath);
		if(dataList == null || dataList.size() == 0){
			return false;
		}

		//修改product表order_num
		for(int i=0; i<dataList.size(); i++){

			PageData pageData2 = new PageData();
			SortOrderNum sortOrderNum = dataList.get(i);

			pageData2.put("name", sortOrderNum.getName());
			pageData2.put("order_num", ORDER_MAX_NUM - sortOrderNum.getProductNum());
			pageData2.put("updated_at", Tools.getTime());
			try {
				tb_productService.editOrderNum(pageData2);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}

		//修改product_tag表
		for(int k=0; k<dataList.size(); k++){

			SortOrderNum sortOrderNum = dataList.get(k);

			PageData pageData = new PageData();
			pageData.put("name", sortOrderNum.getName());
			pageData.put("updated_at", Tools.getTime());

			PageData productPageData = null;
			try {
				productPageData = (PageData) tb_productService.findByProductName(pageData);

				if(productPageData == null){
					continue;
				}
				pageData.put("product_id", productPageData.get("id"));

				for(int j=0; j<7; j++){

					pageData.put("tag_code", "00" + (j+2));
					pageData.put("order_num", (ORDER_MAX_NUM - sortOrderNum.getNum()[j]));
					tb_productTagService.editOrderNum(pageData);

					System.out.println("--修改product_tag表成功: product_id=" + pageData.get("product_id") + "/" 
							+ "order_num=" + pageData.get("order_num")+ "tag_code=" + pageData.get("tag_code"));
				}

			} catch (Exception e) {
				e.printStackTrace();
			}

		}

		return true;
	}
}

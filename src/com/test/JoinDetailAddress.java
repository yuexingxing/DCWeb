package com.test;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.fh.entity.DataInfo;
import com.fh.util.ExcelUtil;
import com.fh.util.WriteExcel;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

public class JoinDetailAddress {



	public static void main(String[] args) {
		// TODO Auto-generated method stub

		String file = "D:/雅迪电动车门店信息核准中n180116.xlsx";
		List<DataInfo> dataList = ExcelUtil.getExcelInfo(file);

		int len = dataList.size();
		for(int i=0; i<len; i++){

			DataInfo dataInfo = dataList.get(i);
			String prov = dataInfo.getData1();
			String city = dataInfo.getData2();
			String area = dataInfo.getData3();

			String addr = dataInfo.getData4();

			String realAddr = "";

			if(!addr.contains(area) && !addr.contains("区") && !addr.contains("省")){
				realAddr = area;
			}
			
			if(!addr.contains(city) && !addr.contains("市")){
				realAddr = city + realAddr;
			}
			
			if(!addr.contains(prov)){
				realAddr = prov + realAddr;
			}

			if(addr.contains(area)){

			}

			//浙江省	金华市	东阳市	南马
			//			if(!addr.contains(area) && !addr.contains("县") && !addr.contains("市")){//如果不包含县
			//				//				addr = area + addr;
			//				realAddr = area + addr;
			//			}
			//
			//			if(!addr.contains(city) && !addr.contains("市") && !addr.contains("省")){//如果不包含市
			//				//				addr = city + addr;
			//				realAddr = city + addr;
			//			}
			//
			//			if(!addr.contains(prov)){//如果不包含市
			//				//				addr = prov + addr;
			//				realAddr = prov + addr;
			//			}

			dataInfo.setData4(realAddr + addr);
			System.out.println(i + "-" + dataInfo.getData4());
		}
		
		List<Map> mapList = new ArrayList<Map>();
		len = dataList.size();
		for(int i=0; i<len; i++){

			DataInfo dataInfo = dataList.get(i);
			Map<String, String> map = new HashMap<String, String>();
			map.put("province", dataInfo.getData4());
			
			mapList.add(map);
		}

		WriteExcel.writeExcel(mapList, 1, "D:/aima1.xlsx");
	}

}

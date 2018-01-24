package com.test;

import java.io.BufferedReader;  
import java.io.IOException;  
import java.io.InputStreamReader;  
import java.io.UnsupportedEncodingException;  
import java.net.MalformedURLException;  
import java.net.URL;  
import java.net.URLConnection;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;
import org.codehaus.jackson.JsonNode;
import org.codehaus.jackson.map.ObjectMapper;

import com.fh.entity.DataInfo;
import com.fh.util.ExcelUtil;
import com.fh.util.WriteExcel;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;  

/**  
 * 获取经纬度 
 *  
 * @author jueyue 返回格式：Map<String,Object> map map.put("status",  
 * reader.nextString());//状态 map.put("result", list);//查询结果  
 * list<map<String,String>>  
 * 密钥:C0a9eecc5b366bde412021d4d7e5d8c4  
 */   
public class MapBaidu {  


	public static void main(String[] args) throws IOException {  
		MapBaidu getLatAndLngByBaidu = new MapBaidu();  

		//        Map<String,Double> map=getLatAndLngByBaidu.getLngAndLat("江苏省南京市浦口区新马路184号");  
		//        System.out.println("经度："+map.get("lng")+"---纬度："+map.get("lat")); 

		//		getGeocoderLatitude("江苏省南京市浦口区新马路184号");
		//		getposition("29.490295", "106.486654");


		List<Map> mapList = new ArrayList<Map>();
		List<DataInfo> dataList = ExcelUtil.readAiMaExcel();

		int len = dataList.size();
		for(int i=0; i<len; i++){

			DataInfo dataInfo = dataList.get(i);
			String add = getAdd(dataInfo.getLat(), dataInfo.getLon()); 
			JSONObject jsonObject = JSONObject.fromObject(add); 
			JSONArray jsonArray = JSONArray.fromObject(jsonObject.getString("addrList")); 
			JSONObject j_2 = JSONObject.fromObject(jsonArray.get(0)); 
			String allAdd = j_2.getString("admName"); 
			String arr[] = allAdd.split(","); 

			Map<String, String> map = new HashMap<String, String>();
			map.put("lat", dataInfo.getLat());
			map.put("lon", dataInfo.getLon());
			if(arr.length > 2){
				System.out.println("省："+arr[0]+"\n市："+arr[1]+"\n区："+arr[2]); 
				map.put("province", arr[0]);
				map.put("city", arr[1]);
				map.put("area", arr[2]);
			}else{
				System.out.println("未查到数据");
				map.put("province", "-");
				map.put("city", "-");
				map.put("area", "-");
			}

			mapList.add(map);
		}

		WriteExcel.writeExcel(mapList, 3, "D:/anim1.xlsx");
	}  

	public static String getAdd(String log, String lat ){ 
		//lat 小 log 大 
		//参数解释: 纬度,经度 type 001 (100代表道路，010代表POI，001代表门址，111可以同时显示前三项) 
		String urlString = "http://gc.ditu.aliyun.com/regeocoding?l="+lat+","+log+"&type=010"; 
		//		System.out.println(urlString);
		String res = "";   
		try {   
			URL url = new URL(urlString);  
			java.net.HttpURLConnection conn = (java.net.HttpURLConnection)url.openConnection();  
			conn.setDoOutput(true);  
			conn.setRequestMethod("POST");  
			java.io.BufferedReader in = new java.io.BufferedReader(new java.io.InputStreamReader(conn.getInputStream(),"UTF-8"));  
			String line;  
			while ((line = in.readLine()) != null) {  
				res += line+"\n";  
			}  
			in.close();  
		} catch (Exception e) {  
			System.out.println("error in wapaction,and e is " + e.getMessage());  
		}  
		System.out.println(res); 
		return res;  
	} 

	public static void getGeocoderLatitude(String address){  
		BufferedReader in = null;  
		try {  
			address = URLEncoder.encode(address, "UTF-8");  
			URL tirc = new URL("http://api.map.baidu.com/geocoder?address="+ address +"&output=json&key="+"7d9fbeb43e975cd1e9477a7e5d5e192a");  
			in = new BufferedReader(new InputStreamReader(tirc.openStream(),"UTF-8"));  
			String res;  
			StringBuilder sb = new StringBuilder("");  
			while((res = in.readLine())!=null){  
				sb.append(res.trim());  
			}  
			String str = sb.toString();  

			//			System.out.println(str);
			if(StringUtils.isNotEmpty(str)){  
				int lngStart = str.indexOf("lng\":");  
				int lngEnd = str.indexOf(",\"lat");  
				int latEnd = str.indexOf("},\"precise");  
				if(lngStart > 0 && lngEnd > 0 && latEnd > 0){  
					String lng = str.substring(lngStart+5, lngEnd);  
					String lat = str.substring(lngEnd+7, latEnd);  

				}  
			}  
		}catch (Exception e) {  
			e.printStackTrace();  
		}finally{  
			try {  
				in.close();  
			} catch (IOException e) {  
				e.printStackTrace();  
			}  
		}  
	} 

	public static void getposition(String latitude,String longitude) throws MalformedURLException{

		BufferedReader in = null;
		URL tirc = new URL("http://api.map.baidu.com/geocoder?location="+ latitude+","+longitude+"&output=json&key="+"702632E1add3d4953d0f105f27c294b9");  
		try {
			in = new BufferedReader(new InputStreamReader(tirc.openStream(),"UTF-8"));
			String res;  
			StringBuilder sb = new StringBuilder("");  
			while((res = in.readLine())!=null){  
				sb.append(res.trim());  
			}  
			String str = sb.toString();
			//			System.out.println(str);
			ObjectMapper mapper = new ObjectMapper();
			if(StringUtils.isNotEmpty(str)){  
				JsonNode jsonNode = mapper.readTree(str);
				jsonNode.findValue("status").toString();
				JsonNode resultNode = jsonNode.findValue("result");
				JsonNode locationNode = resultNode.findValue("formatted_address");
				System.out.println(locationNode);
			}  

		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}  


	}

}  
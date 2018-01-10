package com.fh.util;

import java.io.*;
import java.util.ArrayList;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.apache.http.util.TextUtils;
import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.xssf.usermodel.XSSFCell;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

import com.fh.entity.SortOrderNum;

/**
 * @author Javen
 * @Email zyw205@gmail.com
 * 
 */
public class ExcelUtil {


	public static List<SortOrderNum> testXLSX(String file){

		List<SortOrderNum> dataList = new ArrayList<SortOrderNum>();
		InputStream is;
		try {
			is = new FileInputStream(file);

			XSSFWorkbook xssfWorkbook = new XSSFWorkbook(is);
			// 获取每一个工作薄
			for (int numSheet = 0; numSheet < xssfWorkbook.getNumberOfSheets(); numSheet++) {
				XSSFSheet xssfSheet = xssfWorkbook.getSheetAt(numSheet);
				if (xssfSheet == null) {
					continue;
				}
				// 获取当前工作薄的每一行
				for (int rowNum = 0; rowNum <= xssfSheet.getLastRowNum(); rowNum++) {
					XSSFRow xssfRow = xssfSheet.getRow(rowNum);
					if (xssfRow != null) {
						XSSFCell name = xssfRow.getCell(0);
						//读取第一列数据
						XSSFCell num1 = xssfRow.getCell(2);
						XSSFCell num2 = xssfRow.getCell(3);
						XSSFCell num3 = xssfRow.getCell(4);
						XSSFCell num4 = xssfRow.getCell(5);
						XSSFCell num5 = xssfRow.getCell(6);
						XSSFCell num6 = xssfRow.getCell(7);
						XSSFCell num7 = xssfRow.getCell(8);

						XSSFCell productOrderNum = xssfRow.getCell(9);
						//读取第三列数据
						//需要转换数据的话直接调用getValue获取字符串

						SortOrderNum sortOrderNum = handleData(name.toString(), num1.toString(), num2.toString(), num3.toString(),
								num4.toString(), num5.toString(), num6.toString(), num7.toString(), productOrderNum.toString());
						if(sortOrderNum != null){
							dataList.add(sortOrderNum);
						}
					}
				}
			}

		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return dataList;
	}

	//转换数据格式
	private String getValue(XSSFCell xssfRow) {

		if (xssfRow.getCellType() == xssfRow.CELL_TYPE_BOOLEAN) {
			return String.valueOf(xssfRow.getBooleanCellValue());
		} else if (xssfRow.getCellType() == xssfRow.CELL_TYPE_NUMERIC) {
			return String.valueOf(xssfRow.getNumericCellValue());
		} else {
			return String.valueOf(xssfRow.getStringCellValue());
		}
	}

	public static List<SortOrderNum> testXLS(String file){

		List<SortOrderNum> dataList = new ArrayList<SortOrderNum>();
		InputStream is;
		try {
			is = new FileInputStream(file);

			HSSFWorkbook hssfWorkbook = new HSSFWorkbook(is);
			// 获取每一个工作薄
			for (int numSheet = 0; numSheet < hssfWorkbook.getNumberOfSheets(); numSheet++) {
				HSSFSheet hssfSheet = hssfWorkbook.getSheetAt(numSheet);
				if (hssfSheet == null) {
					continue;
				}
				// 获取当前工作薄的每一行
				for (int rowNum = 0; rowNum <= hssfSheet.getLastRowNum(); rowNum++) {
					HSSFRow hssfRow = hssfSheet.getRow(rowNum);
					if (hssfRow != null) {
						HSSFCell name = hssfRow.getCell(0);
						//读取第一列数据
						HSSFCell num1 = hssfRow.getCell(2);
						HSSFCell num2 = hssfRow.getCell(3);
						HSSFCell num3 = hssfRow.getCell(4);
						HSSFCell num4 = hssfRow.getCell(5);
						HSSFCell num5 = hssfRow.getCell(6);
						HSSFCell num6 = hssfRow.getCell(7);
						HSSFCell num7 = hssfRow.getCell(8);

						HSSFCell productOrderNum = hssfRow.getCell(9);
						//读取第三列数据
						//需要转换数据的话直接调用getValue获取字符串

						SortOrderNum sortOrderNum = handleData(name.toString(), num1.toString(), num2.toString(), num3.toString(),
								num4.toString(), num5.toString(), num6.toString(), num7.toString(), productOrderNum.toString());
						if(sortOrderNum != null){
							dataList.add(sortOrderNum);
						}
					}
					System.out.println();
				}
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return dataList;
	}

	// 转换数据格式
	public static String getValue(HSSFCell hssfCell) {
		if (hssfCell.getCellType() == hssfCell.CELL_TYPE_BOOLEAN) {
			return String.valueOf(hssfCell.getBooleanCellValue());
		} else if (hssfCell.getCellType() == hssfCell.CELL_TYPE_NUMERIC) {
			return String.valueOf(hssfCell.getNumericCellValue());
		} else {
			return String.valueOf(hssfCell.getStringCellValue());
		}
	}


	public static SortOrderNum handleData(String name, String num1, String num2, String num3,
			String num4, String num5, String num6, String num7, String productNum){

		SortOrderNum sortOrderNum = null;
		if(TextUtils.isEmpty(num1) || TextUtils.isEmpty(num2) || TextUtils.isEmpty(num3) 
				|| TextUtils.isEmpty(num4) || TextUtils.isEmpty(num5) 
				|| TextUtils.isEmpty(num6) || TextUtils.isEmpty(num7) || TextUtils.isEmpty(productNum)){
			return null;
		}

		if(!isNumeric(num1) || !isNumeric(num2) || !isNumeric(num3) || !isNumeric(num4) 
				|| !isNumeric(num5) || !isNumeric(num6) || !isNumeric(num7) || !isNumeric(productNum)){
			return null;
		}

		try{

			int[] num = {(int) Double.parseDouble(num1),(int) Double.parseDouble(num2),
					(int) Double.parseDouble(num3),(int) Double.parseDouble(num4),
					(int) Double.parseDouble(num5),(int) Double.parseDouble(num6),
					(int) Double.parseDouble(num7)};
			
			sortOrderNum = new SortOrderNum();
			sortOrderNum.setName(name);
			sortOrderNum.setNum(num);

			sortOrderNum.setNum1((int) Double.parseDouble(num1));
			sortOrderNum.setNum2((int) Double.parseDouble(num2));
			sortOrderNum.setNum3((int) Double.parseDouble(num3));
			sortOrderNum.setNum4((int) Double.parseDouble(num4));
			sortOrderNum.setNum5((int) Double.parseDouble(num5));
			sortOrderNum.setNum6((int) Double.parseDouble(num6));
			sortOrderNum.setNum7((int) Double.parseDouble(num7));

			sortOrderNum.setProductNum((int) Double.parseDouble(productNum));

		}catch(Exception e){
			e.printStackTrace();
		}

		return sortOrderNum;
	}

	/**
	 * 利用正则表达式判断字符串是否是数字
	 * @param str
	 * @return
	 */
	public static boolean isNumeric(String str){

		Pattern pattern = Pattern.compile(".*[0-9]*");
		Matcher isNum = pattern.matcher(str);
		if(!isNum.matches() ){
			return false;
		}

		return true;
	}

	public static List<SortOrderNum> getExcelData(String filePath){

		System.out.println("------" + filePath + "-------");
		if(filePath.endsWith(".xls")){
			return testXLS(filePath);
		}else if(filePath.endsWith(".xlsx")){
			return testXLSX(filePath);
		}else{
			System.out.println("文件格式错误");
			return null;
		}
	}

	public static void main(String[] args) {  

		String file = "D:/通用--导入排序的数据格式.xlsx";

		if(file.endsWith(".xls")){
			List<SortOrderNum> dataList = testXLS(file);
		}else if(file.endsWith(".xlsx")){
			List<SortOrderNum> dataList = testXLSX(file);
		}else{
			System.out.println("文件格式错误");
		}

	}  

}

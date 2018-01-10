package com.fh.config;

import java.util.Properties;
import java.util.Set;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.config.PropertyPlaceholderConfigurer;

/*
 * 属性配置文件加密，这里做根据ENC:前缀做解密 com.fh.config.ENCPropertyPlaceholderConfigurer
 * 
 */
public class ENCPropertyPlaceholderConfigurer extends PropertyPlaceholderConfigurer {
	/**
	 * 待解密的字符串前缀
	 */
	private static final String ENC_STR = "ENC@";

	/** 
	 * 重写父类方法，解密指定属性名对应的属性值
	 */
	@Override
	protected String convertProperty(String propertyName, String propertyValue) {
		// if (isEncryptPropertyVal(propertyValue)) {
		// try {
		// String tmp = propertyValue.replace(ENC_STR, "");
		// String tmp2 = AES.desEncrypt(tmp);// 调用解密方法
		// return tmp2;
		// } catch (Exception e) {
		// return "";
		// }
		// } else {
		// return propertyValue;
		// }

		return propertyValue;

	}

	/** 
	 * 判断属性值是否需要解密，约定需要解密的[属性值 Value ]用【ENC@】开头 
	 */
	private boolean isEncryptPropertyVal(String propertyValue) {
		return StringUtils.startsWith(propertyValue, ENC_STR);
	}
}

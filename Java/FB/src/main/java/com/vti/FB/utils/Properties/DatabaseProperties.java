package com.vti.FB.utils.Properties;

import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.Properties;

public class DatabaseProperties {
	public static final String RESOURCES_PATH = "D:\\VTI course\\Rocket_12\\Java\\FB\\src\\main\\resource\\database.properties";
	private Properties properties;

	public DatabaseProperties() throws FileNotFoundException, IOException {
		properties = new Properties();
		properties.load(new FileInputStream(RESOURCES_PATH));
	}

	public String getValue(String key) {
		return properties.getProperty(key);
	}
}

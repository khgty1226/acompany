package com.bteam.proj.chats.config;

import org.springframework.beans.BeansException;
import org.springframework.context.ApplicationContext;
import org.springframework.context.ApplicationContextAware;
import org.springframework.stereotype.Component;

@Component
public class SpringContext implements ApplicationContextAware {
	
	private static ApplicationContext context;
	
	public static<T extends Object> T getBean(Class<T> beanClass) {
		return context.getBean(beanClass);
	}
	
	@Override
	public void setApplicationContext(ApplicationContext applicationContext) throws BeansException {
		// TODO Auto-generated method stub
		setContext(context);
	}
	
	private static synchronized void setContext(ApplicationContext context) {
		SpringContext.context = context;
	}

}

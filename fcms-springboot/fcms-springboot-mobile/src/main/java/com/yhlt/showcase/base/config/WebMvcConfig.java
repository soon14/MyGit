package com.yhlt.showcase.base.config;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.env.Environment;
import org.springframework.http.MediaType;
import org.springframework.http.converter.ByteArrayHttpMessageConverter;
import org.springframework.http.converter.HttpMessageConverter;
import org.springframework.http.converter.StringHttpMessageConverter;
import org.springframework.http.converter.json.MappingJackson2HttpMessageConverter;
import org.springframework.web.servlet.config.annotation.DefaultServletHandlerConfigurer;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurationSupport;

import com.yhlt.showcase.base.security.interceptor.MobileLoginContextInterceptor;

/**
 * 继承WebMvcConfigurationSupport继承并重写addInterceptor方法用于添加配置拦截器
 * @author wangyoutao
 */
@Configuration
public class WebMvcConfig extends WebMvcConfigurationSupport {
	
	@Autowired
	private Environment env;
	
    @Override
    public void addInterceptors(InterceptorRegistry registry) {
        //添加拦截器
        registry.addInterceptor(new MobileLoginContextInterceptor())
        .addPathPatterns("/**")
        .excludePathPatterns(
    		"/",
    		"/error/**",
    		"/login/**",
    		"/mobile/venue/user/saveRegister",
    		"/mobile/information/info/showImage",
    		"/mobile/information/info/showContentImage",
    		"/mobile/venue/user/userHeadImg",
    		"/mobile/message/image/showImage",
    		"/mobile/chatmessage/showImage",
    		"/mobile/chatmessage/showHeadImage",
    		"/mobile/chatmessage/showContentImage",
    		"/mobile/venue/view/showImg",
    		"/mobile/image/showImage",
    		"/mobile/venue/equipment/showImg",
    		"/mobile/checklistbill/getBillSignature",
    		"/mobile/checklistbillfile/showImage",
    		"/mobile/video/main/showVideoImage",
    		"/mobile/video/main/videoPlay",
    		"/mobile/activity/item/itemHeadImg",
    		"/mobile/user/view/showImg"
        );
        super.addInterceptors(registry);
    }
    

    @Override
    public void configureDefaultServletHandling(DefaultServletHandlerConfigurer configurer) {
        configurer.enable();
    }

    
    @Override
    protected void configureMessageConverters(List<HttpMessageConverter<?>> converters) {
    	List<MediaType> supportedMediaTypes = new ArrayList<>();
    	supportedMediaTypes.add(MediaType.APPLICATION_JSON_UTF8);
    	
    	ByteArrayHttpMessageConverter converter1 = new ByteArrayHttpMessageConverter();
    	
    	StringHttpMessageConverter converter2 = new StringHttpMessageConverter();
    	converter2.setSupportedMediaTypes(supportedMediaTypes);
    	
    	MappingJackson2HttpMessageConverter converter3 = new MappingJackson2HttpMessageConverter();
    	converter3.setSupportedMediaTypes(supportedMediaTypes);
    	
    	converters.add(converter1);
    	converters.add(converter2);
    	converters.add(converter3);
    	
    	super.configureMessageConverters(converters);
    }
    
}
package com.bteam.proj.chats.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.socket.config.annotation.EnableWebSocket;
import org.springframework.web.socket.config.annotation.WebSocketConfigurer;
import org.springframework.web.socket.config.annotation.WebSocketHandlerRegistry;

import com.bteam.proj.chats.web.ChatHandler;
import com.bteam.proj.chats.web.CustomHandshakeInterceptor;

@Configuration
@EnableWebSocket
public class WebSocketConfig implements WebSocketConfigurer {
    @Override
    public void registerWebSocketHandlers(WebSocketHandlerRegistry registry) {
        registry.addHandler(new ChatHandler(), "/chat").addInterceptors(new CustomHandshakeInterceptor()).setAllowedOrigins("*"); // WebSocket 핸들러 등록
    }

    
}
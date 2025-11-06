package com.bteam.proj.chats.web;

import java.time.ZonedDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.bteam.proj.chats.vo.MessageVO;
import com.bteam.proj.chats.vo.MessageVO.CommandType;
import com.bteam.proj.chats.vo.MessageVO.DataType;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;

public class MessageBuilder {
	private static final Logger logger = LoggerFactory.getLogger(MessageBuilder.class);
	private static ObjectMapper messageMapper = new ObjectMapper();

	private String subject;
	private DataType dataType;
	private CommandType commandType;
	private Map<String, List<String>> data = new HashMap<>();

	public MessageBuilder() {
	}

	public MessageBuilder setSubject(String subject) {
		this.subject = subject;
		return this;
	}

	public MessageBuilder setDataType(DataType dataType) {
		this.dataType = dataType;
		return this;
	}

	public MessageBuilder setCommandType(CommandType commandType) {
		this.commandType = commandType;
		return this;
	}

	public MessageBuilder addData(String key, String value) {
		if (!data.containsKey(key)) {
			data.put(key, new ArrayList<>());
		}
		data.get(key).add(value);
		return this;
	}

	public MessageBuilder setData(Map<String, List<String>> datas) {
		this.data = datas;
		return this;
	}
	
	public MessageBuilder clearData() {
		this.data = new HashMap<String, List<String>>();
		return this;
	}

	public void setFromMessageVO(MessageVO source) {
		this.subject = source.getSubject();
		this.dataType = source.getDataType();
		this.commandType = source.getCommandType();
		this.data = source.getData();
	}

	public void setFromPayLoad(String payload) {
	    try {
	        Map<String, Object> payloadMap = messageMapper.readValue(payload, new TypeReference<Map<String, Object>>() {});
	        this.subject = (String) payloadMap.get("subject");
	        this.dataType = MessageVO.DataType.valueOf((String) payloadMap.get("dataType"));
	        this.commandType = MessageVO.CommandType.valueOf((String) payloadMap.get("commandType"));
	        Map<String, List<String>> map = (Map<String, List<String>>) payloadMap.get("data");
			this.data = map;
	        logger.info("converted Payload from {} is done !", payload);
	    } catch (JsonProcessingException e) {
	        logger.error("Error while processing JSON payload", e);
	    }
	}

	public MessageVO build() {
		if (subject != null && dataType != null && commandType != null && data != null) {
			return new MessageVO(subject, dataType, commandType, data);
		} else {
			logger.error("Some of the data is null in the MessageBuilder");
			return null;
		}
	}

	public static String parseToJson(MessageBuilder mb) {
		try {
			return messageMapper.writeValueAsString(mb.build());
		} catch (JsonProcessingException e) {
			logger.error("Error while parsing MessageBuilder to JSON", e);
			return null;
		}
	}
	
	public static ZonedDateTime chatDatefrom(String isoDateString) {
        // Define a custom formatter to handle the offset and time zone ID
        DateTimeFormatter customFormatter = DateTimeFormatter.ofPattern("yyyy-MM-dd'T'HH:mm:ss.SSSXXX['['VV']']");

        // Parse the ISO string to ZonedDateTime
        ZonedDateTime zonedDateTime = ZonedDateTime.parse(isoDateString, customFormatter);
        
        return zonedDateTime;

	}
	

	@Override
	public String toString() {
		return "MessageBuilder [subject=" + subject + ", dataType=" + dataType + ", commandType=" + commandType
				+ ", data=" + data + "]";
	}
}
package com.bteam.proj.chats.vo;

import java.util.List;
import java.util.Map;
import com.fasterxml.jackson.annotation.JsonCreator;
import com.fasterxml.jackson.annotation.JsonValue;


public class MessageVO {
	
	public enum DataType{
		ROOM,MEMBER,CHAT,IMAGE
	}
	public enum CommandType{
		CREATE,RETRIEVE,UPDATE,DELETE
	}
    @JsonCreator
    public static DataType dataTypeFromString(String value) {
        return DataType.valueOf(value.toUpperCase());
    }

    @JsonCreator
    public static CommandType commandTypeFromString(String value) {
        return CommandType.valueOf(value.toUpperCase());
    }

    public String dataTypeToString() {
        return this.dataType.toString().toLowerCase();
    }

    public String commandTypeToString() {
        return this.commandType.toString().toLowerCase();
    }

	
	public MessageVO(String subject, DataType dataType, CommandType commandType, Map<String, List<String>> data) {
		super();
		this.subject = subject;
		this.dataType = dataType;
		this.commandType = commandType;
		this.data = data;
	}
	public MessageVO() {}
	
	private String subject;
	private DataType dataType;
	private CommandType commandType;
	private Map<String, List<String>> data;
	public String getSubject() {
		return subject;
	}
	public void setSubject(String subject) {
		this.subject = subject;
	}
	public DataType getDataType() {
		return dataType;
	}
	public void setDataType(DataType dataType) {
		this.dataType = dataType;
	}
	public CommandType getCommandType() {
		return commandType;
	}
	public void setCommandType(CommandType commandType) {
		this.commandType = commandType;
	}
	public Map<String, List<String>> getData() {
		return data;
	}
	public void setData(Map<String, List<String>> data) {
		this.data = data;
	}
	@Override
	public String toString() {
		return "MessageVO [subject=" + subject + ", dataType=" + dataType + ", commandType=" + commandType + ", data="
				+ data + "]";
	}

	
}

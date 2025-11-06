package com.bteam.proj.chats.web;

import java.util.Comparator;
import java.util.LinkedList;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.socket.TextMessage;

import com.bteam.proj.chats.service.ChatLogsServiceImpl;
import com.bteam.proj.chats.service.ChatroomMembersServiceImpl;
import com.bteam.proj.chats.service.ChatroomsServiceImpl;
import com.bteam.proj.chats.vo.ChatLogsVO;
import com.bteam.proj.chats.vo.ChatroomMembersVO;
import com.bteam.proj.chats.vo.ChatroomsVO;
import com.bteam.proj.chats.vo.MessageVO;
import com.bteam.proj.chats.vo.MessageVO.CommandType;
import com.bteam.proj.chats.vo.MessageVO.DataType;
import com.bteam.proj.member.service.MemberService;
import com.bteam.proj.member.vo.MemberVO;
import com.fasterxml.jackson.databind.ObjectMapper;

@Controller
@RequestMapping("/retrieve")
public class ChatRetrieveController {
	private static final Logger logger = LoggerFactory.getLogger(ChatsController.class);
	protected ObjectMapper mapper = new ObjectMapper();

	private static ChatRoomManager crm = ChatRoomManager.getInstance();

	@Autowired
	private ChatLogsServiceImpl cls;
	@Autowired
	private ChatroomsServiceImpl crs;
	@Autowired
	private ChatroomMembersServiceImpl cms;
	@Autowired
	private MemberService ms;
	
	
	@RequestMapping("/members")
	public int getMembersIn(@RequestBody MessageVO message) {
		String chatroomNo = message.getData().get("ChatroomNo").get(0);
		String memberNo = message.getSubject();
		
		try {
			List<ChatroomMembersVO> chatmems = cms.getChatroomMembersByChatroomNo(chatroomNo);
			
			List<MemberVO> mems = new LinkedList<MemberVO>();
			for(ChatroomMembersVO cmVO : chatmems) {
				String cmVoNo = cmVO.getChatroomNo();
				mems.add(ms.getMember(cmVoNo));
			}
			
			MessageBuilder mb = new MessageBuilder();
			mb.setSubject(memberNo);
			mb.setDataType(DataType.MEMBER);
			mb.setCommandType(CommandType.UPDATE);
			
			for(MemberVO mem : mems) {
				mb.clearData().addData("memberNo", mem.getMemName())
				.addData("MemberName", mem.getMemName())
				.addData("MemberTeam", mem.getMemTeam())
				.addData("MemberDept",mem.getMemDept())
				.addData("MemberEmail", mem.getMemEmail())
				.addData("MemberPhone", mem.getMemPhone())
				.addData("ChatroomNo", chatroomNo);					
				
				String shipment = MessageBuilder.parseToJson(mb);
				crm.getSessionOf(memberNo).sendMessage(new TextMessage(shipment));
			}
			return mems.size();
		}catch(Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
	
	@RequestMapping("/chatroom")
	public int getChatroomInfo(@RequestBody MessageVO message ) {
		String chatroomNo = message.getData().get("ChatroomNo").get(0),memberNo=message.getSubject();
		try {
			ChatroomsVO cri = crs.getChatroom(chatroomNo);
			MessageBuilder mb = new MessageBuilder();
			mb.setSubject(memberNo).setCommandType(CommandType.UPDATE).setDataType(DataType.ROOM)
			.addData("ChatroomNo",cri.getChatroomNo())
			.addData("ChatroomName",cri.getChatroomName())
			.addData("ChatroomOwner", cri.getChatroomOwner())
			.addData("ChatroomDate", cri.getOpenDatetime().toString());
			
			String shipment= MessageBuilder.parseToJson(mb);
			crm.getSessionOf(memberNo).sendMessage(new TextMessage(shipment));
			return 1;
		}catch(Exception e){
			e.printStackTrace();
		}
		
		return -1;
	}
	
	@RequestMapping("/chat")
	public int getChatsIn(@RequestBody String chatroomNo,String memberNo) {
		try {
			List<ChatLogsVO> chats = cls.getLogsInByNo(chatroomNo);
			//order by time
			chats.sort(Comparator.comparing(ChatLogsVO::getChatTime));
			MessageBuilder mb= new MessageBuilder();
			mb.setSubject(memberNo).setDataType(DataType.CHAT).setCommandType(CommandType.UPDATE);
			for(ChatLogsVO chat : chats) {
			mb.clearData();
			mb.addData("ChatroomNo", chat.getChatroomNo())
			.addData("ChatContent", chat.getChatContent())
			.addData("ChatMemberNo", chat.getMemNo())
			.addData("ChatDate", chat.getChatTime().toString());
			
			String shipment= MessageBuilder.parseToJson(mb);
			crm.getSessionOf(memberNo).sendMessage(new TextMessage(shipment));
			}
			
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		return -1;
	}
	
}

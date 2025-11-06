package com.bteam.proj.chats.web;

import java.time.ZonedDateTime;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.socket.WebSocketSession;

import com.bteam.proj.chats.config.ZonedDateTimeTypeHandler;
import com.bteam.proj.chats.service.ChatLogsService;
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
@RequestMapping("/create")
public class ChatCreateController {
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
	
	
		@RequestMapping("/chat")
		public int createChat(@RequestBody MessageVO message){	
			ChatLogsVO log = new ChatLogsVO();
			try {
				String subject = message.getSubject();
				log.setMemNo(subject);
				
				String content = message.getData().get("ChatroomNo").get(0);
				log.setChatContent(content);
				
				String dateTimeString = message.getData().get("ChatDate").get(0);
				ZonedDateTime date = MessageBuilder.chatDatefrom(dateTimeString);
				log.setChatTime(date);
				
				cls.insertChatLog(log);
				
				
				return 1;
			}catch(Exception e) {
				return 0;
			}
			
			
		}
		
		@RequestMapping("/chatroom")
		public int createChatroom(@RequestBody MessageVO message) {
			ChatroomsVO roomvo = new ChatroomsVO();
			try {
				String subject = message.getSubject();
				String chatroomName = message.getData().get("ChatroomName").get(0);
				ZonedDateTime chatroomDate = ZonedDateTime.now();
				String chatroomNo = crs.roomNoFrom(subject, chatroomName,chatroomDate) ;
				
				roomvo.setChatroomName(chatroomName);
				roomvo.setChatroomNo(chatroomNo);
				roomvo.setChatroomOwner(subject);
				roomvo.setClosed(false);
				roomvo.setOpenDatetime(chatroomDate);
				
				crs.insertByVo(roomvo);
				
				return 1;
			}catch(Exception e) {
				return 0;
			}
		}
		
		
		//after invitation is succesfully done , join the member into the room
		@RequestMapping("/member")
		public int addMemberIntoRoom(@RequestBody MessageVO message) {

			try {
				String targetMemberNo = message.getSubject();
				String toChatroomNo = message.getData().get("ChatroomNo").get(0);
				
				//if the member is not deleted and the chatroom is not closed, insert member into there
				if(ms.getMember(targetMemberNo).getMemDelYn()=="N" 
						&& !crs.getChatroom(toChatroomNo).isClosed())
				cms.insertMemberByNo(targetMemberNo, toChatroomNo);
				
				//broadcast to the members in that room
				MemberVO targetMember = ms.getMember(targetMemberNo);
				MessageBuilder mb = new MessageBuilder();
				mb.setSubject(targetMemberNo);
				mb.setCommandType(CommandType.CREATE);
				mb.setDataType(DataType.MEMBER);
				mb.addData("MemberNo",targetMember.getMemNo());
				mb.addData("MemberName", targetMember.getMemName());
				mb.addData("MemberTeam",targetMember.getMemTeam());
				mb.addData("MemberDept", targetMember.getMemDept());
				mb.addData("MemberPhone", targetMember.getMemPhone());
				mb.addData("MemberEmail", targetMember.getMemEmail());
				
				crm.getChatroom(toChatroomNo).sendAll(mb.build());
				
				
				
				return 1;
			}catch(Exception e){
				return 0;
			}
		}
		
}
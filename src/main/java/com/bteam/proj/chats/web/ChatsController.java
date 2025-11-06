package com.bteam.proj.chats.web;

import java.util.LinkedList;
import java.util.List;
import java.util.Locale;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.CookieValue;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import com.bteam.proj.chats.service.ChatLogsServiceImpl;
import com.bteam.proj.chats.service.ChatroomMembersServiceImpl;
import com.bteam.proj.chats.service.ChatroomsServiceImpl;
import com.bteam.proj.chats.vo.ChatroomMembersVO;
import com.bteam.proj.chats.vo.ChatroomsVO;
import com.bteam.proj.chats.vo.MessageVO;
import com.bteam.proj.chats.vo.MessageVO.CommandType;
import com.bteam.proj.chats.vo.MessageVO.DataType;
import com.bteam.proj.member.service.MemberService;
import com.bteam.proj.member.vo.MemberVO;
import com.fasterxml.jackson.databind.ObjectMapper;

import java.io.IOException;
import java.time.Instant;
import java.time.ZoneId;
import java.time.ZonedDateTime;
import java.time.format.DateTimeFormatter;

@Controller
@RequestMapping("/chats")
public class ChatsController {
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

	@RequestMapping("/wstester")
	public String wsTest(Locale locale, Model model) {
		logger.info("ws test {}.", locale);
		return "wstester";
	}

	@RequestMapping("/chatmain")
	public String chatMain(Locale locale, Model model,
			@CookieValue(value = "memberNo", defaultValue = "0") String memberNo) {
		logger.info("chatmain {} ", memberNo);
		List<String> listOfRooms = crm.getChatroomsNoWith(memberNo);
		logger.info("listOfRooms {}", listOfRooms);
		model.addAttribute(listOfRooms);

		return "/chats/chatmain";
	}
	
	/**
	 * when initialized, user must retrieve the rooms they previously joined in. so far, that
	 * purpose, this methods will find from the ChatroomMemberService and store in a
	 * variable the List of ChatRooms to put them inside of Websocket.send() as parameter
	 * only if the room is not open yet
	 * 
	 * this process will be continuously done till there would be no more
	 * ChatroomMember remains So user could get the all data via websocket and
	 * process them;
	 * 
	 * 
	 * ex) if there is 3 ChatroomNo
	 * ___________________________________________________________________________________________________________________
	 * |send(data 3 made from chatroomNo[3]) |
	 * |-------------------------------------| 
	 * |send(data 2 made from ChatroomNo[1]) |
	 * |send(data 1 made from ChatroomNo[0]) | 
	 * ==============================================
	 * |one by one headed to CLEINT's Process()     |
	 * ==============================================
	 *  
	 * 
	 * -------------------------------------------------------------------------------------------------------------------
	 * 
	 * @param message containing the list of
	 * @return wether they are able to send or not ( maybe code? )
	 */
	@RequestMapping(value = "/init", produces = "application/json")
	@ResponseBody
	public int init(@RequestBody MessageVO message) {
		logger.info("through AJAX, message is recieved as follwing :{}", message);
		
		String subject = message.getSubject();
		WebSocketSession subjSession = crm.getSessionOf(subject);
		List<ChatroomMembersVO> joined = cms.getChatroomMembersByMemberNo(subject);
		MessageBuilder mb = new MessageBuilder();
		
		mb.setSubject(subject).setCommandType(CommandType.CREATE).setDataType(DataType.ROOM);
		logger.info("we've detected that member {} is joined in the rooms of {}", subject, joined);
		
		
		/*
		 * Every Chatroom-Member Connection records in database, there could be three types of possibility
		 * (impossible scenario : it is manageable in the crm but the record is not exist
		 * 1. the Chatroom is already in the database while crm is not managing it. -> insert the Chatroom in the crm and join the user in Chatroom
		 * 2. the Chatroom is not int the database while crm is not managing it. -> 
		 * 3. the Chatroom is already in the database and crm is managing it. -> join the user in Chatroom
		 */
		for (ChatroomMembersVO j : joined) {
			mb.clearData();
			logger.info("setting up before sending throw websocket connection");
			ChatroomsVO crInfo = crs.getChatroom(j.getChatroomNo());
			String chatroomNoInDB = crInfo.getChatroomNo();
			String chatroomOwnerInDB = crInfo.getChatroomOwner();
			String chatroomNameInDB = crInfo.getChatroomName();
			ZonedDateTime openDateTimeInDB = crInfo.getOpenDatetime();
			ChatRoom jChatroom = crm.getChatroom(chatroomNoInDB);
			logger.info("from {} , {} could be retrieved ", crInfo, jChatroom);
			
			
			/* WHEN
			 * jChatroom is not manageable in ChatroomManager
			 * but could be found in the Database record
			 */
			if (jChatroom == null && crInfo != null && !crInfo.isClosed()) {
				logger.info(
						"Since there is jChatroom {} is null while there is record {} is alive, "
						+ "crm will insert the converted value into jChatroom ",
						jChatroom,
						crInfo);
				
			/* +AND
				 * if the owner is not logged in and owner session is not in ChatroomManager
				 * it is regard that the owner is log-out state
				 * so we will set the ownerSession as null
				 */ 
				WebSocketSession ownerSession = null;
				try {
						ownerSession = (chatroomOwnerInDB.equals(subject))? 
						crm.getSessionOf(subject):
						crm.getSessionOf(chatroomOwnerInDB);
					}catch(NullPointerException e) {
						ownerSession = null;
				}
				if(ownerSession ==null) {
					jChatroom=new ChatRoom(chatroomNoInDB,chatroomOwnerInDB,subject,subjSession,chatroomNameInDB);
					logger.info("the jChatroom is now {} ", jChatroom); 
//					crm.addChatRoom(jChatroom.getOwner(), jChatroom.getRoomName(), jChatroom.getSessionOf(jChatroom.getOwner()));
				}
			/* +AND
				* if the owner is logged in But the room is not have been made
				* It means that subject is the Owner of the room
				* set the room's ownerSession as subject
				*/
				else if(ownerSession.equals(subjSession)) {
					jChatroom=new ChatRoom(chatroomNoInDB,subject,subjSession,chatroomNameInDB);
					logger.info("the jChatroom is now {} ", jChatroom); 
//					crm.addChatRoom(jChatroom.getOwner(), jChatroom.getRoomName(), jChatroom.getSessionOf(jChatroom.getOwner()));
				}
				crm.addChatRoom(jChatroom);
			}
			/*
			 * ELSE WHEN
			 * there is already ChatRoom exists
			 * join the member into the ChatRoom on work
			 */
			else if(jChatroom !=null && crInfo !=null && !crInfo.isClosed()){
				logger.info(
						"We have found there is certain room {} , joining the member into there",
						jChatroom);
				try {
					crm.getChatroom(jChatroom.getRoomNo()).addMember(subjSession, subject);
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
			
			/*
			 * get all the list of joined member from db , they are "ChatroomMembers"
			 * and try to match with the currently login users
			 * then it will be "Participants"
			 */
			List<ChatroomMembersVO> joinedMemNos = cms.getChatroomMembersByChatroomNo(j.getChatroomNo());
			List<MemberVO> joinedMems = new LinkedList<MemberVO>();
			for(ChatroomMembersVO jmn:joinedMemNos) {
				try {
					joinedMems.add(ms.getMember(jmn.getMemberNo()));
				} catch (Exception e) {
					logger.error("while extracting the list of joined member from db, we faced problem");
					e.printStackTrace();
				}
			}
			
			for(MemberVO joinedMem : joinedMems) {
				WebSocketSession liveMemSess = null;

				if(joinedMem.getMemDelYn().equals("N")) {
					for(ChatroomMembersVO jmn:joinedMemNos) {
						// if the SessionToMember got live value for an MemberNo value in jmn.
						if(crm.getSessionToMember().containsValue(jmn.getChatroomNo())) {
								for(WebSocketSession wss : crm.getSessionToMember().keySet()) {
									if(crm.getSessionToMember().get(wss) == jmn.getMemberNo()) {
										liveMemSess=wss;
									}
								}
						}
					}		
					
					try {
						if(liveMemSess!=null)
						crm.getChatroom(jChatroom.getRoomNo()).addMember(liveMemSess, joinedMem.getMemNo());
					} catch (IOException e) {
						logger.error("while inserting List of Extracted to CRM, an Error occurs");
						e.printStackTrace();
						continue;
					};
					
					
					mb.addData("ChatroomMembers",joinedMem.getMemNo());
//					addData("",joinedMem.getMemName()).
//					addData("",joinedMem.getMemTeam()).
//					addData("",joinedMem.getMemDept()).
//					addData("",joinedMem.getMemPhone()).
//					addData("",joinedMem.getMemEmail());
					                        
				}// if the member is not deleted
			}
			/*
			 * Last step
			 * Build and Send the creation of room message to the client side
			 */
			
			mb.addData("ChatroomName", chatroomNameInDB).addData("ChatroomNo", chatroomNoInDB).addData("ChatroomOwner", chatroomOwnerInDB);

			List<String> participants = jChatroom.getAllMembers();

			
			if (openDateTimeInDB != null)mb.addData("ChatroomOpenDatetime", openDateTimeInDB.toString());
			if (participants != null) {
				for (String participant : participants)
					mb.addData("Participant", participant);
			}

			String shipment = MessageBuilder.parseToJson(mb);
			logger.info("setting is done as {} ", shipment);
			try {
				jChatroom.getSessionOf(subject).sendMessage(new TextMessage(shipment));
			} catch (IOException e) {
				// TODO Auto-generated catch block
				logger.error("while Sending the Shipment , we Faced some problem : {}", e);
				return -1;
			}
		}

		return 1;
	}

}
//com.bteam.proj.chats.dao.IChatroomsDAO.getChatRoomsCount
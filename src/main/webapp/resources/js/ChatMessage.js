/*
Message
{
    subject : memNo(current user's memeNo),
    datatype : ROOM,MEMBER,CHAT,IMAGE
    commandtype : CREATE,RETRIEVE,UPDATE,DELETE
    data : data might be needed for the backend processing
    ex) when "commandtype":"CREATE" "datatype":"ROOM",
        
    1.  Server will recieve payload as the Json got
        its value, and translate it into MessageVO
        which contains commandtype enum as CREATE
        and dataype enum as ROOM
    2.  since datatype is create, the server will generate
        RoomsVO for database processing
    3.  Check its availability in the Chatserivce class, 
        for example, check if the roomName-Owner superkey
        is already taken.
    4.  insert the newly taken datas from client to db.
    5.  server throw payload to the changed lists of the 
        member since it have been changed by adding one 
        room
    6.  nothing have been changed the client side would
        see that there is room name already taken
}
*/

const DATATYPE={
    ROOM    :  'ROOM'
    ,MEMBER :   'MEMBER'
    ,CHAT   :   'CHAT'
    ,IMAGE  :   'IMAGE'
}

const COMMANDTYPE={
    CREATE    :  'CREATE'
    ,RETRIEVE :   'RETRIEVE'
    ,UPDATE   :   'UPDATE'
    ,DELETE  :   'DELETE'
}

Object.freeze(DATATYPE);
Object.freeze(COMMANDTYPE);

class ChatMessage{
    constructor(memNo,dataType,commandType,data){
        if (!Object.values(DATATYPE).includes(dataType)) {
            throw new Error(`Invalid dataType: ${dataType}`);
        }

        if (!Object.values(COMMANDTYPE).includes(commandType)) {
            throw new Error(`Invalid commandType: ${commandType}`);
        }
        this.url;
        this.subject = memNo;
        this.dataType = dataType;
        this.commandType= commandType;
        this.data = data;
    }
    
    insertUrl(url){
    	this.url=url;
    }
}

function parseChatMessage(jsonString) {
    const parsedData = JSON.parse(jsonString);

    if (parsedData && parsedData.dataType && parsedData.commandType && parsedData.data) {
        return new ChatMessage(parsedData.subject, parsedData.dataType, parsedData.commandType, parsedData.data);
    } else {
        throw new Error("Invalid JSON format for ChatMessage");
    }
}
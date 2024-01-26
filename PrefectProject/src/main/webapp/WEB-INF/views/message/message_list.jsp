<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>prefect</title>
<link href="./resources/css/message_list.css" rel="stylesheet">
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.css" type="text/css" rel="stylesheet"/>

</head>
<body>
    <div class="msg-container">
        <div class="messaging">
            <div class="inbox_msg">
                <div class="headind_srch">
                    <div class="recent_heading">
                        <h4>Recent</h4>
                    </div>
                    <div class="srch_bar">
                        <div class="stylish-input-group">
                            <input type="text" class="search-bar" placeholder="Search">
                            <span class="input-group-addon">
                            <button type="button"><i class="fa fa-search" aria-hidden="true"></i></button>
                            </span>
                        </div>
                    </div>
                </div>
                <div class="inbox_chat">
                
                </div>
            </div>
            <div class="mesgs">
                <div class="msg_history" name="contentList">    
                </div>
                <div class="send_message">
                </div>
            </div>
        </div>
    </div>
    <script>
    
    const FistMessageList = function(){
    	$.ajax({
            method: "get",
            url:"message_ajax_list.do",
            data:{
                
            },
            success:function(data){//통신 성공
                console.log("메세지 리스트 리로드 성공");
                
                $('.inbox_chat').html(data);
                
                $('.chat_list').on('click',funtion(){
                	
                	let room =$(this).attr('room');
                	let otherNick = $(this).attr('otherNick');
                	
                	$('.chat_list_box').not('chat_list_box.chat_list_box'+room).removeClass('active_chat');
                	$('.chat_list_box'+room).addClass('active_chat');
                	
                	let send_msg = "";
                	send_msg += "<div class= 'type_msg'>";
                	send_msg += "    <div class='input_msg_write row'>"
                	send_msg += "         <div class ='col-11'>";
                	send_msg += "                  <input type='text' class='write_msg form-control' placeholder='메세지를 입력...' >";
                	send_msg += "         </div>";
                	send_msg += "         <div class = 'col-1'> ";
                	send_msg += "                         <button class='msg_send_btn' type='button'><i class='fa fa-paper-plane-o' aria-hidden='true'></i></button>";
                	send_msg += "         </div>";
                	send_msg += "    </div>";
                	send_msg += "</div>";
                	
                	$('.send_message').html(send_msg);
                	$('.msg_send_btn').on('click',funtion(){
                		SendMessage(room, otherNick);
                	});
                	MessageContentList(room);
                });
            }
           
        })
    };
    const MessageList = function(){
    	$.ajax({
            method: "get",
            url:"message_ajax_list.do",
            data:{
                
            },
            success:function(data){//통신 성공
                console.log("메세지 리스트 리로드 성공");
                
                $('.inbox_chat').html(data);
                
                $('.chat_list').on('click',funtion(){
                    
                    let room =$(this).attr('room');
                    let otherNick = $(this).attr('otherNick');
                    
                    $('.chat_list_box').not('chat_list_box.chat_list_box'+room).removeClass('active_chat');
                    $('.chat_list_box'+room).addClass('active_chat');
                    
                    let send_msg = "";
                    send_msg += "<div class= 'type_msg'>";
                    send_msg += "    <div class='input_msg_write row'>"
                    send_msg += "         <div class ='col-11'>";
                    send_msg += "                  <input type='text' class='write_msg form-control' placeholder='메세지를 입력...' >";
                    send_msg += "         </div>";
                    send_msg += "         <div class = 'col-1'> ";
                    send_msg += "                         <button class='msg_send_btn' type='button'><i class='fa fa-paper-plane-o' aria-hidden='true'></i></button>";
                    send_msg += "         </div>";
                    send_msg += "    </div>";
                    send_msg += "</div>";
                    
                    $('.send_message').html(send_msg);
                    $('.msg_send_btn').on('click',funtion(){
                        SendMessage(room, otherNick);
                    });
                    MessageContentList(room);
                });
                $('.chat_list_box:first').addClass('active_chat');
            }
           
        })
    };
    const MessageContentList = function(room){
    	$.ajax({
            method: "GET",
            url:"message_content_list.do",
            data:{
                room: room
            },
            success:function(data){//통신 성공
                console.log("메세지 내용 가져오기 성공");
                
                $('.msg_histroy').html(data);
                
                $('.msg_histroy').scrollTop($(".msg_history")[0].scrollHeight);
            },
            error : function(){
            	   alert('서버 에러');
            }
           
        })
        
        $('.unread'+room).empty();
    };
    
    const SendMessage = function(room, otherNick){
    	let contents = $('.write_msg').val();
    	
    	contents= contents.trim();
    	
    	if(contents ==""){
    		  alert("메세지를 입력하세요");
    	}else{
    		$.ajax({
                method: "GET",
                url:"message_send_list.do",
                data:{
                    room: room,
                    otherNick: otherNick,
                    contents: contents
                },
                success:function(data){//통신 성공
                    console.log("메세지 전송 성공");
                    
                    $('.write_msg').val("");
                    
                    MessageContentlist(room);
                    
                    messageList();
                },
                error : function(){
                       alert('서버 에러');
                }
               
            });
    	}
    		
    };
    
    $(document).ready(function{
    	FirstMessageList();
    });
    </script>
</body>
</html>
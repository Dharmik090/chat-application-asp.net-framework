<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Chat.aspx.cs" Inherits="chat_application.Chat" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Chat Application</title>
     <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<style>
    body {
        font-family: Arial, sans-serif;
        margin: 0;
        padding: 0;
        background-color: #f5f5f5;
    }
    #form1 {
        margin: 20px;
    }
    #chatContainer {
        border: 1px solid #ccc;
        width: 100%;
        max-width: 600px;
        height: 400px;
        overflow-y: auto;
        margin-bottom: 10px;
        padding: 10px;
        background-color: #fff;
        border-radius: 5px;
    }
    .message {
        padding: 10px;
        margin: 5px 0;
        border-radius: 5px;
        max-width: 80%;
        clear: both;
    }
    .left {
        background-color: #e0f7fa;
        text-align: left;
        float: left;
    }
    .right {
        background-color: #c8e6c9;
        text-align: right;
        float: right;
    }
    .clearfix {
        clear: both;
    }
    .button-container {
        margin-top: 10px;
        text-align: right;
    }
    #txtUserMessage {
        width: calc(100% - 110px);
        padding: 10px;
        border: 1px solid #ccc;
        border-radius: 5px;
        box-sizing: border-box;
    }
    #btnSender {
        padding: 10px 20px;
        border: none;
        border-radius: 5px;
        background-color: #007bff;
        color: white;
        cursor: pointer;
    }
    #btnSender:hover {
        background-color: #0056b3;
    }
</style>
</head>
<body>
    <form id="form2" runat="server">
        <script type="text/javascript">
            function appendMessageToChat(tempmsg) {
                var chatContainer = document.getElementById('chatContainer');

                // Create a new div element
                var newDiv = document.createElement('div');

                // Set the content of the new div
                newDiv.innerHTML = tempmsg;

                // Append the new div to the chat container
                chatContainer.appendChild(newDiv);

                // Optionally, scroll to the bottom to show the new message
                chatContainer.scrollTop = chatContainer.scrollHeight;
            }
        </script>
    <div id="chatContainer"></div>
    <div class="button-container">
        <asp:TextBox ID="txtUserMessage" runat="server" Placeholder="Send message"></asp:TextBox>
        <asp:Button ID="btnSender" runat="server" Text="Send" OnClientClick="sendMessage(); return false;" />
    </div>
</form>

    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script type="text/javascript">
        var $jq = jQuery.noConflict();
        $jq(document).ready(function () {

            window.sendMessage = function () {
                var message = $('#<%= txtUserMessage.ClientID %>').val();
                var user_id = "<%= Session["user_id"] %>";
                var friend_id = "<%= Request.QueryString["fid"] %>";

                $.ajax({
                    type: "POST",
                    url: "Chat.aspx/SaveMessage",
                    data: JSON.stringify({ msg: message, sender: 'user', user_id: user_id, friend_id: friend_id }),
                    contentType: "application/json; chatset=utf-8",
                    dataType: "json",
                    success: function (response) {
                        //append user message to right side in container
                        $('#chatContainer').append('<div class="message right">' + message + '</div><div class="clearfix"></div>');
                        $('#<%= txtUserMessage.ClientID %>').val('');
                        scrollToBottom(); // Scroll to bottom after appending the message
                    }
                });
            }
            //every two second chaeck for message is there any message send by friend or not
            function pollForMessages() {
                var user_id = "<%= Session["user_id"] %>";
                var friend_id = "<%= Request.QueryString["fid"] %>";

                console.log("...");
                $.ajax({
                    type: "POST",
                    url: "Chat.aspx/GetNewMessages",
                    data: JSON.stringify({ user_id: user_id, friend_id: friend_id }), // pass tabId
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (response) {
                        var messages = response.d;
                        for (var i = 0; i < messages.length; i++) {
                            var message = messages[i];
                            // Append friend message to left side in container
                            $jq('#chatContainer').append('<div class="message left">' + message + '</div><div class="clearfix"></div>');
                            scrollToBottom(); // Scroll to bottom after appending the message   
                        }
                    },
                    complete: function () {
                        setTimeout(pollForMessages, 2000);
                    }//every 2 second
                });
            }

            function scrollToBottom() {
                var chatContainer = $jq('#chatContainer');
                chatContainer.scrollTop(chatContainer[0].scrollHeight);
            }
            scrollToBottom();

            $(document).ready(function () {
                pollForMessages();
            });
        });
    </script>
</body>
</html>
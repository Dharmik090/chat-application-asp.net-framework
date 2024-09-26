using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Configuration;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace chat_application
{

    public class ChatMessage
    {
        public string chat_msg_text { get; set; }
        public string sender_id { get; set; }
        public string receiver_id { get; set; }
        public string time { get; set; }
        public string whose_msg { get; set; }//friends message or user message 
    }

    public partial class Chat : System.Web.UI.Page
    {
        private static List<ChatMessage> chatting = new List<ChatMessage>();
        static string user_id;
        static string friend_id;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                user_id = Session["user_id"].ToString();
                friend_id = Request.QueryString["fid"];

                if (user_id == null || Session["user_id"] == null)
                {
                    Response.Redirect("SignIn.aspx");
                    return;
                }

                ViewState["user_id"] = user_id;

            }

            LoadChatHistory();
        }

        private void LoadChatHistory()
        {
            chatting.Clear();

            string connectionString = WebConfigurationManager.ConnectionStrings["userCon"].ConnectionString;
            string chatCmd = "select * from User_Chat where Sender = @uid and Receiver = @fid or Sender = @fid and Receiver = @uid order by Time";

            SqlConnection con = new SqlConnection();
            con.ConnectionString = connectionString;

            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;

            try
            {
                using (con) { 
                    con.Open();

                    // Select all messages between user and friend orderd by time
                    cmd.CommandText = chatCmd;
                    cmd.Parameters.AddWithValue("@uid", user_id);
                    cmd.Parameters.AddWithValue("@fid", friend_id);
                    
                    SqlDataReader rdr = cmd.ExecuteReader();

                    while (rdr.Read())
                    {
                        ChatMessage message = new ChatMessage
                        {
                            chat_msg_text = rdr["Message"].ToString(),
                            sender_id = rdr["Sender"].ToString(),
                            receiver_id = rdr["Receiver"].ToString(),
                            time = rdr["Time"].ToString(),
                            whose_msg = (rdr["Sender"].ToString() == user_id) ? "user" : "friend",
                        };

                        chatting.Add(message);
                    }
                    rdr.Close();
                }
            }
            catch (Exception ex)
            {
                Response.Write("error:" + ex.ToString());
            }

            DisplayChatHistory();
        }
        private void DisplayChatHistory()
        {

            string combinedScript = @" <script>
                                           function appendMessage(message,sender) {
                                                     const chatContainer = document.getElementById('chatContainer');
                                                     const messageElement = document.createElement('div');
                                                     messageElement.classList.add('message');
                                                     messageElement.classList.add(sender === 'user' ? 'right' : 'left');
                                                     messageElement.textContent = message;
                                                     chatContainer.appendChild(messageElement);

                                                     const clearfix = document.createElement('div');
                                                     clearfix.classList.add('clearfix');
                                                     chatContainer.appendChild(clearfix);
                                           }";

            foreach (var message in chatting)
            {
                string msg = message.chat_msg_text;
                string sender = message.whose_msg;

                combinedScript += "appendMessage('" + msg + "','" + sender + "');";
            }
            combinedScript += "</script>";

            ClientScript.RegisterStartupScript(this.GetType(), "appendMessage", combinedScript, false);
        }


        [WebMethod]
        public static void SaveMessage(string msg, string sender, string user_id,string friend_id)
        {

            string connectionString = WebConfigurationManager.ConnectionStrings["userCon"].ConnectionString;
            string command = "insert into User_Chat values(@s_id,@r_id,@msg,@time)";

            SqlConnection con = new SqlConnection();
            con.ConnectionString = connectionString;

            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;

            try
            {
                using (con)
                {
                    con.Open();
                    
                    cmd.CommandText = command;
                    cmd.Parameters.AddWithValue("@s_id", user_id);
                    cmd.Parameters.AddWithValue("@r_id", friend_id);
                    cmd.Parameters.AddWithValue("@msg", msg);
                    DateTime localDate = DateTime.Now;
                    cmd.Parameters.AddWithValue("@time", localDate);


                    int i = cmd.ExecuteNonQuery();
                    if(i == 1)
                        chatting.Add(new ChatMessage { chat_msg_text = msg, whose_msg = sender, sender_id = user_id, receiver_id = friend_id, time = localDate.ToString() });
                }
            }
            catch (Exception ex)
            {
                Console.WriteLine(ex);
            }
        }


        [WebMethod]
        public static List<string> GetNewMessages(string user_id,string friend_id)
        {

            List<string> newMessages = new List<string>();

            string connectionString = WebConfigurationManager.ConnectionStrings["userCon"].ConnectionString;
            string command = "select Message from User_Chat where Sender = @friend_id and Receiver = @user_id and Time >= DATEADD(second, -2, GETDATE()) ORDER BY Time";

            SqlConnection con = new SqlConnection();
            con.ConnectionString = ConfigurationManager.ConnectionStrings["userCon"].ConnectionString;

            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;
            cmd.CommandText = command;

            try
            {

                using (con)
                {
                    con.Open();
                 
                    cmd.Parameters.AddWithValue("@user_id", user_id);
                    cmd.Parameters.AddWithValue("@friend_id", friend_id);

                    SqlDataReader rdr = cmd.ExecuteReader();

                    while (rdr.Read())
                        newMessages.Add(rdr["Message"].ToString());
                }
            }
            catch (Exception e)
            {
                Console.Write("error: " + e);
                newMessages.Add(e.ToString());
            }

            return newMessages;
        }
        public static void ClearList()
        {
            chatting.Clear();
        }
    }
}
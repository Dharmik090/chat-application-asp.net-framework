using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace chat_application
{
    public partial class Welcome : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string connection_string = WebConfigurationManager.ConnectionStrings["userCon"].ConnectionString;
                string command = "select * from Users where Id != @Id";

                SqlConnection con = new SqlConnection(connection_string);
                SqlCommand cmd = new SqlCommand();
                cmd.Connection = con;
                cmd.CommandText = command;

                int user_id = int.Parse(Request.QueryString["id"]);

                try
                {
                    using (con)
                    {
                        // Fetch Logged In User
                    }
                }
                catch (Exception ex) {
                    Response.Write($"ERROR! : {ex}");
                }


                BindUsers();
            }

        }

        private void BindUsers()
        {
            // Get the current logged-in user ID
            string currentUserId = Session["user_id"].ToString();

            // Define your connection string
            string connectionString = ConfigurationManager.ConnectionStrings["userCon"].ConnectionString;
            string command = "select * from Users where Id != @Id";

            SqlConnection con = new SqlConnection();
            con.ConnectionString = connectionString;

            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;

            using (con)
            {
                con.Open();

                cmd.CommandText = command;
                cmd.Parameters.AddWithValue("@Id", currentUserId);

                SqlDataReader rdr = cmd.ExecuteReader();
                
                gvUsers.DataSource = rdr;
                gvUsers.DataBind();
            }
        }

        protected void btnMessage_Click(object sender, EventArgs e) { 
            Button btn = (Button)sender;
            string friend_id = btn.CommandArgument.ToString();
            string user_id = Session["user_id"].ToString();

            Response.Redirect($"chat.aspx?uid={user_id}&fid={friend_id}");
        }
        protected void btnMakeFriend_Click(object sender, EventArgs e) {
            Button btn = (Button)sender;
            string friend_id = btn.CommandArgument;
            string user_id = Session["user_id"].ToString();

            string connectionString = ConfigurationManager.ConnectionStrings["userCon"].ConnectionString;
            string command = "insert into Friends values(@uid,@fid)";

            SqlConnection con = new SqlConnection(connectionString);

            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;

            try
            {
                using (con)
                {
                    con.Open();

                    cmd.CommandText = command;
                    cmd.Parameters.AddWithValue("@uid", user_id);
                    cmd.Parameters.AddWithValue("@fid", friend_id);

                    int i = cmd.ExecuteNonQuery();

                    if(i == 1) {
                        Response.Redirect($"chat.aspx?uid={user_id}&fid={friend_id}");    
                    }
                }
            }
            catch (Exception ex) {
                Response.Write($"ERROR : {ex}");
            }

        }
    }
}
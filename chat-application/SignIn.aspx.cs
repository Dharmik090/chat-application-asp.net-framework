using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace chat_application
{
    public partial class SignIn : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            ValidationSettings.UnobtrusiveValidationMode = UnobtrusiveValidationMode.None;

            if (!IsPostBack) {
                tbUsername.Text = ViewState["Username"]!=null ? ViewState["Username"].ToString() : string.Empty;
                tbPassword.Text = ViewState["Password"]!=null ? ViewState["Password"].ToString() :  string.Empty;
            }
    }

        protected void btnSignIn_Click(object sender, EventArgs e) {
            ViewState["Username"] = tbUsername.Text;
            
            string connection_string = WebConfigurationManager.ConnectionStrings["userCon"].ConnectionString;
            string command = "select Id,Password from Users where Username = @Username";

            SqlConnection con = new SqlConnection();
            con.ConnectionString = connection_string;
            SqlCommand cmd = new SqlCommand(command, con);

            try
            {
                using (con)
                {
                    con.Open();
                    string entered_username = tbUsername.Text;
                    string entered_password = tbPassword.Text;

                    // Find User by username :
                    cmd.Parameters.AddWithValue("@Username", entered_username);
                    SqlDataReader rdr = cmd.ExecuteReader();

                    // Check User's Password
                    if (rdr.Read())
                    {
                        if (rdr["Password"].ToString() != entered_password)
                        {
                            lblUsernameError.Text = "";
                            lblPasswordError.Text = "Incorrect Password";
                            return;
                        }

                        int id = rdr.GetInt32(0);
                        rdr.Close();

                        // Correct Username Password
                        Session["user_id"] = id;
                        Session["username"] = entered_username;

                        Response.Redirect("Welcome.aspx?id=" + id);
                    }
                    else {
                        lblPasswordError.Text = "";
                        lblUsernameError.Text = "User not found";
                        return;
                    }
                }
            }
            catch (Exception ex) {
                Response.Write($"ERROR! : {ex}");
            }
        }
    }
}
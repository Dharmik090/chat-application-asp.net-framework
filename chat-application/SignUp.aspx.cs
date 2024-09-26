using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace chat_application
{
    public partial class SignUp : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            ValidationSettings.UnobtrusiveValidationMode = UnobtrusiveValidationMode.None;

            if (!IsPostBack)
            {
                tbFirstName.Text = ViewState["FirstName"] != null ? ViewState["FirstName"].ToString() : string.Empty;
                tbLastName.Text = ViewState["LastName"] != null ? ViewState["LastName"].ToString() : string.Empty;
                tbUsername.Text = ViewState["Username"] != null ? ViewState["Username"].ToString() : string.Empty;
                tbEmail.Text = ViewState["Email"] != null ? ViewState["Email"].ToString() : string.Empty;
                tbPassword.Text = ViewState["Password"] != null ? ViewState["Password"].ToString() : string.Empty;
            }
        }

        protected void btnSingUp_Click(object sender, EventArgs e) {
            ViewState["FirstName"] = tbFirstName.Text;
            ViewState["LastName"] = tbLastName.Text;
            ViewState["Username"] = tbUsername.Text;
            ViewState["Email"] = tbEmail.Text;
            ViewState["Password"] = tbPassword.Text;
            
            string connection_string = WebConfigurationManager.ConnectionStrings["userCon"].ConnectionString;
            string select_command = "select * from Users where Username=@Username1 or Email=@Email1";
            string insert_command = "insert into Users values (@FirstName,@LastName,@Username2,@Email2,@Password)";

            SqlConnection con = new SqlConnection(connection_string);
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;

            try
            {
                using (con)
                {
                    con.Open();
                    string entered_username = tbUsername.Text;
                    string entered_email = tbEmail.Text;

                    // Select User :
                    cmd.CommandText = select_command;
                    cmd.Parameters.AddWithValue("@Username1", entered_username);
                    cmd.Parameters.AddWithValue("@Email1", entered_email);

                    SqlDataReader rdr = cmd.ExecuteReader();

                    // Check If Username, Email already exist or not
                    if (rdr.Read()) {
                        if (rdr["Username"].ToString() == entered_username &&
                            rdr["Email"].ToString() == entered_email)
                        {
                            lblEmailError.Text = "Email already exist";
                            lblUsernameError.Text = "Username already exist";
                            return;
                        }
                        else if (rdr["Username"].ToString() == entered_username)
                        {
                            lblEmailError.Text = "";
                            lblUsernameError.Text = "Username already exist";
                            return;
                        }
                        else if (rdr["Email"].ToString() == entered_email)
                        {
                            lblUsernameError.Text = "";
                            lblEmailError.Text = "Email already exist";
                            return;
                        }
                        else {
                            lblUsernameError.Text = "";
                            lblEmailError.Text = "";
                        }
                    }
                    rdr.Close();

                    // Else insert User : 
                    cmd.CommandText = insert_command;
                    cmd.Parameters.AddWithValue("@FirstName", tbFirstName.Text);
                    cmd.Parameters.AddWithValue("@LastName", tbLastName.Text);
                    cmd.Parameters.AddWithValue("@Username2", tbUsername.Text);
                    cmd.Parameters.AddWithValue("@Email2", tbEmail.Text);
                    cmd.Parameters.AddWithValue("@Password", tbPassword.Text);

                    int i = cmd.ExecuteNonQuery();
                    Response.Redirect("SignIn.aspx");
                }
            }
            catch (Exception ex) {
                Response.Write($"ERROR! : {ex}");
            }
        }
    }
}
<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SignUp.aspx.cs" Inherits="chat_application.SignUp" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous" />
    <title>Sign Up</title>
    <style type="text/css">
        .auto-style1 {
            width: 41%;
        }

        .auto-style2 {
            width: 171px;
        }

        .page-holder {
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .form-container {
            width: 100%;
            max-width: 500px; /* Adjust as needed */
            padding: 20px;
            background: #fff;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0,0,0,0.1);
        }

        footer {
            margin-top: 20px;
        }
    </style>
</head>

<body>

    <form id="form3" runat="server">
        <div class="page-holder">
            <div class="form-container">
                <asp:HyperLink href="SignIn.aspx" ID="linkSignIn" runat="server">Sign In Here</asp:HyperLink>
                <br /><br />
                <div class="form-group mb-4">
                    <asp:Label CssClass="text-muted h5" ID="lblFirstName" runat="server" Text="First Name"></asp:Label>
                    <asp:TextBox ID="tbFirstName" required="true" CssClass="form-control border-0 shadow form-control-lg text-base" runat="server"></asp:TextBox>
                    
                    <asp:RequiredFieldValidator ID="RequiredFirstName" runat="server" 
                        ControlToValidate="tbFirstName" ErrorMessage="First Name is required"
                        ForeColor="Red"></asp:RequiredFieldValidator>
                </div>

                <div class="form-group mb-4">
                    <asp:Label CssClass="text-muted h5" ID="lblLastName" runat="server" Text="Last Name"></asp:Label>
                    <asp:TextBox ID="tbLastName" required="true" CssClass="form-control border-0 shadow form-control-lg text-base" runat="server"></asp:TextBox>
                    
                    <asp:RequiredFieldValidator ID="ReuiredLastName" runat="server"
                        ControlToValidate="tbLastName" ErrorMessage="Last Name is required"
                        ForeColor="Red"></asp:RequiredFieldValidator>
                </div>

                <div class="form-group mb-4">
                    <asp:Label CssClass="text-muted h5" ID="lblUsername" runat="server" Text="Username"></asp:Label>
                    <asp:TextBox ID="tbUsername" required="true" CssClass="form-control border-0 shadow form-control-lg text-base" runat="server"></asp:TextBox>
                   <asp:Label CssClass="text-danger" ID="lblUsernameError" runat="server" Text=""></asp:Label>

                    <asp:RequiredFieldValidator ID="RequiredUsername" runat="server"
                        ControlToValidate="tbUsername" ErrorMessage="Username is required"
                        ForeColor="Red"></asp:RequiredFieldValidator>
                </div>

                <div class="form-group mb-4">
                    <asp:Label CssClass="text-muted h5" ID="lblEmail" runat="server" Text="Email"></asp:Label>
                    <asp:TextBox ID="tbEmail" required="true" CssClass="form-control border-0 shadow form-control-lg text-base" runat="server"></asp:TextBox>
                    <asp:Label CssClass="text-danger" ID="lblEmailError" runat="server" Text=""></asp:Label>

                    <asp:RequiredFieldValidator ID="RequiredEmail" runat="server"
                        ControlToValidate="tbEmail" ErrorMessage="Email is required"
                        ForeColor="Red"></asp:RequiredFieldValidator>
                </div>

                <div class="form-group mb-4">
                    <asp:Label CssClass="text-muted h5" ID="lblPassword" runat="server" Text="Password"></asp:Label>
                    <asp:TextBox ID="tbPassword" required="true" TextMode="Password" CssClass="form-control border-0 shadow form-control-lg text-base" runat="server"></asp:TextBox>
                    
                    <asp:RequiredFieldValidator ID="RequiredPassword" runat="server"
                        ControlToValidate="tbPassword" ErrorMessage="Password is required"
                        ForeColor="Red"></asp:RequiredFieldValidator>
                </div>

                <asp:Button ID="btnSignUp" Text="Sign Up" CssClass="btn btn-primary" Height="50px" Width="100%" runat="server" OnClick="btnSingUp_Click"/>
            </div>
        </div>

        <footer class="footer bg-white shadow align-self-end py-3 px-xl-5 w-100 text-center" style="margin-top: 20px;">
            <div class="container-fluid">
                <div class="row">
                    <div class="col-md-6 text-center text-md-left text-primary">
                        <p class="mb-2 mb-md-0">Coder &copy;2024</p>
                    </div>
                    <div class="col-md-6 text-center text-md-right text-gray-400">
                        <p class="mb-0">Design by <a href="#">Coder</a></p>
                    </div>
                </div>
            </div>
        </footer>
    </form>






    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>

</body>
</html>

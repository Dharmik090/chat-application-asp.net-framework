<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SignIn.aspx.cs" Inherits="chat_application.SignIn" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous" />
    <title>Sign In</title>
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
                <asp:HyperLink href="SignUp.aspx" ID="linkSignUp" runat="server">Sign Up Here</asp:HyperLink>
                <h3 class="mb-4">Welcome Back!</h3>

                <div class="form-group mb-4">
                    <asp:Label CssClass="text-muted h5" ID="lblUsername" runat="server" Text="Username"></asp:Label>
                    <asp:TextBox ID="tbUsername" CssClass="form-control border-0 shadow form-control-lg text-base" runat="server"></asp:TextBox>
                    <asp:Label CssClass="text-danger" ID="lblUsernameError" runat="server" Text=""></asp:Label>
                    
                    <asp:RequiredFieldValidator ID="RequiredUsername" runat="server" 
                        ControlToValidate="tbUsername" ErrorMessage="Username is required"
                        ForeColor="Red"></asp:RequiredFieldValidator>
                </div>

                <div class="form-group mb-4">
                    <asp:Label CssClass="text-muted h5" ID="lblPassword" runat="server" Text="Password"></asp:Label>
                    <asp:TextBox ID="tbPassword" TextMode="Password" CssClass="form-control border-0 shadow form-control-lg text-base" runat="server"></asp:TextBox>
                    <asp:Label CssClass="text-danger" ID="lblPasswordError" runat="server" Text=""></asp:Label>

                    <asp:RequiredFieldValidator ID="RequiredPassword" runat="server"
                        ControlToValidate="tbPassword" ErrorMessage="Password is required"
                        ForeColor="Red"></asp:RequiredFieldValidator>
                </div>

                <div class="form-group mb-4">
                    <div class="custom-control custom-checkbox">
                        <asp:CheckBox Text="&nbsp&nbsp&nbspRemember Me" runat="server" />
                    </div>
                </div>

                <asp:Button ID="btnSginIn" Text="Sign In" CssClass="btn btn-primary" Height="50px" Width="100%" runat="server" OnClick="btnSignIn_Click" />
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

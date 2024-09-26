<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Welcome.aspx.cs" Inherits="chat_application.Welcome" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Welcome Page</title>
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet" />
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            padding: 20px;
        }

        .user-card {
            border: 1px solid #ccc;
            border-radius: 10px;
            padding: 10px;
            margin-bottom: 15px;
            background-color: #fff;
        }

        .user-actions {
            text-align: right;
        }
    </style>
</head>
<body>
    <form id="btnForm" runat="server">
        <div class="container">
            <h2 class="text-center">Welcome, <%= Session["username"] %>!</h2>
            <h4 class="text-center">Available Users</h4>
            <div class="row">
                <asp:GridView ID="gvUsers" runat="server" AutoGenerateColumns="False" CssClass="table table-striped">
                <Columns>
                    <asp:BoundField DataField="username" HeaderText="Username" />
                    <asp:TemplateField HeaderText="Actions">
                        <ItemTemplate>
                            <asp:Button ID="btnMessage" runat="server" Text="Message"
                                CommandArgument='<%# Eval("Id") %>'
                                OnClick="btnMessage_Click"
                                CssClass="btn btn-primary"
                                Visible='true' />
                            <asp:Button ID="btnMakeFriend" runat="server" Text="Make Friend"
                                CommandArgument='<%# Eval("Id") %>'
                                OnClick="btnMakeFriend_Click"
                                CssClass="btn btn-success"
                                Visible='true' />
                            
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
            </div>
        </div>
    </form>
</body>
</html>

<%@ Page Language="vb" AutoEventWireup="true" CodeFile="Default.aspx.vb" Inherits="_Default" %>

<%@ Register Assembly="DevExpress.Web.v13.2, Version=13.2.5.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a"
	Namespace="DevExpress.Web.ASPxHiddenField" TagPrefix="dx" %>

<%@ Register Assembly="DevExpress.Web.v13.2, Version=13.2.5.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a"
	Namespace="DevExpress.Web.ASPxCallbackPanel" TagPrefix="dx" %>

<%@ Register Assembly="DevExpress.Web.v13.2, Version=13.2.5.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a"
	Namespace="DevExpress.Web.ASPxPopupControl" TagPrefix="dx" %>

<%@ Register Assembly="DevExpress.Web.v13.2, Version=13.2.5.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a"
	Namespace="DevExpress.Web.ASPxGridView" TagPrefix="dx" %>

<%@ Register Assembly="DevExpress.Web.v13.2, Version=13.2.5.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a"
	Namespace="DevExpress.Web.ASPxEditors" TagPrefix="dx" %>

<%@ Register Assembly="DevExpress.Web.v13.2, Version=13.2.5.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a"
	Namespace="DevExpress.Web.ASPxPanel" TagPrefix="dx" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
	<title>ASPxGridView - A capability to allow a cell-level popup editor to enter and store data separately from a cell</title>
	<script type="text/javascript">
		var currentIndex;
		var pcShown = false;

		function OnGotFocus(s, e, index, text) {
			currentIndex = index;
			if (!pcShown) {
				memo.SetText(text);
				pc.ShowAtElement(s.GetMainElement());
				pcShown = true;
			}
		}

		function OnSaveClick(s, e) {
			var textBox = ASPxClientControl.GetControlCollection().GetByName("tb" + currentIndex);
			hf.Set("tb", textBox.GetText());
			hf.Set("memo", memo.GetText());

			cp.PerformCallback();
			HidePopup();
		}

		function OnCancelClick(s, e) {
			HidePopup();
			gv.CancelEdit();
		}

		function HidePopup() {
			pc.Hide();
			pcShown = false;
		}

		function OnRowClick(s, e) {
			s.StartEditRow(e.visibleIndex);
		}
	</script>
</head>
<body>
	<form id="form1" runat="server">
		<dx:ASPxCallbackPanel ID="cp" runat="server" ClientInstanceName="cp" OnCallback="cp_Callback">
			<PanelCollection>
				<dx:PanelContent ID="PanelContent1" runat="server" SupportsDisabledAttribute="True">
					<dx:ASPxHiddenField ID="hf" runat="server" ClientInstanceName="hf"></dx:ASPxHiddenField>
					<dx:ASPxGridView ID="gv" runat="server" AutoGenerateColumns="False"
						ClientInstanceName="gv" DataSourceID="ads" KeyFieldName="CategoryID">
						<ClientSideEvents RowClick="OnRowClick" />
						<Columns>
							<dx:GridViewDataTextColumn FieldName="CategoryID" ReadOnly="True"
								ShowInCustomizationForm="True" VisibleIndex="1">
								<EditFormSettings Visible="False" />
							</dx:GridViewDataTextColumn>
							<dx:GridViewDataTextColumn FieldName="CategoryName"
								ShowInCustomizationForm="True" VisibleIndex="2">
								<EditItemTemplate>
									<dx:ASPxTextBox ID="tb" runat="server" OnInit="tb_Init"
										Text='<%#Eval("CategoryName")%>'>
									</dx:ASPxTextBox>
								</EditItemTemplate>
							</dx:GridViewDataTextColumn>
							<dx:GridViewDataTextColumn FieldName="Description"
								ShowInCustomizationForm="True" Visible="False" VisibleIndex="3">
							</dx:GridViewDataTextColumn>
						</Columns>
						<SettingsEditing Mode="Inline">
						</SettingsEditing>
					</dx:ASPxGridView>
				</dx:PanelContent>
			</PanelCollection>
		</dx:ASPxCallbackPanel>
		<dx:ASPxPopupControl ID="pc" runat="server" ClientInstanceName="pc" ShowHeader="false"
			PopupHorizontalAlign="RightSides" PopupVerticalAlign="Below" CloseAction="None"
			Width="240">
			<ContentCollection>
				<dx:PopupControlContentControl ID="PopupControlContentControl1" runat="server" SupportsDisabledAttribute="True">
					<dx:ASPxMemo ID="mm" runat="server" ClientInstanceName="memo" Height="120" Width="100%">
					</dx:ASPxMemo>
					<dx:ASPxButton ID="saveBtn" runat="server" AutoPostBack="False" Text="Save">
						<ClientSideEvents Click="OnSaveClick" />
					</dx:ASPxButton>
					<dx:ASPxButton ID="cancelBtn" runat="server" AutoPostBack="False" Text="Cancel">
						<ClientSideEvents Click="OnCancelClick" />
					</dx:ASPxButton>
				</dx:PopupControlContentControl>
			</ContentCollection>
		</dx:ASPxPopupControl>
		<asp:AccessDataSource ID="ads" runat="server" DataFile="~/App_Data/nwind.mdb"
			DeleteCommand="DELETE FROM [Categories] WHERE [CategoryID] = ?"
			InsertCommand="INSERT INTO [Categories] ([CategoryID], [CategoryName], [Description]) VALUES (?, ?, ?)"
			SelectCommand="SELECT [CategoryID], [CategoryName], [Description] FROM [Categories]"
			UpdateCommand="UPDATE [Categories] SET [CategoryName] = ?, [Description] = ? WHERE [CategoryID] = ?">
			<DeleteParameters>
				<asp:Parameter Name="CategoryID" Type="Int32" />
			</DeleteParameters>
			<InsertParameters>
				<asp:Parameter Name="CategoryID" Type="Int32" />
				<asp:Parameter Name="CategoryName" Type="String" />
				<asp:Parameter Name="Description" Type="String" />
			</InsertParameters>
			<UpdateParameters>
				<asp:Parameter Name="CategoryName" Type="String" />
				<asp:Parameter Name="Description" Type="String" />
				<asp:Parameter Name="CategoryID" Type="Int32" />
			</UpdateParameters>
		</asp:AccessDataSource>
	</form>
</body>
</html>
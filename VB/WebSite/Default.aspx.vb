Imports Microsoft.VisualBasic
Imports System
Imports System.Collections.Generic
Imports System.Linq
Imports System.Web
Imports System.Web.UI
Imports System.Web.UI.WebControls
Imports DevExpress.Web

Partial Public Class _Default
	Inherits System.Web.UI.Page
	Protected Sub tb_Init(ByVal sender As Object, ByVal e As EventArgs)
		Dim tb As ASPxTextBox = TryCast(sender, ASPxTextBox)
		Dim container As GridViewEditItemTemplateContainer = TryCast(tb.NamingContainer, GridViewEditItemTemplateContainer)
		tb.ClientInstanceName = "tb" & container.VisibleIndex
		Dim text As String = container.Grid.GetRowValues(container.Grid.EditingRowVisibleIndex, "Description").ToString()
		tb.ClientSideEvents.GotFocus = String.Format("function(s, e) {{ OnGotFocus(s, e, '{0}', '{1}') }}", container.VisibleIndex, text)
	End Sub

	Protected Sub cp_Callback(ByVal sender As Object, ByVal e As DevExpress.Web.CallbackEventArgsBase)
		If hf.Contains("tb") AndAlso hf.Contains("memo") Then
			ads.UpdateParameters("CategoryID").DefaultValue = gv.GetRowValues(gv.EditingRowVisibleIndex, gv.KeyFieldName).ToString()
			ads.UpdateParameters("CategoryName").DefaultValue = hf("tb").ToString()
			ads.UpdateParameters("Description").DefaultValue = hf("memo").ToString()
			'ads.Update(); 'Uncomment this line to allow data saving.
		End If

		gv.DataBind()
		gv.CancelEdit()
	End Sub
End Class
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DevExpress.Web.ASPxEditors;
using DevExpress.Web.ASPxGridView;

public partial class _Default : System.Web.UI.Page {
    protected void tb_Init(object sender, EventArgs e) {
        ASPxTextBox tb = sender as ASPxTextBox;
        GridViewEditItemTemplateContainer container = tb.NamingContainer as GridViewEditItemTemplateContainer;
        tb.ClientInstanceName = "tb" + container.VisibleIndex;
        string text = container.Grid.GetRowValues(container.Grid.EditingRowVisibleIndex, "Description").ToString();
        tb.ClientSideEvents.GotFocus = String.Format("function(s, e) {{ OnGotFocus(s, e, '{0}', '{1}') }}", container.VisibleIndex, text);
    }

    protected void cp_Callback(object sender, DevExpress.Web.ASPxClasses.CallbackEventArgsBase e) {
        if (hf.Contains("tb") && hf.Contains("memo")) {
            ads.UpdateParameters["CategoryID"].DefaultValue = gv.GetRowValues(gv.EditingRowVisibleIndex, gv.KeyFieldName).ToString();
            ads.UpdateParameters["CategoryName"].DefaultValue = hf["tb"].ToString();
            ads.UpdateParameters["Description"].DefaultValue = hf["memo"].ToString();
            // ads.Update(); // Uncomment this line to allow data saving.
        }

        gv.DataBind();
        gv.CancelEdit();
    }
}
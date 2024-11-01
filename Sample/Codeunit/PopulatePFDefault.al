codeunit 50113 PopulatePFDefaults
{
    trigger OnRun()
    begin

    end;

    var
        PFPopulateDefaults: Codeunit "Nodus PF Populate Defaults";

    procedure PopulatePFFields(var SalesHeader: Record "Sales Header")
    begin
        // If SalesHeader is new created and all the fields in PayFabric section of Sales Order/Invoice page are blank, 
        // should call this function to populate defaults PF fields
        PFPopulateDefaults.PopulateDefaultPayFabricFields(SalesHeader);
    end;
}
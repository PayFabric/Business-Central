codeunit 50111 "Send PayLink"
{
    var
        SendPayLink: Codeunit "Nodus PF Create PayLink";
        PFTransaction: Record nodPFTransactions;
        RecSalesHeader: Record "Sales Header";

    procedure Main()
    begin
        Clear(RecSalesHeader);
        RecSalesHeader.SetRange("Document Type", Enum::"Sales Document Type"::Order);
        RecSalesHeader.SetRange("No.", 'S-ORD101019');
        if RecSalesHeader.FindFirst() then
            "Send a PayLink"(RecSalesHeader);
    end;

    procedure "Send a PayLink"(var RecSalesHeader: Record "Sales Header")
    var
        Success: Boolean;
    begin
        if RecSalesHeader.FindSet() then begin
            RecSalesHeader.nodPFPaymentAmount := 2;
            RecSalesHeader."Nodus PayLink Trx Type" := RecSalesHeader."Nodus PayLink Trx Type"::Authorization;
            RecSalesHeader."Nodus EMail Address" := 'support@nodus.com';
            Success := SendPayLink.SendPayLink(RecSalesHeader, PFTransaction);
        end;
    end;
}
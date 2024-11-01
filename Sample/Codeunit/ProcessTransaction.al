codeunit 50110 "Process PF Transaction"
{

    var
        RecSalesHeader: Record "Sales Header";
        RecPaymentMethod: Record "Payment Method";
        ProcessTransaction: Codeunit "Nodus PF Process Transaction";
        PFTransaction: Record nodPFTransactions;

    procedure Main()
    begin
        Clear(RecSalesHeader);
        RecSalesHeader.SetRange("Document Type", Enum::"Sales Document Type"::Order);
        RecSalesHeader.SetRange("No.", 'S-ORD101019'); // Assume this sales order's payment method code has associated PayFabric Gateway Profile
        if RecSalesHeader.FindFirst() then begin
            // Authorization
            "Process Authorization Transaction"(RecSalesHeader);
            // Sale
            "Process Sale Transaction"(RecSalesHeader);
            // Capture
            "Process Capture Transaction"(RecSalesHeader);
            // Void
            "Process Void Transaction"(RecSalesHeader);
            // Non-reference Refund
            "Process NonReference Refund Transaction"(RecSalesHeader);
            // Refund
            "Process Reference Refund Transaction"(RecSalesHeader);
        end;
    end;

    procedure "Process Sale Transaction"(var RecSalesHeader: Record "Sales Header")
    var
        Success: Boolean;
    begin
        RecSalesHeader.nodPFTransactionType := 'Sale';
        RecSalesHeader.nodPFPaymentAmount := 2;
        Success := ProcessTransaction.ProcessTransaction(RecSalesHeader, PFTransaction);
    end;

    procedure "Process Authorization Transaction"(var RecSalesHeader: Record "Sales Header")
    var
        Success: Boolean;
    begin
        RecSalesHeader.nodPFTransactionType := 'Authorization';
        RecSalesHeader.nodPFPaymentAmount := 2;
        Success := ProcessTransaction.ProcessTransaction(RecSalesHeader, PFTransaction);
    end;

    procedure "Process Capture Transaction"(var RecSalesHeader: Record "Sales Header")
    var
        Success: Boolean;
        ProcessPFTransaction: Codeunit "Nodus PF Process Transaction";
    begin
        RecSalesHeader.nodPFTransactionType := 'Capture';
        RecSalesHeader."Nodus PF Trx Key" := '24103101477596'; // Original Authorization Transaction Key
        RecSalesHeader.nodPFPaymentAmount := 2; // Custom capture amount
        Success := ProcessPFTransaction.ProcessTransaction(RecSalesHeader, PFTransaction);
        // PFTransaction --> return succeed capture transaction record
        // RecSalesHeader --> return BC Sales Header record with calculated PF Payment Amount
    end;

    procedure "Process Void Transaction"(var RecSalesHeader: Record "Sales Header")
    var
        Success: Boolean;
    begin
        RecSalesHeader.nodPFTransactionType := 'Void';
        RecSalesHeader."Nodus PF Trx Key" := '24103101477596';
        Success := ProcessTransaction.ProcessTransaction(RecSalesHeader, PFTransaction);
    end;

    procedure "Process Reference Refund Transaction"(var RecSalesHeader: Record "Sales Header")
    var
        Success: Boolean;
    begin
        RecSalesHeader.nodPFTransactionType := 'Refund';
        RecSalesHeader."Nodus PF Trx Key" := '24103101477596';
        Success := ProcessTransaction.ProcessTransaction(RecSalesHeader, PFTransaction);
    end;

    procedure "Process NonReference Refund Transaction"(var RecSalesHeader: Record "Sales Header")
    var
        Success: Boolean;
    begin
        RecSalesHeader.nodPFTransactionType := 'Refund';
        RecSalesHeader.nodPFPaymentAmount := 2;
        Success := ProcessTransaction.ProcessTransaction(RecSalesHeader, PFTransaction);
    end;
}
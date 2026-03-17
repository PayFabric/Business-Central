codeunit 50113 "Nodus PF Payment Request"
{
    var
        NodusPFPaymentRequest: Codeunit "Nod Pmt. Processing Automation";

    procedure AuthorizationBeforeRelease(var SalesHeader: Record "Sales Header")
    var
        pErrorMsg: Text;
        Result: Boolean;
    begin
        Result := NodusProcessingAutomation.AuthorizationBeforeRelease(SalesHeader, true);
        if not Result then begin
            Error('Test failed, unexpected error message: ' + pErrorMsg);
        end;
    end;

    procedure CaptureOnPost(var SalesHeader: Record "Sales Header")
    var
        pErrorMsg: Text;
        Result: Boolean;
    begin
        Result := NodusProcessingAutomation.CaptureOnPost(SalesHeader, true);
        if not Result then begin
            Error('Test failed, unexpected error message: ' + pErrorMsg);
        end;
    end;
}
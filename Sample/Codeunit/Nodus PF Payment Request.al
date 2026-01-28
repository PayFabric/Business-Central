codeunit 50112 "Nodus PF Payment Request"
{
    var
        NodusPFPaymentRequest: Codeunit "Nodus PF Payment Request";

    procedure SendSinglePaymentRequestWithEmail(var SalesInvHeader: Record "Sales Invoice Header")
    var
        TemplateName: Code[200]; // Optional. If empty, it will be taken from the system default.
        Email: Text[250]; // Optional. If empty, it will be taken from SalesInvHeader.
        AdditionalEmails: Text[2048]; // Optional. If empty, it will be taken from SalesInvHeader.
        pErrorMsg: Text;
        Success: Boolean;
    begin
        TemplateName := 'SinglePaymentRequestTemplate';
        Email:='TestAccount1@google.com';
        AdditionalEmails:='TestAccount2@google.com';
        if SalesInvHeader.FindFirst() then
            Success:=NodusPFPaymentRequest.SendSinglePaymentRequestWithEmailSendType(SalesInvHeader,TemplateName,Email,AdditionalEmails,pErrorMsg);
    end;

    procedure SendMultiplePaymentRequestWithEmail(var SalesInvHeader: Record "Sales Invoice Header")
    var
        TemplateName: Code[200]; // Optional. If empty, it will be taken from the system default.
        Email: Text[250]; // Optional. If empty, it will be taken from SalesInvHeader.
        AdditionalEmails: Text[2048]; // Optional. If empty, it will be taken from SalesInvHeader.
        pErrorMsg: Text;
        Success: Boolean;
    begin
        TemplateName := 'MultiplePaymentRequestTemplate';
        Email:='TestAccount1@google.com';
        AdditionalEmails:='TestAccount2@google.com';
        if SalesInvHeader.FindSet() then
            Success:=NodusPFPaymentRequest.SendMultiplePaymentRequestWithEmailSendType(SalesInvHeader,TemplateName,Email,AdditionalEmails,pErrorMsg);
    end;

    procedure BatchSendSinglePaymentRequestWithEmail(var SalesInvHeader: Record "Sales Invoice Header")
    var
        TemplateName: Code[200]; // Optional. If empty, it will be taken from the system default.
        pErrorMsg: Text;
        Success: Boolean;
    begin
        TemplateName := 'SinglePaymentRequestTemplate';
        if SalesInvHeader.FindSet() then
            Success:=NodusPFPaymentRequest.BatchSendSinglePaymentRequestWithEmailSendType(SalesInvHeader,TemplateName,pErrorMsg);
    end;

    procedure SendPaymentRequestWithLink(var SalesInvHeader: Record "Sales Invoice Header")
    var
        pErrorMsg: Text;
        PaymentLink: Text;
    begin
        if SalesInvHeader.FindSet() then
            PaymentLink:=NodusPFPaymentRequest.SendPaymentRequestWithLinkSendType(SalesInvHeader,pErrorMsg);
    end;
}
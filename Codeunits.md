# Public Codeunits
Provide codeunits and APIs for third-party developers interested in utilizing PayFabric for Business Central 

- - -

## "Nodus PF Process Transaction" (Codeunit 70117037)
This codeunit provide the function to process PayFabric Transaction in Sales Order/Invoice for third-party developers

  * ### ProcessTransaction (Method)
    Use this method to process and save differenct types of transaction. 

    * #### Syntax
      ```al
      procedure ProcessTransaction(var SalesHeader: Record "Sales Header"; var PayFabricTransaction: Record nodPFTransactions) Success: Boolean
      ```
    * #### Parameters      
      *SalesHeader(Record "Sales Header")*

      BC Sales Order/Invoice source table object

      * ##### `SalesHeader` Record Attribute

        Attribute | Data Type | Required | Definition
        ---- | ---- | ---- | ----
        No. | Code[20] | Y | The document number in Sales Header
        Document Type | Enum "Sales Document Type" | Y | Only accept `Order` and `Invoice` Type
        Bill-to Customer No. | Code[20] | Y | The bill-to customer number
        Payment Method Code | Code[10] | Y | The Payment Method Code
        nodPFTransactionType | Text | Y | PayFabric Transaction Type only accept `Sale`, `Authorization`, `Capture`, `Void`, `Refund`. For more information on PayFabric Transaction Types, click [here](https://github.com/PayFabric/APIs/blob/master/PayFabric/Sections/Transaction%20Types.md).
        nodPFPaymentAmount | Decimal | Conditional | Payment Amount required for `Sale`, `Authorization`, `Capture`, and `Non-Reference Refund`
        nodWalletID | Code[50] | Conditional | PayFabric Wallet ID required for `Sale`, `Authorization`, and `Non-Reference Refund`
        Nodus PF Trx Key | Code[50] | Conditional | PayFabric Transaction Key required for `Capture`, `Void`, and `Reference Refund`
        Nodus EMail Address | Text | N | EMail Address must be a single valid email address
        Nodus Additional Emails | Text | N | Additional Emails accept multiple email addresses
        Nodus Schedule Type | Option | N | PayFabric Schedule Type only accept `Unscheduled`,`Installment`,`Recurring`
        Nodus Entry Class | Enum "Nodus Entry Class" | N | Entry Class is only used for EVO ACH
        Nodus Invoice Type | Code[40] | N | Invoice Type is used for PayFabric Receivables
    
      *PayFabricTransaction(Record nodPFTransactions)*

      The succeeded processed and saved PF transactions object

    * #### Return Value    
      Success: `True`, Failed: `False`

- - -

## "Nodus PF Create PayLink" (Codeunit 70117038)
This codeunit provide the function to Send a PayLink in Sales Order/Invoice for third-party developers

  * ### SendPayLink (Method)
    Use this method to send a PayLink to an email or phone number and save it.

    * #### Syntax
    ```al
    procedure SendPayLink(var SalesHeader: Record "Sales Header"; var PayFabricTransaction: Record nodPFTransactions) Success: Boolean
    ```
    * #### Parameters      
      *SalesHeader(Record "Sales Header")*

      BC Sales Order/Invoice source table object
        
      * ##### `SalesHeader` Record Attribute

        Attribute | Data Type | Required | Definition
        ---- | ---- | ---- | ----
        No. | Code[20] | Y | The document number in Sales Header
        Document Type | Enum "Sales Document Type" | Y | Only accept `Order` and `Invoice` Type
        Bill-to Customer No. | Code[20] | Y | The bill-to customer number
        Payment Method Code | Code[10] | N | The Payment Method Code      
        nodPFPaymentAmount | Decimal | Y | PayLink Amount      
        Nodus EMail Address | Text | Y | EMail Address must be a single valid email address
        Nodus Additional Emails | Text | N | Additional Emails accept multiple email addresses
        Nodus PayLink Trx Type | Option | Y | Credit Card transaction type accept `Sale` and `Authorization`. ACH transaction type accept `Sale`
        Nodus PayLink CC Gateway | Text | Conditional | Payment gateway account profile name for credit card payments. Either PayLink CC or eCheck Gateway needs to be selected. If both CC and eCheck Gateway are blank, use default gateway based on selected Payment Method Code.
        Nodus PayLink eCheck Gateway | Text | Conditional | Payment gateway account profile name for eCheck payments. Either PayLink CC or eCheck Gateway needs to be selected. If both CC and eCheck Gateway are blank, use default gateway based on selected Payment Method Code.
        Nodus Phone | Text | N | Ignore this field if `Allow PayLink SMS` is disabled
        Nodus Invoice Type | Code[40] | N | Invoice Type is used for PayFabric Receivables

      *PayFabricTransaction(Record nodPFTransactions)*

      The succeeded created and saved PayLink transactions object

    * #### Return Value    
      Success: `True`, Failed: `False`

- - - 

## "Nodus PF Transaction Integr." (Codeunit 70117039)
This codeunit provide the function to integrate PayFabric Transactions and PayLinks into Business Central for third-party developers

  * ### PayFabricTransactionIntegration (Method)
    Use this method to call BC PayFabric POST API to integrate PayFabric Transactions and PayLink into BC.

      * #### Syntax
      ```al
      procedure PayFabricTransactionIntegration(PayFabricTransactionKey: Text; DocumentType: Enum "Nodus PF Trx Document Type"; DocumentID: Text; Service: Enum "Nodus Service"; var PayFabricTransaction: Record nodPFTransactions)
      ```

      * #### Parameters        
        *PayFabricTransactionKey(Text)*
        
        PayFabric Transaction Key or PayLink ID

        *DocumentType(Enum "Nodus PF Trx Document Type")* 
        
        PayFabric Transaction Document Type only accept `Order`, `Invoice` and `CashReceiptJournalPayment`

        *DocumentID(Text)*
        
        The Sale Order/Invoice document number

        *Service(Enum "Nodus Service")*
        
        Service only accept `PayFabric` and `PayLink`

        *PayFabricTransaction(Record nodPFTransactions)* 

        The succeeded integrated and saved PayFabric Transaction or PayLink     

- - - 

## "Nodus PF Populate Defaults" (Codeunit 70117042)
This codeunit provide the function to populate default PayFabric fields in Business Central for third-party developers

  * ### PopulateDefaultPayFabricFields (Method)
    This method populate all default PF fields such as default wallet, default email addresses, default invoice type and so on for existing Sales Order/Invoice and save it. If you want to check all of these fields, you can find it under PayFabric section of Sales Order/Invoice page.

    * #### Syntax
      ```al
      procedure PopulateDefaultPayFabricFields(var SalesHeader: Record "Sales Header")
      ```

    * #### Parameters
      *SalesHeader(Record "Sales Header")*

      The BC Sales Order/Invoice source table object

      * ##### `SalesHeader` Record Attribute

        Attribute | Data Type | Required | Definition
        ---- | ---- | ---- | ----
        No. | Code[20] | Y | The document number in Sales Header, if it is blank take no action
        Document Type | Enum "Sales Document Type" | Y | Only accept `Order` and `Invoice` Type, if not take no action
        Bill-to Customer No. | Code[20] | Y | The bill-to customer number, if it is blank take no action
        Payment Method Code | Code[10] | Y | The Payment Method Code, if it is blank take no action

- - -

## "Nodus PF Record Payments" (Codeunit 70117045)
This codeunit provide the function to record processed PayFabric Capture/Sale Transactions in Cash Receipt Journals for third-party developers

  * ### RecordPayments (Method)
    Use this method to record processed PayFabric Capture/Sale Transactions. 

    * #### Syntax
      ```al
      procedure RecordPayments(PayFabricTransactionKey: Text; SalesHeader: Record "Sales Header")
      ```
    * #### Parameters      
      *PayFabricTransactionKey(Text)*

      The key of PayFabric Capture/Sale transaction

      *SalesHeader(Record "Sales Header")*

      BC Sales Order/Invoice source table object


    * #### Example

    ```al
    procedure ProcessMultipleRecordPayments(RecSalesHeader: Record "Sales Header")
    var
        PayFabricTransactions: Record nodPFTransactions;
        RecordPaymentCodeUnit: Codeunit "Nodus PF Record Payments";
    begin
        if not RecSalesHeader.FindFirst() then
            Error('The document was not found');
        Clear(PayFabricTransactions);
        PayFabricTransactions.SetRange(DocumentNo, RecSalesHeader."No.");
        PayFabricTransactions.SetRange(DocumentType, PayFabricTransactions.DocumentType::Order);
        // Only approved Sale or Capture transaction can be recorded on Cash Receipt Journals
        PayFabricTransactions.SetRange(Status, PayFabricTransactions.Status::Approved);
        PayFabricTransactions.SetFilter(TransactionType, '%1|%2', PayFabricTransactions.TransactionType::Capture, PayFabricTransactions.TransactionType::Sale);
        PayFabricTransactions.SetRange("Cash Entry Created", false);  // 'false' means the payment has not been created on Cash Receipt Journals for this transaction
        if PayFabricTransactions.FindSet() then
            repeat
                RecordPaymentCodeUnit.RecordPayments(PayFabricTransactions.TransactionKey, RecSalesHeader);
            until PayFabricTransactions.Next() = 0;
    end;
    ```
- - -

## "Nodus PF Sales Quote" (Codeunit 70117047)
This codeunit provide the function to retrieve processed transactions from Sales Quote in Sales Order/Invoice for third-party developers

  * ### RetrieveSalesQuoteTrx (Method)
    Use this method to retrieve processed transactions from Sales Quote in Sales Order/Invoice.

    * #### Syntax
      ```al
      procedure RetrieveSalesQuoteTrx(SalesHeader: Record "Sales Header")
      ```
    * #### Parameters      
      *SalesHeader(Record "Sales Header")*

      BC Sales Order/Invoice source table object


    * #### Example

    ```al
    procedure RetrieveSalesQuoteTrxTest(RecSalesHeader: Record "Sales Header")
    var
        SalesQuoteUnit: Codeunit "Nodus PF Sales Quote";
    begin
        SalesQuoteUnit.RetrieveSalesQuoteTrx(RecSalesHeader);
    end;
    ```
    
- - -

## "Nodus PF Outgoing Records Mgr." (Codeunit 70117048)
Help third-party partners develop using Nodus Codeunit to add a queue on the PayFabric Outgoing Records.

  * ### AddNewPFOutgoingQueue (Method)
    Use this method to add a new PF Outgoing record for a customer ledger entry record.

    * #### Syntax
      ```al
      procedure AddNewPFOutgoingQueue(CustLedgerEntryRec: Record "Cust. Ledger Entry")
      ```
    * #### Parameters      
      *CustLedgerEntryRec: Record "Cust. Ledger Entry"*

      BC Customer Ledger Entry source table object


    * #### Example

    ```al
    procedure AddOneInvoiceToPFOutgoing()
    var
        CustLedgerEntryRec: Record "Cust. Ledger Entry";
        EntryNo: Integer;
        NodPFOutgoing: Codeunit "Nodus PF Outgoing Records Mgr.";
    begin
        EntryNo := 4172;
        Clear(CustLedgerEntryRec);
        if CustLedgerEntryRec.Get(EntryNo) then
            NodPFOutgoing.AddNewPFOutgoingQueue(CustLedgerEntryRec);
    end;
    ```


## "Nodus PF Payment Request." (Codeunit 70117054)
Third-party partner developers can use this Codeunit to generate payment requests for posted Sales invoice.

  * ### SendSinglePaymentRequestWithEmailSendType (Method)
    Use this method to send a payment request containing only one invoice.

    * #### Syntax
      ```al
      procedure SendSinglePaymentRequestWithEmailSendType(var SalesInvHeader: Record "Sales Invoice Header"; TemplateName: Code[200]; Email: Text[250]; AdditionalEmails: Text[2048]; var pErrorMsg: Text): Boolean
      ```
    * #### Parameters      
      *SalesInvHeader: Record "Sales Invoice Header"*

      The posted sales invoice table object contains only one invoice record.
      The number of invoices in the SalesInvHeader is equal to 1.

      *TemplateName:  Code[200]*

      The name of payment request template. If empty, use default "Single" template type

      *Email: Text[250]*

      The email address. If empty, use posted sales invoice's email address

      *AdditionalEmails: Text[2048]*

      The additional email addresses. If empty, use posted sales invoice's additional emails
      
      *pErrorMsg:  Text*

      A field used to store error messages.

    * #### Return Value    
      Success: `True`, Failed: `False`

    * #### Example

    ```al
    procedure SendSinglePaymentRequestWithEmail()
    var
        SalesInvHeader: Record "Sales Invoice Header";
        TemplateName: Code[200];
        Email: Text[250];
        AdditionalEmails: Text[2048];
        pErrorMsg: Text;
        NodusPFPaymentRequest: Codeunit "Nodus PF Payment Request";
        Result: Boolean;
    begin
        clear(pErrorMsg);
        TemplateName := 'SinglePaymentRequestTemplate';
        Email:='TestAccount1@google.com';
        AdditionalEmails:='TestAccount2@google.com';
        Result:=NodusPFPaymentRequest.SendSinglePaymentRequestWithEmailSendType(SalesInvHeader,TemplateName,Email,AdditionalEmails,pErrorMsg);
        if not Result then begin
            Error('Test failed, unexpected error message: ' + pErrorMsg);
        end;

    end;
    ```

* ### SendMultiplePaymentRequestWithEmailSendType (Method)
    Use this method to send a payment request containing multiple invoices.

    * #### Syntax
      ```al
      procedure SendMultiplePaymentRequestWithEmailSendType(var SalesInvHeader: Record "Sales Invoice Header"; TemplateName: Code[200]; Email: Text[250]; AdditionalEmails: Text[2048]; var pErrorMsg: Text): Boolean
      ```
    * #### Parameters      
      *SalesInvHeader: Record "Sales Invoice Header"*

      The posted sales invoice table object contains more than one invoice record with same customer and same currency.

      *TemplateName:  Code[200]*

      The name of payment request template. If empty, use default "Multiple" template type

      *Email: Text[250]*

      The email address. If empty, use posted sales invoice's email address

      *AdditionalEmails: Text[2048]*

      The additional email addresses. If empty, use posted sales invoice's additional emails

      *pErrorMsg:  Text*

      A field used to store error messages.
    * #### Return Value    
      Success: `True`, Failed: `False`

    * #### Example

    ```al
    procedure SendMultiplePaymentRequestWithEmail()
    var
        SalesInvHeader: Record "Sales Invoice Header";
        TemplateName: Code[200];
        Email:Text[250];
        AdditionalEmails:Text[2048];
        pErrorMsg:Text;
        NodusPFPaymentRequest: Codeunit "Nodus PF Payment Request";
        Result: Boolean;
    begin
        clear(pErrorMsg);
        TemplateName := 'MultiplePaymentRequestTemplate';
        Email:='TestAccount1@google.com';
        AdditionalEmails:='TestAccount2@google.com';
        Result:=NodusPFPaymentRequest.SendMultiplePaymentRequestWithEmailSendType(SalesInvHeader,TemplateName,Email,AdditionalEmails,pErrorMsg);
        if not Result then begin
            Error('Test failed, unexpected error message: ' + pErrorMsg);
        end;

    end;
    ```

* ### BatchSendSinglePaymentRequestWithEmailSendType (Method)
    Use this method to send a payment request containing multiple different customers and multiple currencies.

    * #### Syntax
      ```al
      procedure BatchSendSinglePaymentRequestWithEmailSendType(var SalesInvHeader: Record "Sales Invoice Header"; TemplateName: Code[200]; var pErrorMsg: Text): Boolean
      ```
    * #### Parameters      
      *SalesInvHeader: Record "Sales Invoice Header"*

      The posted sales invoice table object contains more than one invoice record.
      The invoices in the SalesInvHeader must have the not same Customer or not same Currency.

      *TemplateName:  Code[200]*

      The name of payment request template. If empty, use default "Single" template type

      *pErrorMsg:  Text*

      A field used to store error messages.
    * #### Return Value    
      Success: `True`, Failed: `False`

    * #### Example

    ```al
    procedure BatchSendSinglePaymentRequestWithEmail()
    var
        SalesInvHeader: Record "Sales Invoice Header";
        TemplateName: Code[200];
        pErrorMsg: Text;
        NodusPFPaymentRequest: Codeunit "Nodus PF Payment Request";
        Result: Boolean;
    begin
        clear(pErrorMsg);
        TemplateName := 'SinglePaymentRequestTemplate';
        Result:=NodusPFPaymentRequest.BatchSendSinglePaymentRequestWithEmailSendType(SalesInvHeader,TemplateName,pErrorMsg);
        if not Result then begin
            Error('Test failed, unexpected error message: ' + pErrorMsg);
        end;

    end;
    ```

* ### SendPaymentRequestWithLinkSendType (Method)
    Use this method to create payment request links that include one or more invoices.

    * #### Syntax
      ```al
      procedure SendPaymentRequestWithLinkSendType(var SalesInvHeader: Record "Sales Invoice Header"; var pErrorMsg: Text): Text
      ```
    * #### Parameters      
      *SalesInvHeader: Record "Sales Invoice Header"*

      The posted sales invoice table object with same Customer and same Currency.
      
      *pErrorMsg:  Text*

      A field used to store error messages.
    * #### Return Value    
      PaymentRequestLink: Text

    * #### Example

    ```al
    procedure SendPaymentRequestWithLink()
    var
        SalesInvHeader: Record "Sales Invoice Header";
        PaymentLink: Text;
        pErrorMsg: Text;
        NodusPFPaymentRequest: Codeunit "Nodus PF Payment Request";
    begin
        clear(pErrorMsg);
        clear(PaymentLink);
        PaymentLink:=NodusPFPaymentRequest.SendPaymentRequestWithLinkSendType(SalesInvHeader,pErrorMsg);
        if PaymentLink='' then begin
            Error('Test failed, unexpected error message: ' + pErrorMsg);
        end;

    end;
    ```
## "Nod Pmt. Processing Automation" (Codeunit 70117055)
Third-party partner developers to automatically initialize Authorization transactions upon document release and Capture transactions upon posting for documents with pending authorizations via codeunit.

  * ### AuthorizationBeforeRelease (Method)
    Use this method to send a payment request containing only one invoice.

    * #### Syntax
      ```al
      procedure AuthorizationBeforeRelease(var SalesHeader: Record "Sales Header"; IsAutomatic: Boolean; var ErrorMsg: Text): Boolean
      ```
    * #### Parameters      
      *SalesHeader: Record "Sales Header"*

        The BC Sales Order/Invoice source table object

        * ##### `SalesHeader` Record Attribute

          Attribute | Data Type | Required | Definition
          ---- | ---- | ---- | ----
          No. | Code[20] | Y | The document number in Sales Header, if it is blank then will throw error.
          Document Type | Enum "Sales Document Type" | Y | Only accept `Order` and `Invoice` Type, if not then will throw error.

      *IsAutomatic:  Boolean*

        if true will use Automatic; if not will use configured setting on PF setup page.

      *ErrorMsg:  Text*

        A field used to store error messages.

    * #### Return Value    
      Success: `True`, Failed: `False`

    * #### Example

    ```al
    procedure AuthorizationBeforeRelease()
    var
        SalesHeader: Record "Sales Header";
        NodusProcessingAutomation: Codeunit "Nod Pmt. Processing Automation";
        Result: Boolean;
    begin
        Result:=NodusProcessingAutomation.AuthorizationBeforeRelease(SalesHeader,true);
        if not Result then begin
            Error('Test failed, unexpected error message: ' + pErrorMsg);
        end;

    end;
    ```
* ### CaptureOnPost (Method)
    Use this method to send a payment request containing only one invoice.

    * #### Syntax
      ```al
      procedure CaptureOnPost(var SalesHeader: Record "Sales Header"; IsAutomatic: Boolean; var ErrorMsg: Text): Boolean
      ```
    * #### Parameters      
      *SalesHeader: Record "Sales Header"*

        The BC Sales Order/Invoice source table object

        * ##### `SalesHeader` Record Attribute

          Attribute | Data Type | Required | Definition
          ---- | ---- | ---- | ----
          No. | Code[20] | Y | The document number in Sales Header, if it is blank then will throw error.
          Document Type | Enum "Sales Document Type" | Y | Only accept `Order` and `Invoice` Type, if not then will throw error.

      *IsAutomatic:  Boolean*

        if true will use Automatic; if not will use configured setting on PF setup page.

      *ErrorMsg:  Text*

        A field used to store error messages.

    * #### Return Value    
      Success: `True`, Failed: `False`

    * #### Example

    ```al
    procedure CaptureOnPost()
    var
        SalesHeader: Record "Sales Header";
        NodusProcessingAutomation: Codeunit "Nod Pmt. Processing Automation";
        Result: Boolean;
    begin
        Result:=NodusProcessingAutomation.CaptureOnPost(SalesHeader,true);
        if not Result then begin
            Error('Test failed, unexpected error message: ' + pErrorMsg);
        end;

    end;
    ```
- - -


# Public Codeunits
Provide codeunits and APIs for third-party developers interested in utilizing PayFabric for Business Central 

- - -

## "Nodus PF Process Transaction" (Codeunit 70117037)
This codeunit provided useful functions to process PayFabric Transaction in PayFabric for BC for partners developers

  * ### ProcessTransaction (Method)
    Use this method to process and save differenct types of transaction. 

    * #### Syntax
      ```
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
This codeunit provided useful functions to Send a PayLink in PayFabric for BC for partners developers

  * ### SendPayLink (Method)
    Use this method to send a PayLink to an email or phone number and save it.

    * #### Syntax
    ```
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
This codeunit provided useful functions to integrate PayFabric Transactions and PayLinks into BC for partners developers

  * ### PayFabricTransactionIntegration (Method)
    Use this method to call BC PayFabric POST API to integrate PayFabric Transactions and PayLink into BC.

      * #### Syntax
      ```
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
This codeunit provided useful functions in PayFabric for BC for third-party partners developers.

  * ### PopulateDefaultPayFabricFields (Method)
    This method populate all default PF fields such as default wallet, default email addresses, default invoice type and so on for existing Sales Order/Invoice and save it. If you want to check all of these fields, you can find it under PayFabric section of Sales Order/Invoice page.

    * #### Syntax
      ```
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
This codeunit provided useful functions to record processed PayFabric Capture/Sale Transactions in Cash Receipt Journals for BC partner developers

  * ### RecordPayments (Method)
    Use this method to record processed PayFabric Capture/Sale Transactions. 

    * #### Syntax
      ```CAL
      procedure RecordPayments(PayFabricTransactionKey: Text; SalesHeader: Record "Sales Header")
      ```
    * #### Parameters      
      *PayFabricTransactionKey(Text)*

      The key of PayFabric Capture/Sale transaction

      *SalesHeader(Record "Sales Header")*

      BC Sales Order/Invoice source table object


    * #### Example

    ```CAL
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

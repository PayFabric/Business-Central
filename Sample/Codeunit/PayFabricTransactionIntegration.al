codeunit 50112 "PF Trx Integration"
{
    Description = 'Test PayFabric Transaction Integration';

    var
        PayFabricTrxIntegration: Codeunit "Nodus PF Transaction Integr.";
        PayFabricTransaction: Record nodPFTransactions;

    /// <summary>
    /// Import PayFabric transaction into BC
    /// </summary>
    procedure "Integrate PayFabric Transaction"()
    var
        TransactionKey: Text;
        DocNo: Text;
    begin
        TransactionKey := '24100801461562';
        DocNo := 'S-ORD101009';
        PayFabricTrxIntegration.PayFabricTransactionIntegration(TransactionKey, Enum::"Nodus PF Trx Document Type"::Order, DocNo, Enum::"Nodus Service"::PayFabric, PayFabricTransaction);
    end;

    /// <summary>
    /// Import PayLink into BC
    /// </summary>
    procedure "Integrate PayLink"()
    var
        PayLinkID: Text;
        DocNo: Text;
    begin
        PayLinkID := 's8c1PcuvvEqGKSFgGtTEHzE';
        DocNo := 'S-ORD101009';
        PayFabricTrxIntegration.PayFabricTransactionIntegration(PayLinkID, Enum::"Nodus PF Trx Document Type"::Order, DocNo, Enum::"Nodus Service"::PayLink, PayFabricTransaction);
    end;
}
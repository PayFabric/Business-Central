Transaction Integration POST API
============

The Transaction Integration API allows for transactions processed on PayFabric outside of Business Central to be connected to Business Central Sales Orders, Sales Invoices and Cash Receipt Journal Payments.

---------
The following process would be a typical scenario for utilizing this API:

- A transaction is processed on PayFabric from another application and PayFabric will return a PayFabric Transaction Key. 
- The application uses the Business Central API to create a Sales Order, Sales Invoice or a Cash Receipt Journal Payment. 
- The application uses the Business Central Transaction Integration POST API to connect the PayFabric Transaction to the created Sales Order, Sales Invoice or Cash Receipt Journal Payment. 

After the process is complete, the integrated transaction record should behave as if it was processed directly from within Business Central. This will allow for cases such as pending authorizations to be captured in Business Central and processed transactions to be reversed in Business Central.

#### HTTP Request
Replace the URL prefix for Dynamics 365 Business Central depending on the environment by following the Microsoft [guidelines](https://learn.microsoft.com/en-us/dynamics365/business-central/dev-itpro/api-reference/v2.0/).
```
POST businesscentralPrefix/Nodus/PayFabric/v5.0/companies(id)/PFTransactions
```

#### Request Headers
For information on how to get the OAuth 2.0 Token can be found [here](https://learn.microsoft.com/en-us/dynamics365/business-central/dev-itpro/administration/automation-apis-using-s2s-authentication). 
| Header | Value |
| :------------- | :------------- | 
| Authorization | Bearer {OAuth 2.0 Token}, Required |
| Content-Type | application/json |

#### Request Body
In the request body, supply a JSON representation of a PFTransactions object. The following values are available for this API. 
| Property | Type | Maximum size | Required | Description |
| :------------- | :------------- |  :------------- |  :------------- |  :------------- | 
| PayFabricTransactionKey | String | 20 | Y | The PayFabric Transaction Key from the PayFabric Processed Transaction. |
| DocumentType | String | 30 | Y | The type of the document to connect the PayFabric transaction with. Allowed values: `Order`,	`Invoice`,	`CashReceiptJournalPayment` |
| DocumentID | String | 20 | Y | The identifier for the document to be connected with the PayFabric transaction. |
| Service | String | 10 | N | The PayFabric service that the PayFabric Transaction originates from. If blank, the default value is set to “PayFabric”. Allowed values: `PayFabric`, `PayLink` |

#### Request Body
If successful, this method returns a 201 Created response code and a PFTransactions object in the response body.

#### Example

```json
{
	"PayFabricTransactionKey": "20030900043767",
	"DocumentType": "Invoice",
	"DocumentID": "S-INV102222",
	"Service": "PayFabric"
}
```


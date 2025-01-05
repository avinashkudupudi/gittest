global with sharing class PD1_InvoiceUtilities {
	//Class to remember line items for invoices
	// Returns a string that indicates success or failure
	webservice static String renumberLineItems(String invoiceName) {

		// Create a copy of the target Invoice object and its Line Items.

		Invoice__c invoice = 
			[Select i.Name, (Select Name from Line_items__r order by Name) 
			from Invoice__c i 
			where i.Name = :invoiceName Limit 1];

		// Loop through each Line Item, re-numbering as you go
		Integer i = 1;
		for(Line_Item__c item : invoice.Line_items__r) {
			item.Name = String.valueOf(i);
			System.debug(item.Name);
			i++;
		}

		// Update the Line Items in one transaction, rollback if any problems
		// and return error messages to the calling environment.
		try {
			Database.Update(invoice.Line_Items__r);
		}

		catch (DmlException e) {
			return e.getMessage();
		}

		// On success, return a message to the calling program.
		return 'Lineitems renumbered successfully.';

	}
}
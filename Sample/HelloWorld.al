// Welcome to your new AL extension.
// Remember that object names and IDs should be unique across all extensions.
// AL snippets start with t*, like tpageext - give them a try and happy coding!

pageextension 50100 SalesOrderExt extends "Sales Order"
{
    trigger OnOpenPage();
    begin
        Message('App published: Hello world');
    end;
}
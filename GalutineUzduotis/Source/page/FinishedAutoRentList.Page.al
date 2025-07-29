page 77013 "ZINUFinished Auto Rent List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = History;
    SourceTable = ZINUFinishedAutoRentHeader;
    Caption = 'Finished Auto Rent Contracts';
    CardPageId = "ZINUFinished Auto Rent Card";
    Editable = false;

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field("Customer No."; Rec."Customer No.")
                {
                    ApplicationArea = All;
                }
                field("Date"; Rec.Date)
                {
                    ApplicationArea = All;
                }
                field("Auto No."; Rec."Auto No.")
                {
                    ApplicationArea = All;
                }
                field("Reserved From Date"; Rec."Reserved From Date")
                {
                    ApplicationArea = All;
                }
                field("Reserved To Date"; Rec."Reserved To Date")
                {
                    ApplicationArea = All;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}

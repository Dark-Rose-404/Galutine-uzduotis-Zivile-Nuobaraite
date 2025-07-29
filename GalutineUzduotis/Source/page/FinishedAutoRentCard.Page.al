page 77014 "ZINUFinished Auto Rent Card"
{
    PageType = Document;
    ApplicationArea = All;
    SourceTable = ZINUFinishedAutoRentHeader;
    Caption = 'Finished Auto Rent Contract';
    Editable = false;

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';

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
            group("Driver License")
            {
                Caption = 'Driver License';

                field("Driver License Picture"; Rec."Driver License Picture")
                {
                    ApplicationArea = All;
                }
            }
            part(FinishedAutoRentLines; "ZINUFin Auto Rent Line Subform")
            {
                ApplicationArea = All;
                SubPageLink = "Document No." = field("No.");
            }
        }
    }
}

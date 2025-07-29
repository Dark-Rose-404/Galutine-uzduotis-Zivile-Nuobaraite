page 77015 "ZINUFin Auto Rent Line Subform"
{
    PageType = ListPart;
    ApplicationArea = All;
    SourceTable = ZINUFinishedAutoRentLine;
    Caption = 'Lines';
    Editable = false;

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field(Type; Rec.Type)
                {
                    ApplicationArea = All;
                }
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = All;
                }
                field("Unit Price"; Rec."Unit Price")
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

page 77009 "ZINUReleased Auto Rent List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = ZINUAutoRentHeader;
    Caption = 'Released Auto Rent Contracts';
    SourceTableView = where(Status = const(Released));
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

    actions
    {
        area(Processing)
        {
            action("Return Auto")
            {
                Caption = 'Return Auto';
                ApplicationArea = All;
                Image = Return;
                ToolTip = 'Return Auto';

                trigger OnAction()
                var
                    AutoRentMgt: Codeunit "ZINUAuto Rent Management";
                begin
                    AutoRentMgt.ReturnAuto(Rec);
                end;
            }
        }
    }
}

page 77006 "ZINUActive Reservations List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = ZINUAutoReservation;
    Caption = 'Active Reservations';

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Auto No."; Rec."Auto No.")
                {
                    ApplicationArea = All;
                }
                field("Line No."; Rec."Line No.")
                {
                    ApplicationArea = All;
                }
                field("Customer No."; Rec."Customer No.")
                {
                    ApplicationArea = All;
                }
                field("Reserved From Date Time"; Rec."Reserved From Date Time")
                {
                    ApplicationArea = All;
                }
                field("Reserved To Date Time"; Rec."Reserved To Date Time")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    trigger OnOpenPage()
    begin
        Rec.SetFilter("Reserved From Date Time", '>=%1', CreateDateTime(WorkDate(), 000000T));
    end;
}

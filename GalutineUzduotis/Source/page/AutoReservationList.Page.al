page 77005 "ZINUAuto Reservation List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = None;
    SourceTable = ZINUAutoReservation;
    Caption = 'Auto Reservations';

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
}

page 77003 "ZINUAuto List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = ZINUAuto;
    Caption = 'Automobiles';
    CardPageId = "ZINUAuto Card";

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
                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                }
                field(Mark; Rec.Mark)
                {
                    ApplicationArea = All;
                }
                field(Model; Rec.Model)
                {
                    ApplicationArea = All;
                }
                field("Manufacturing Year"; Rec."Manufacturing Year")
                {
                    ApplicationArea = All;
                }
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = All;
                }
                field("Rental Service"; Rec."Rental Service")
                {
                    ApplicationArea = All;
                }
                field("Rental Price"; Rec."Rental Price")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(Navigation)
        {
            action(Reservations)
            {
                Caption = 'Reservations';
                ApplicationArea = All;
                Image = Reserve;
                RunObject = page "ZINUAuto Reservation List";
                RunPageLink = "Auto No." = field("No.");
                ToolTip = 'Reservations';
            }
            action(Damages)
            {
                Caption = 'Damages';
                ApplicationArea = All;
                Image = Warning;
                RunObject = page "ZINUAuto Damage List";
                RunPageLink = "Auto No." = field("No.");
                ToolTip = 'Damages';
            }
        }
        area(Reporting)
        {
            action("Rental History")
            {
                Caption = 'Rental History';
                ApplicationArea = All;
                Image = History;
                ToolTip = 'Rental History';

                trigger OnAction()
                var
                    Auto: Record ZINUAuto;
                    AutoRentalHistoryReport: Report "ZINUAuto Rental History";
                begin
                    Auto := Rec;
                    Auto.SetRecFilter();
                    AutoRentalHistoryReport.SetTableView(Auto);
                    AutoRentalHistoryReport.Run();
                end;
            }
        }
    }
}

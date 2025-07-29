page 77004 "ZINUAuto Card"
{
    PageType = Card;
    ApplicationArea = All;
    SourceTable = ZINUAuto;
    Caption = 'Auto Card';

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
                field("Civil Insurance Valid Until"; Rec."Civil Insurance Valid Until")
                {
                    ApplicationArea = All;
                }
                field("Technical Inspection Until"; Rec."Technical Inspection Until")
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



/*
                field(2; "Automobile No. Series";
                    Code[20])
        {
            Caption = 'Automobile No. Series';
                    DataClassification = CustomerContent;
                    TableRelation = "No. Series";
                }
                field(3; "Rental Card Series";
                    Code[20])
        {
            Caption = 'Rental Card Series';
                    DataClassification = CustomerContent;
                    TableRelation = "No. Series";
                }
                field(4; "Accessories Location";
                    Code[10])
        {
            Caption = 'Accessories Location';
                    DataClassification = CustomerContent;
                    TableRelation = Location;
                }
            }

    keys
    {
        key(PK; "Primary Key")
        {
            Clustered = true;
        }
    }
}
*/

page 77008 "ZINUAuto Rent List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = ZINUAutoRentHeader;
    Caption = 'Auto Rent Contracts';
    CardPageId = "ZINUAuto Rent Card";
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
                field(Status; Rec.Status)
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
            action(Release)
            {
                Caption = 'Release';
                ApplicationArea = All;
                Image = ReleaseDoc;
                Enabled = Rec.Status = Rec.Status::Open;
                ToolTip = 'Release';

                trigger OnAction()
                begin
                    Rec.Status := Rec.Status::Released;
                    Rec.Modify();
                    CurrPage.Update();
                end;
            }
            action("Return Auto")
            {
                Caption = 'Return Auto';
                ApplicationArea = All;
                Image = Return;
                Enabled = Rec.Status = Rec.Status::Released;
                ToolTip = 'Return Auto';

                trigger OnAction()
                var
                    AutoRentMgt: Codeunit "ZINUAuto Rent Management";
                begin
                    AutoRentMgt.ReturnAuto(Rec);
                end;
            }
        }
        area(Reporting)
        {
            action("Print Contract")
            {
                Caption = 'Print Contract';
                ApplicationArea = All;
                Image = Print;
                ToolTip = 'Print Contract';

                trigger OnAction()
                var
                    AutoRentHeader: Record ZINUAutoRentHeader;
                    AutoRentReport: Report "ZINUAuto Rent Contract";
                begin
                    AutoRentHeader := Rec;
                    AutoRentHeader.SetRecFilter();
                    AutoRentReport.SetTableView(AutoRentHeader);
                    AutoRentReport.Run();
                end;
            }
        }
    }
}

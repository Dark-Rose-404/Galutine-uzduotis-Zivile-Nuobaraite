page 77000 "ZINUAuto Setup"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = ZINUAutoSetup;
    Caption = 'Auto Setup';
    InsertAllowed = false;
    DeleteAllowed = false;

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';

                field("Primary Key"; Rec."Primary Key")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Automobile No. Series"; Rec."Automobile No. Series")
                {
                    ApplicationArea = All;
                }
                field("Rental Card Series"; Rec."Rental Card Series")
                {
                    ApplicationArea = All;
                }
                field("Accessories Location"; Rec."Accessories Location")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    trigger OnOpenPage()
    begin
        Rec.Reset();
        if not Rec.Get() then begin
            Rec.Init();
            Rec."Primary Key" := '';
            Rec.Insert();
        end;
    end;
}

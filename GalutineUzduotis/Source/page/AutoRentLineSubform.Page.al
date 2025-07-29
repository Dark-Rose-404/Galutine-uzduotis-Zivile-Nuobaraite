page 77011 "ZINUAuto Rent Line Subform"
{
    PageType = ListPart;
    ApplicationArea = All;
    SourceTable = ZINUAutoRentLine;
    Caption = 'Auto Rent Lines';

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

    /* actions
    {
        area(Processing)
        {
            action(DeleteLine)
            {
                Caption = 'Delete Line';
                ApplicationArea = All;
                Image = Delete;
                Enabled = not IsRentalServiceLine();

                trigger OnAction()
                begin
                    if not IsRentalServiceLine() then
                        Rec.Delete(true);
                end;
            }
        }
    }

    local procedure IsRentalServiceLine(): Boolean
    var
        AutoRentHeader: Record ZINUAutoRentHeader;
        Auto: Record ZINUAuto;
    begin
        // Check if this is the rental service line
        if AutoRentHeader.Get(Rec."Document No.") then begin
            if AutoRentHeader."Auto No." <> '' then begin
                Auto.Get(AutoRentHeader."Auto No.");
                exit((Rec.Type = Rec.Type::Resource) and (Rec."No." = Auto."Rental Service") and (Rec."Line No." = 10000));
            end;
        end;
        exit(false);
    end; */




}

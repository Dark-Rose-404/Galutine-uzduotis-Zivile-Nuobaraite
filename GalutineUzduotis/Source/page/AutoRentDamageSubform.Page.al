page 77012 "ZINUAuto Rent Damage Subform"
{
    PageType = ListPart;
    ApplicationArea = All;
    SourceTable = ZINUAutoRentDamage;
    Caption = 'Damages';

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Date"; Rec.Date)
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}

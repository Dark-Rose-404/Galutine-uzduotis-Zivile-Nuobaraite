page 77002 "ZINUAuto Model List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = ZINUAutoModel;
    Caption = 'Auto Models';

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Mark Code"; Rec."Mark Code")
                {
                    ApplicationArea = All;
                }
                field("Code"; Rec."Code")
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

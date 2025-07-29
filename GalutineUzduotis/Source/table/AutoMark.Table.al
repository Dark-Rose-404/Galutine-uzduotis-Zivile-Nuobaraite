table 77001 ZINUAutoMark
{
    Caption = 'Auto Mark';
    DataClassification = CustomerContent;
    LookupPageId = "ZINUAuto Mark List";
    DrillDownPageId = "ZINUAuto Mark List";

    fields
    {
        field(1; "Code"; Code[20])
        {
            Caption = 'Code';
            DataClassification = CustomerContent;
            ToolTip = 'Code';
        }
        field(2; Description; Text[100])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the automobile description';
        }
    }

    keys
    {
        key(PK; "Code")
        {
            Clustered = true;
        }
    }
}

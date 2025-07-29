table 77002 ZINUAutoModel
{
    Caption = 'Auto Model';
    DataClassification = CustomerContent;
    LookupPageId = "ZINUAuto Model List";
    DrillDownPageId = "ZINUAuto Model List";

    fields
    {
        field(1; "Mark Code"; Code[20])
        {
            Caption = 'Mark Code';
            DataClassification = CustomerContent;
            TableRelation = ZINUAutoMark;
            ToolTip = 'Mark Code';
        }
        field(2; "Code"; Code[20])
        {
            Caption = 'Code';
            DataClassification = CustomerContent;
            ToolTip = 'Code';
        }
        field(3; Description; Text[100])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the automobile description';
        }
    }

    keys
    {
        key(PK; "Mark Code", "Code")
        {
            Clustered = true;
        }
    }
}

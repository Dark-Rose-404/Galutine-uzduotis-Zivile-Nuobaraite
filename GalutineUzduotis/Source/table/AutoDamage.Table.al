table 77005 ZINUAutoDamage
{
    Caption = 'Auto Damage';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Auto No."; Code[20])
        {
            Caption = 'Auto No.';
            DataClassification = CustomerContent;
            TableRelation = ZINUAuto;
            ToolTip = 'Auto No.';
        }
        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.';
            DataClassification = CustomerContent;
            ToolTip = 'Line No.';
        }
        field(3; "Date"; Date)
        {
            Caption = 'Date';
            DataClassification = CustomerContent;
            ToolTip = 'Date';
        }
        field(4; Description; Text[250])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
            ToolTip = 'Description';
        }
        field(5; Status; Enum "ZINUAuto Damage Status")
        {
            Caption = 'Status';
            DataClassification = CustomerContent;
            ToolTip = 'Status';
        }
    }

    keys
    {
        key(PK; "Auto No.", "Line No.")
        {
            Clustered = true;
        }
    }

    trigger OnInsert()
    var
        AutoDamage: Record ZINUAutoDamage;
        LastLineNo: Integer;
    begin
        if "Line No." = 0 then begin
            AutoDamage.SetRange("Auto No.", "Auto No.");

            if AutoDamage.FindLast() then
                LastLineNo := AutoDamage."Line No."
            else
                LastLineNo := 0;

            "Line No." := LastLineNo + 1000;
        end;
    end;
}

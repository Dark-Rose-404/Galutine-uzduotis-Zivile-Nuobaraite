table 77008 ZINUAutoRentDamage
{
    Caption = 'Auto Rent Damage';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Document No."; Code[20])
        {
            Caption = 'Document No.';
            DataClassification = CustomerContent;
            TableRelation = ZINUAutoRentHeader;
            ToolTip = 'Document No.';
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
    }

    keys
    {
        key(PK; "Document No.", "Line No.")
        {
            Clustered = true;
        }
    }
    trigger OnInsert()
    var
        AutoDamage: Record ZINUAutoRentDamage;
        LastLineNo: Integer;
    begin
        if "Line No." = 0 then begin
            AutoDamage.SetRange("Document No.", "Document No.");

            if AutoDamage.FindLast() then
                LastLineNo := AutoDamage."Line No."
            else
                LastLineNo := 0;

            "Line No." := LastLineNo + 1000;
        end;
    end;
}

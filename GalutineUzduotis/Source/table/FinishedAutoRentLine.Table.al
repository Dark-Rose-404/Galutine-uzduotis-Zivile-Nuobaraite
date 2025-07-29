table 77010 ZINUFinishedAutoRentLine
{
    Caption = 'Finished Auto Rent Line';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Document No."; Code[20])
        {
            Caption = 'Document No.';
            DataClassification = CustomerContent;
            TableRelation = ZINUFinishedAutoRentHeader;
            ToolTip = 'Document No.';
        }
        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.';
            DataClassification = CustomerContent;
            ToolTip = 'Line No.';
        }
        field(3; Type; Enum "ZINUAuto Rent Line Type")
        {
            Caption = 'Type';
            DataClassification = CustomerContent;
            Editable = false;
            ToolTip = 'Type';
        }
        field(4; "No."; Code[20])
        {
            Caption = 'No.';
            DataClassification = CustomerContent;
            Editable = false;
            ToolTip = 'No.';
        }
        field(5; Description; Text[100])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
            Editable = false;
            ToolTip = 'Description';
        }
        field(6; Quantity; Decimal)
        {
            Caption = 'Quantity';
            DataClassification = CustomerContent;
            DecimalPlaces = 0 : 5;
            Editable = false;
            ToolTip = 'Quantity';
        }
        field(7; "Unit Price"; Decimal)
        {
            Caption = 'Unit Price';
            DataClassification = CustomerContent;
            Editable = false;
            ToolTip = 'Unit Price';
        }
        field(8; Amount; Decimal)
        {
            Caption = 'Amount';
            DataClassification = CustomerContent;
            Editable = false;
            ToolTip = 'Amount';
        }
    }

    keys
    {
        key(PK; "Document No.", "Line No.")
        {
            Clustered = true;
        }
    }
}

table 77009 ZINUFinishedAutoRentHeader
{
    Caption = 'Finished Auto Rent Header';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            DataClassification = CustomerContent;
            ToolTip = 'No.';
        }
        field(2; "Customer No."; Code[20])
        {
            Caption = 'Customer No.';
            DataClassification = CustomerContent;
            TableRelation = Customer;
            Editable = false;
            ToolTip = 'Customer No.';
        }
        field(3; "Driver License Picture"; Media)
        {
            Caption = 'Driver License Picture';
            DataClassification = CustomerContent;
            Editable = false;
            ToolTip = 'Driver License Picture';
        }
        field(4; "Date"; Date)
        {
            Caption = 'Date';
            DataClassification = CustomerContent;
            Editable = false;
            ToolTip = 'Date';
        }
        field(5; "Auto No."; Code[20])
        {
            Caption = 'Auto No.';
            DataClassification = CustomerContent;
            TableRelation = ZINUAuto;
            Editable = false;
            ToolTip = 'Auto No.';
        }
        field(6; "Reserved From Date"; Date)
        {
            Caption = 'Reserved From Date';
            DataClassification = CustomerContent;
            Editable = false;
            ToolTip = 'Reserved From Date';
        }
        field(7; "Reserved To Date"; Date)
        {
            Caption = 'Reserved To Date';
            DataClassification = CustomerContent;
            Editable = false;
            ToolTip = 'Reserved To Date';
        }
        field(8; Amount; Decimal)
        {
            Caption = 'Amount';
            FieldClass = FlowField;
            CalcFormula = sum(ZINUFinishedAutoRentLine.Amount where("Document No." = field("No.")));
            Editable = false;
            ToolTip = 'Amount';
        }
    }

    keys
    {
        key(PK; "No.")
        {
            Clustered = true;
        }
    }
}

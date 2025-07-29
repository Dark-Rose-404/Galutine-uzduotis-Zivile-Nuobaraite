table 77000 ZINUAutoSetup
{
    Caption = 'Auto Setup';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            Caption = 'Primary Key';
            DataClassification = CustomerContent;
            ToolTip = 'Primary Key';
        }
        field(2; "Automobile No. Series"; Code[20])
        {
            Caption = 'Automobile No. Series';
            DataClassification = CustomerContent;
            TableRelation = "No. Series";
            ToolTip = 'Automobile No. Series';
        }
        field(3; "Rental Card Series"; Code[20])
        {
            Caption = 'Rental Card Series';
            DataClassification = CustomerContent;
            TableRelation = "No. Series";
            ToolTip = 'Rental Card Series';
        }
        field(4; "Accessories Location"; Code[10])
        {
            Caption = 'Accessories Location';
            DataClassification = CustomerContent;
            TableRelation = Location;
            ToolTip = 'Accessories Location';
        }
    }

    keys
    {
        key(PK; "Primary Key")
        {
            Clustered = true;
        }
    }
}

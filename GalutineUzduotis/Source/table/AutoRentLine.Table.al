table 77007 ZINUAutoRentLine
{
    Caption = 'Auto Rent Line';
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
        field(3; Type; Enum "ZINUAuto Rent Line Type")
        {
            Caption = 'Type';
            DataClassification = CustomerContent;
            ToolTip = 'Type';
        }
        field(4; "No."; Code[20])
        {
            Caption = 'No.';
            DataClassification = CustomerContent;
            TableRelation = if (Type = const(Item)) Item else if (Type = const(Resource)) Resource;
            ToolTip = 'No.';

            trigger OnValidate()
            var
                Item: Record Item;
                Resource: Record Resource;
            begin
                case Type of
                    Type::Item:
                        begin
                            Item.Get("No.");
                            Description := Item.Description;
                            "Unit Price" := Item."Unit Price";
                        end;
                    Type::Resource:
                        begin
                            Resource.Get("No.");
                            Description := Resource.Name;
                            "Unit Price" := Resource."Unit Price";
                        end;
                end;

                CalcAmount();
            end;
        }
        field(5; Description; Text[100])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
            ToolTip = 'Description';
        }
        field(6; Quantity; Decimal)
        {
            Caption = 'Quantity';
            DataClassification = CustomerContent;
            DecimalPlaces = 0 : 5;
            ToolTip = 'Quantity';

            trigger OnValidate()
            begin
                CalcAmount();
            end;
        }
        field(7; "Unit Price"; Decimal)
        {
            Caption = 'Unit Price';
            DataClassification = CustomerContent;
            Editable = false;
            ToolTip = 'Unit Price';

            trigger OnValidate()
            begin
                CalcAmount();
            end;
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
        key(Key1; "Document No.")
        {
            SumIndexFields = Amount;
        }
    }

    trigger OnInsert()
    var
        AutoRentLine: Record ZINUAutoRentLine;
    begin
        if "Line No." = 0 then begin
            AutoRentLine.SetRange("Document No.", "Document No.");
            if AutoRentLine.FindLast() then
                "Line No." := AutoRentLine."Line No." + 1000
            else
                "Line No." := 1000;
        end;
    end;

    // Add trigger to prevent deletion of rental service lines
    trigger OnDelete()
    var
        AutoRentHeader: Record ZINUAutoRentHeader;
        Auto: Record ZINUAuto;
        CannotDeleteRentalServiceErr: Label 'Cannot delete the rental service line.';
    begin
        // Check if this is the rental service line by comparing with header's auto rental service
        if AutoRentHeader.Get("Document No.") then
            if AutoRentHeader."Auto No." <> '' then begin
                Auto.Get(AutoRentHeader."Auto No.");
                if (Type = Type::Resource) and ("No." = Auto."Rental Service") and ("Line No." = 10000) then
                    Error(CannotDeleteRentalServiceErr);
            end;
    end;

    local procedure CalcAmount()
    begin
        Amount := Quantity * "Unit Price";
    end;
}

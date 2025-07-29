table 77004 ZINUAutoReservation
{
    Caption = 'Auto Reservation';
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
        field(3; "Customer No."; Code[20])
        {
            Caption = 'Customer No.';
            DataClassification = CustomerContent;
            TableRelation = Customer;
            ToolTip = 'Customer No.';
        }
        field(4; "Reserved From Date Time"; DateTime)
        {
            Caption = 'Reserved From Date Time';
            DataClassification = CustomerContent;
            ToolTip = 'Reserved From Date Time';

            trigger OnValidate()
            begin
                CheckReservationOverlap();
            end;
        }
        field(5; "Reserved To Date Time"; DateTime)
        {
            Caption = 'Reserved To Date Time';
            DataClassification = CustomerContent;
            ToolTip = 'Reserved To Date Time';

            trigger OnValidate()
            begin
                CheckReservationOverlap();
            end;
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
        AutoReservation: Record ZINUAutoReservation;
        LastLineNo: Integer;
    begin
        if "Line No." = 0 then begin
            AutoReservation.SetRange("Auto No.", "Auto No.");

            if AutoReservation.FindLast() then
                LastLineNo := AutoReservation."Line No."
            else
                LastLineNo := 0;

            "Line No." := LastLineNo + 1000;
        end;
    end;


    local procedure CheckReservationOverlap()
    var
        AutoReservation: Record ZINUAutoReservation;
        OverlapErr: Label 'Reservation period overlaps with existing reservation.';
        InvalidRangeErr: Label 'Reservation end time cannot be earlier than the start time.';
    begin
        if ("Reserved From Date Time" = 0DT) or ("Reserved To Date Time" = 0DT) then
            exit;

        if ("Reserved To Date Time" < "Reserved From Date Time") then
            Error(InvalidRangeErr);

        AutoReservation.SetRange("Auto No.", "Auto No.");
        AutoReservation.SetFilter("Line No.", '<>%1', "Line No.");
        if AutoReservation.FindSet() then
            repeat
                if (("Reserved From Date Time" >= AutoReservation."Reserved From Date Time") and
                    ("Reserved From Date Time" <= AutoReservation."Reserved To Date Time")) or
                   (("Reserved To Date Time" >= AutoReservation."Reserved From Date Time") and
                    ("Reserved To Date Time" <= AutoReservation."Reserved To Date Time")) then
                    Error(OverlapErr);
            until AutoReservation.Next() = 0;
    end;

}

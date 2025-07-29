table 77006 ZINUAutoRentHeader
{
    Caption = 'Auto Rent Header';
    DataClassification = CustomerContent;
    LookupPageId = "ZINUAuto Rent List";
    DrillDownPageId = "ZINUAuto Rent List";

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            DataClassification = CustomerContent;
            ToolTip = 'No.';

            trigger OnValidate()
            var
                AutoSetup: Record ZINUAutoSetup;
                NoSeriesMgt: Codeunit "No. Series";
            begin
                if "No." <> xRec."No." then begin
                    AutoSetup.Get();
                    NoSeriesMgt.TestManual(AutoSetup."Rental Card Series");
                    "No. Series" := '';
                end;
            end;
        }
        field(10; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            DataClassification = CustomerContent;
            TableRelation = "No. Series";
            ToolTip = 'No. Series';
        }
        field(2; "Customer No."; Code[20])
        {
            Caption = 'Customer No.';
            DataClassification = CustomerContent;
            TableRelation = Customer;
            ToolTip = 'Customer No.';

            trigger OnValidate()
            var
                Customer: Record Customer;
                CustLedgEntry: Record "Cust. Ledger Entry";
                CustomerBalance: Decimal;
                CustomerBlockedErr: Label 'Customer is blocked.';
                CustomerDebtErr: Label 'Customer has outstanding debt.';
            begin
                if "Customer No." = '' then
                    exit;

                Customer.Get("Customer No.");
                if Customer.Blocked <> Customer.Blocked::" " then
                    Error(CustomerBlockedErr);

                CustLedgEntry.SetRange("Customer No.", "Customer No.");
                CustLedgEntry.CalcFields(Amount);
                CustomerBalance := CustLedgEntry.Amount;

                if CustomerBalance > 0 then
                    Error(CustomerDebtErr);
            end;
        }
        field(3; "Driver License Picture"; Media)
        {
            Caption = 'Driver License Picture';
            DataClassification = CustomerContent;
            ToolTip = 'Driver License Picture';
        }
        field(4; "Date"; Date)
        {
            Caption = 'Date';
            DataClassification = CustomerContent;
            ToolTip = 'Date';
        }
        field(5; "Auto No."; Code[20])
        {
            Caption = 'Auto No.';
            DataClassification = CustomerContent;
            TableRelation = ZINUAuto;
            ToolTip = 'Auto No.';

            trigger OnValidate()
            var
                AutoRentLine: Record ZINUAutoRentLine;
                Auto: Record ZINUAuto;
                LineNo: Integer;
            begin
                if "Auto No." = '' then begin
                    // Delete existing rental service line when Auto No. is cleared
                    AutoRentLine.SetRange("Document No.", "No.");
                    AutoRentLine.SetRange("Line No.", 10000);
                    AutoRentLine.SetRange(Type, AutoRentLine.Type::Resource);
                    if AutoRentLine.FindFirst() and (xRec."Auto No." <> '') then
                        if Auto.Get(xRec."Auto No.") then
                            if AutoRentLine."No." = Auto."Rental Service" then
                                AutoRentLine.Delete();
                    exit;
                end;

                Auto.Get("Auto No.");
                Auto.CalcFields("Rental Price");

                // Delete existing rental service line first (line 10000 with rental service)
                AutoRentLine.SetRange("Document No.", "No.");
                AutoRentLine.SetRange("Line No.", 10000);
                AutoRentLine.SetRange(Type, AutoRentLine.Type::Resource);
                if AutoRentLine.FindFirst() then
                    // Check if it's a rental service from previous auto
                    if (xRec."Auto No." <> '') then begin
                        if Auto.Get(xRec."Auto No.") then
                            if AutoRentLine."No." = Auto."Rental Service" then
                                AutoRentLine.Delete();
                    end else
                        AutoRentLine.Delete();      // toto

                // Create new rental service line (always at line 10000)
                LineNo := 10000;

                AutoRentLine.Init();
                AutoRentLine."Document No." := "No.";
                AutoRentLine."Line No." := LineNo;
                AutoRentLine.Type := AutoRentLine.Type::Resource;
                AutoRentLine."No." := Auto."Rental Service";
                AutoRentLine.Validate("No.");
                AutoRentLine.Validate(Quantity, 1);
                AutoRentLine.Insert(true);
            end;
        }
        field(6; "Reserved From Date"; Date)
        {
            Caption = 'Reserved From Date';
            DataClassification = CustomerContent;
            ToolTip = 'Reserved From Date';

            trigger OnValidate()
            begin
                CheckReservationMatch();
            end;
        }
        field(7; "Reserved To Date"; Date)
        {
            Caption = 'Reserved To Date';
            DataClassification = CustomerContent;
            ToolTip = 'Reserved To Date';

            trigger OnValidate()
            begin
                CheckReservationMatch();
            end;
        }
        field(8; Amount; Decimal)
        {
            Caption = 'Amount';
            FieldClass = FlowField;
            CalcFormula = sum(ZINUAutoRentLine.Amount where("Document No." = field("No.")));
            Editable = false;
            ToolTip = 'Amount';
        }
        field(9; Status; Enum "ZINUAuto Rent Status")
        {
            Caption = 'Status';
            DataClassification = CustomerContent;
            Editable = false;
            ToolTip = 'Status';
        }
    }

    keys
    {
        key(PK; "No.")
        {
            Clustered = true;
        }
    }

    trigger OnInsert()
    var
        AutoSetup: Record ZINUAutoSetup;
        NoSeries: Codeunit "No. Series";
    begin
        if "No." = '' then begin
            AutoSetup.Get();
            AutoSetup.TestField("Rental Card Series");
            "No." := NoSeries.GetNextNo(AutoSetup."Rental Card Series", Today, true);
        end;

        Date := Today();
        Status := Status::Open;
    end;

    local procedure CheckReservationMatch()
    var
        AutoReservation: Record ZINUAutoReservation;
        ReservationNotFoundErr: Label 'No matching reservation found for the specified period.';
    begin
        if ("Auto No." = '') or ("Reserved From Date" = 0D) or ("Reserved To Date" = 0D) then
            exit;

        AutoReservation.SetRange("Auto No.", "Auto No.");
        AutoReservation.SetRange("Customer No.", "Customer No.");
        AutoReservation.SetFilter("Reserved From Date Time", '<=%1', CreateDateTime("Reserved From Date", 0T));
        AutoReservation.SetFilter("Reserved To Date Time", '>=%1', CreateDateTime("Reserved To Date", 235959T));

        if AutoReservation.IsEmpty() then
            Error(ReservationNotFoundErr);
    end;
}

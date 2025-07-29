table 77003 ZINUAuto
{
    Caption = 'Auto';
    DataClassification = CustomerContent;
    LookupPageId = "ZINUAuto List";
    DrillDownPageId = "ZINUAuto List";

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
                    NoSeriesMgt.TestManual(AutoSetup."Automobile No. Series");
                    "No. Series" := '';
                end;
            end;
        }
        field(2; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            DataClassification = CustomerContent;
            TableRelation = "No. Series";
            ToolTip = 'No. Series';
        }
        field(3; Name; Text[100])
        {
            Caption = 'Name';
            DataClassification = CustomerContent;
            ToolTip = 'Name';
        }
        field(4; Mark; Code[20])
        {
            Caption = 'Mark';
            DataClassification = CustomerContent;
            TableRelation = ZINUAutoMark;
            ToolTip = 'Mark';
        }
        field(5; Model; Code[20])
        {
            Caption = 'Model';
            DataClassification = CustomerContent;
            TableRelation = ZINUAutoModel."Code" where("Mark Code" = field(Mark));
            ToolTip = 'Model';
        }
        field(6; "Manufacturing Year"; Integer)
        {
            Caption = 'Manufacturing Year';
            DataClassification = CustomerContent;
            ToolTip = 'Manufacturing Year';
        }
        field(7; "Civil Insurance Valid Until"; Date)
        {
            Caption = 'Civil Insurance Valid Until';
            DataClassification = CustomerContent;
            ToolTip = 'Civil Insurance Valid Until';
        }
        field(8; "Technical Inspection Until"; Date)
        {
            Caption = 'Technical Inspection Until';
            DataClassification = CustomerContent;
            ToolTip = 'Technical Inspection Until';
        }
        field(9; "Location Code"; Code[10])
        {
            Caption = 'Location Code';
            DataClassification = CustomerContent;
            TableRelation = Location;
            ToolTip = 'Location Code';
        }
        field(10; "Rental Service"; Code[20])
        {
            Caption = 'Rental Service';
            DataClassification = CustomerContent;
            TableRelation = Resource;
            ToolTip = 'Rental Service';
        }
        field(11; "Rental Price"; Decimal)
        {
            Caption = 'Rental Price';
            FieldClass = FlowField;
            CalcFormula = lookup(Resource."Unit Price" where("No." = field("Rental Service")));
            Editable = false;
            ToolTip = 'Rental Price';
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
            AutoSetup.TestField("Automobile No. Series");
            "No." := NoSeries.GetNextNo(AutoSetup."Automobile No. Series", Today, true);
        end;
    end;
}

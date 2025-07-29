page 77010 "ZINUAuto Rent Card"
{
    PageType = Document;
    ApplicationArea = All;
    SourceTable = ZINUAutoRentHeader;
    Caption = 'Auto Rent Contract';

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';

                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    Editable = Rec.Status = Rec.Status::Open;
                }
                field("Customer No."; Rec."Customer No.")
                {
                    ApplicationArea = All;
                    Editable = Rec.Status = Rec.Status::Open;

                    trigger OnValidate()
                    begin
                        CurrPage.Update();
                    end;
                }
                field("Date"; Rec.Date)
                {
                    ApplicationArea = All;
                    Editable = Rec.Status = Rec.Status::Open;
                }
                field("Auto No."; Rec."Auto No.")
                {
                    ApplicationArea = All;
                    Editable = Rec.Status = Rec.Status::Open;

                    trigger OnValidate()
                    begin
                        CurrPage.AutoRentLines.Page.Update();
                    end;
                }
                field("Reserved From Date"; Rec."Reserved From Date")
                {
                    ApplicationArea = All;
                    Editable = Rec.Status = Rec.Status::Open;
                }
                field("Reserved To Date"; Rec."Reserved To Date")
                {
                    ApplicationArea = All;
                    Editable = Rec.Status = Rec.Status::Open;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }
                field("Driver License Picture"; Rec."Driver License Picture")
                {
                    ApplicationArea = All;
                }
            }
            /* group("Driver License")
            {
                Caption = 'Driver License';

                field("Driver License Picture"; Rec."Driver License Picture")
                {
                    ApplicationArea = All;
                }
            } */
            part(AutoRentLines; "ZINUAuto Rent Line Subform")
            {
                ApplicationArea = All;
                SubPageLink = "Document No." = field("No.");
                UpdatePropagation = Both;
                Editable = Rec.Status = Rec.Status::Open;
            }
            part(AutoRentDamages; "ZINUAuto Rent Damage Subform")
            {
                ApplicationArea = All;
                SubPageLink = "Document No." = field("No.");
                UpdatePropagation = Both;
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(Release)
            {
                Caption = 'Release';
                ApplicationArea = All;
                Image = ReleaseDoc;
                Enabled = Rec.Status = Rec.Status::Open;
                ToolTip = 'Release';

                trigger OnAction()
                begin
                    Rec.Status := Rec.Status::Released;
                    Rec.Modify();
                    CurrPage.Update();
                end;
            }
            action(Reopen)
            {
                Caption = 'Reopen';
                ApplicationArea = All;
                Image = ReOpen;
                Enabled = Rec.Status = Rec.Status::Released;
                ToolTip = 'Reopen';

                trigger OnAction()
                begin
                    Rec.Status := Rec.Status::Open;
                    Rec.Modify();
                    CurrPage.Update();
                end;
            }
            action("Return Auto")
            {
                Caption = 'Return Auto';
                ApplicationArea = All;
                Image = Return;
                Enabled = Rec.Status = Rec.Status::Released;
                ToolTip = 'Return Auto';

                trigger OnAction()
                var
                    AutoRentMgt: Codeunit "ZINUAuto Rent Management";
                begin
                    AutoRentMgt.ReturnAuto(Rec);
                end;
            }
            group("Driver License Functions")
            {
                Caption = 'Driver License Functions';

                action("Upload Picture")
                {
                    Caption = 'Upload Picture';
                    ApplicationArea = All;
                    Image = Picture;
                    Enabled = Rec.Status = Rec.Status::Open;
                    ToolTip = 'Upload Picture';

                    trigger OnAction()
                    var
                        FileManagement: Codeunit "File Management";
                        TempBlob: Codeunit "Temp Blob";
                        InStr: InStream;
                        FileName: Text;
                    begin
                        FileName := FileManagement.BLOBImport(TempBlob, FileName);
                        if FileName <> '' then begin
                            TempBlob.CreateInStream(InStr);
                            Rec."Driver License Picture".ImportStream(InStr, FileName);
                            Rec.Modify();
                        end;
                    end;
                }
                action("Delete Picture")
                {
                    Caption = 'Delete Picture';
                    ApplicationArea = All;
                    Image = Delete;
                    Enabled = Rec.Status = Rec.Status::Open;
                    ToolTip = 'Delete Picture';

                    trigger OnAction()
                    begin
                        Clear(Rec."Driver License Picture");
                        Rec.Modify();
                    end;
                }
            }
        }
        area(Reporting)
        {
            action("Print Contract")
            {
                Caption = 'Print Contract';
                ApplicationArea = All;
                Image = Print;
                ToolTip = 'Print Contract';

                trigger OnAction()
                var
                    AutoRentHeader: Record ZINUAutoRentHeader;
                    AutoRentReport: Report "ZINUAuto Rent Contract";
                begin
                    AutoRentHeader := Rec;
                    AutoRentHeader.SetRecFilter();
                    AutoRentReport.SetTableView(AutoRentHeader);
                    AutoRentReport.Run();
                end;
            }
        }
    }
}

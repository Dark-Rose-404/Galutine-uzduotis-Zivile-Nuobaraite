report 77001 "ZINUAuto Rental History"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultRenderingLayout = LayoutName;

    dataset
    {
        dataitem(Auto; ZINUAuto)
        {
            column(Auto_No_; "No.")
            {
                IncludeCaption = true;
            }
            column(AutoMarkDescription; AutoMarkDescription)
            {
            }
            column(AutoModelDescription; AutoModelDescription)
            {
            }

            dataitem("Finished Auto Rent Header"; ZINUFinishedAutoRentHeader)
            {
                DataItemLink = "Auto No." = field("No.");
                column(Rental_No_; "No.")
                {
                    IncludeCaption = true;
                }
                column(Customer_No_; "Customer No.")
                {
                    IncludeCaption = true;
                }
                column(Customer_Name; CustomerName)
                {
                }
                column(Reserved_From_Date; "Reserved From Date")
                {
                    IncludeCaption = true;
                }
                column(Reserved_To_Date; "Reserved To Date")
                {
                    IncludeCaption = true;
                }
                column(Amount; Amount)
                {
                    IncludeCaption = true;
                }

                trigger OnAfterGetRecord()
                var
                    Customer: Record Customer;
                begin
                    if Customer.Get("Customer No.") then
                        CustomerName := Customer.Name;
                end;

                trigger OnPreDataItem()
                begin
                    if DateFrom <> 0D then
                        SetFilter("Reserved From Date", '>=%1', DateFrom);
                    if DateTo <> 0D then
                        SetFilter("Reserved To Date", '<=%1', DateTo);
                end;
            }

            trigger OnAfterGetRecord()
            var
                Auto: Record ZINUAuto;
                AutoMark: Record ZINUAutoMark;
                AutoModel: Record ZINUAutoModel;
            begin
                if Auto.Get("No.") then begin
                    if AutoMark.Get(Auto.Mark) then
                        AutoMarkDescription := AutoMark.Description;
                    if AutoModel.Get(Auto.Mark, Auto.Model) then
                        AutoModelDescription := AutoModel.Description;
                end;
            end;
        }
    }

    requestpage
    {
        AboutTitle = 'title';
        AboutText = 'about text';
        layout
        {
            area(Content)
            {
                group(Options)
                {
                    Caption = 'Options';
                    field(DateFromm; DateFrom)
                    {
                        ApplicationArea = All;
                        Caption = 'Date From';
                        ToolTip = 'Date From';
                    }
                    field(DateToo; DateTo)
                    {
                        ApplicationArea = All;
                        Caption = 'Date To';
                        ToolTip = 'Date To';
                    }
                }
            }
        }
    }
    rendering
    {
        layout(LayoutName)
        {
            Type = RDLC;
            LayoutFile = 'rdl/AutoRentalHistory.rdl';
        }
    }

    labels
    {
        ReportName = 'Auto Rental History';
        CustomerNameCap = 'Customer Name';
        AmountCap = 'Amount';
        GeneralAmountCap = 'General Amount:';
        AutoMarkCap = 'Auto Mark:';
        AutoModelCap = 'Auto Model:';
        AutoNoCap = 'Auto No.';
    }

    var
        DateFrom: Date;
        DateTo: Date;
        AutoMarkDescription: Text[100];
        AutoModelDescription: Text[100];
        CustomerName: Text[100];
}
